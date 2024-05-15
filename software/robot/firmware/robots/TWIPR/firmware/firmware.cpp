/*
 * firmware.cpp
 *
 *  Created on: Feb 13, 2023
 *      Author: lehmann_workstation
 */

#include "main.h"
#include "firmware_c.h"
#include "firmware.hpp"
#include <stdio.h>

const osThreadAttr_t firmware_task_attributes = { .name = "firmware",
		.stack_size = 2560 * 4, .priority = (osPriority_t) osPriorityNormal, };

TWIPR_Firmware twipr_firmware;

twipr_model_t twipr_model_small = { .m = 0, .r_wheel = 61.91 / 1000,
		.distance_wheels = 167.167 / 1000, .l_cg = 0, .l_imu = 0 };

osSemaphoreId_t sem = osSemaphoreNew(1, 1, NULL);

uint8_t test = 0;

void sample_dma_transfer_cmplt_callback(DMA_HandleTypeDef *hdma);

/* =======================================================*/
void firmware() {
	osThreadNew(firmware_task, (void*) &twipr_firmware,
			&firmware_task_attributes);
}

/* =======================================================*/
void firmware_task(void *argument) {
	TWIPR_Firmware *firmware = (TWIPR_Firmware*) argument;
	firmware->task = xTaskGetCurrentTaskHandle();
	firmware->task_function();
}

/* =======================================================*/
TWIPR_Firmware::TWIPR_Firmware() {

}

/* =======================================================*/
void TWIPR_Firmware::task_function() {
	this->init();
	this->start();

	while (true) {
//		led1.toggle();

		twipr_drive_speed_t speed = this->_drive.getSpeed();
		if (abs(speed.speed_left) > 50 || abs(speed.speed_right) > 50) {
			this->_control.stop();
		}
		osDelay(100);

	}
}

/* =======================================================*/
void TWIPR_Firmware::init() {

	uint8_t ret = 0;

	robot_control_init();
	robot_control_start();

	uint8_t button_pressed = 0;

	while (!button_pressed){
		uint8_t button_state = HAL_GPIO_ReadPin(GPIOC, GPIO_PIN_0);
		if (button_state == 0){
			button_pressed = 1;
		}
		osDelay(10);
	}
	rc_buzzer.setConfig(800, 500, 1);
	rc_buzzer.start();

	osDelay(250);
	// Initialize the communication module
	twipr_communication_config_t twipr_comm_config = { .huart = BOARD_CM4_UART,
			.hspi = BOARD_SPI_CM4, .notification_gpio_tx = core_utils_GPIO(
			GPIOE,
			GPIO_PIN_7), .reg_map_control = &this->_control.reg_map,
			.reg_map_general = &this->register_map, .sample_tx_buffer =
					this->_sample_buffer_tx, .len_sample_buffer =
			TWIPR_FIRMWARE_SAMPLE_BUFFER_SIZE, .trajectory_rx_buffer =
					this->_control.trajectory_rx_buffer,
			.len_trajectory_buffer = TWIPR_CONTROL_TRAJECTORY_BUFFER_SIZE };

	this->_comm.init(twipr_comm_config);
	this->_comm.registerCallback(TWIPR_COMM_CALLBACK_NEW_TRAJECTORY,
			core_utils_Callback<void, uint16_t>(&this->_control,
					&TWIPR_ControlManager::newTrajectoryReceived_callback));

	// Initilize the estimation module
	twipr_estimation_config_t twipr_estimation_config = {
			.drive = &this->_drive, .enable_slip_detection = 1,
			.enable_angle_threshold = 1, .angle_threshold = deg2rad(70.0),
			.model = twipr_model_small };

	this->_estimation.init(twipr_estimation_config);

	// Initialize the control module
	twipr_control_config_t twipr_control_config = { .estimation =
			&this->_estimation, .drive = &this->_drive, .max_torque =
	TWIPR_CONTROL_MAX_TORQUE, .freq = 100 };
	memcpy(twipr_control_config.K, twipr_control_default_K, sizeof(float) * 8);

	this->_control.init(twipr_control_config);
	this->_control.registerCallback(TWIPR_CONTROL_CALLBACK_STEP,
			core_utils_Callback<void, uint32_t>(this,
					&TWIPR_Firmware::_controlStep_callback));

	// Initialize the drive module
	if (TWIPR_FIRMWARE_USE_MOTORS) {
		twipr_drive_config_t twipr_drive_config = { .id_left = 1, .id_right = 2,
				.direction_left = -1, .direction_right = 1, .torque_max = 0.3,
				.modbus_config = { .huart = BOARD_RS485_UART, .EN_GPIOx =
				BOARD_RS485_UART_EN_GPIOx, .EN_GPIO_Pin =
				BOARD_RS485_UART_EN_GPIO_PIN, .hardware = MB_UART_DMA }, };

		this->_drive.init(twipr_drive_config);

		ret = this->_drive.startup_check();
		if (!ret) {
			nop();
		}
	}

//	float voltage = this->_drive.getVoltage();

// Initialize the supervisor module

// Initalize the data transfer to the compute module
	HAL_DMA_RegisterCallback(TWIPR_FIRMWARE_SAMPLE_DMA_STREAM,
			HAL_DMA_XFER_CPLT_CB_ID, sample_dma_transfer_cmplt_callback);

	// Register all communication register entries
//	this->reg_entries.firmware_state.set(0x01, &this->register_map,
//			&this->firmware_state, REGISTER_ENTRY_READ);
	this->reg_entries.test.set(0x02, &this->register_map, &test,
			REGISTER_ENTRY_READWRITE);

	// Reset the sample buffer index to zero, so that the communication starts here
	this->_sample_buffer_index = 0;

	core_utils_gpio_registerExtiCallback(GPIO_PIN_8,
			core_utils_Callback<void, void>(&this->_comm,
					&TWIPR_CommunicationManager::resetUART));

	core_utils_gpio_registerExtiCallback(GPIO_PIN_2,
			core_utils_Callback<void, void>(&this->_comm,
					&TWIPR_CommunicationManager::spi_pin_callback));

	// If everything ran until here: Beep and set the status LED to green
	rc_buzzer.setConfig(800, 500, 2);
	rc_buzzer.start();
	rc_rgb_led_status.setColor(0, 60, 0);
	rc_rgb_led_status.state(1);
}

/* =======================================================*/
void TWIPR_Firmware::start() {

	// Start the communication module
	this->_comm.start();

	// Start the estimation module
	this->_estimation.start();

	// Start the control module

	if (TWIPR_FIRMWARE_USE_MOTORS) {

		this->_control.start();
	}
}

/* =======================================================*/
void TWIPR_Firmware::step() {

	// Main State Machine
//	switch (this->firmware_state) {
//	case TWIPR_FIRMWARE_STATE_RESET: {
//		break;
//	}
//	case TWIPR_FIRMWARE_STATE_IDLE: {
//		break;
//	}
//	case TWIPR_FIRMWARE_STATE_RUNNING: {
//		break;
//	}
//	case TWIPR_FIRMWARE_STATE_ERROR: {
//		break;
//	}
//	}
}

/* =======================================================*/
void TWIPR_Firmware::_controlStep_callback(uint32_t tick) {

	this->tick = tick;

//	osSemaphoreAcquire(sem, 100);
	// Build the sample
	this->_sample_buffer[this->_sample_buffer_index].general.tick = this->tick;
	this->_sample_buffer[this->_sample_buffer_index].control =
			this->_control.getSample();
	this->_sample_buffer[this->_sample_buffer_index].estimation =
			this->_estimation.getSample();

	this->_sample_buffer_index++;

	if (this->_sample_buffer_index == TWIPR_FIRMWARE_SAMPLE_BUFFER_SIZE) {
		// Copy the sample buffer to the outgoing buffer
		HAL_DMA_Start_IT(TWIPR_FIRMWARE_SAMPLE_DMA_STREAM,
				(uint32_t) &this->_sample_buffer,
				(uint32_t) &this->_sample_buffer_tx,
				TWIPR_FIRMWARE_SAMPLE_BUFFER_SIZE
						* sizeof(twipr_logging_sample_t));
		this->_sample_buffer_index = 0;
	} else {
//		osSemaphoreRelease(sem);
	}

}

/* =======================================================*/
void TWIPR_Firmware::notifySampleBufferFull() {
	this->_comm.sampleBufferFull();
}

/* =======================================================*/
void sample_dma_transfer_cmplt_callback(DMA_HandleTypeDef *hdma) {
//	osSemaphoreRelease(sem);

	twipr_firmware.notifySampleBufferFull();
}
