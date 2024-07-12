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

uint8_t led_color_array[3] = { 0, 0, 100 };
void debug(uint8_t state);

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

	rc_rgb_led_side_1.setColor(0, 0, 0);
	rc_rgb_led_side_1.state(1);

	while (true) {

		if (this->_control.mode == TWIPR_CONTROL_MODE_OFF) {
			rc_rgb_led_side_1.setColor(100, 0, 0);
		} else if (this->_control.mode == TWIPR_CONTROL_MODE_BALANCING) {
			rc_rgb_led_side_1.setColor(0, 100, 0);
		}

		osDelay(250);
	}
}

/* =======================================================*/
void TWIPR_Firmware::init() {

	uint8_t ret = 0;

	robot_control_init();
	robot_control_start();

	rc_rgb_led_status.setColor(120, 40, 0);
	rc_rgb_led_status.state(1);

//	while (side_button.check()){
//		osDelay(10);
//	}

	rc_buzzer.setConfig(800, 250, 1);
	rc_buzzer.start();

	osDelay(250);
	// Initialize the communication module
	twipr_communication_config_t twipr_comm_config = { .huart = BOARD_CM4_UART,
			.hspi = BOARD_SPI_CM4, .notification_gpio_tx = core_utils_GPIO(
					CM4_SAMPLE_NOTIFICATION_PORT, CM4_SAMPLE_NOTIFICATION_PIN),
			.reg_map_control = &this->_control.reg_map, .reg_map_general =
					&this->register_map, .trajectory_rx_buffer =
					this->_control.trajectory_rx_buffer,
			.len_trajectory_buffer = TWIPR_CONTROL_TRAJECTORY_BUFFER_SIZE,
			.reset_uart_exti = CM4_UART_RESET_EXTI, .control = &this->_control,
			.estimation = &this->_estimation, .sensors = &this->_sensors };

	this->_comm.init(twipr_comm_config);

//	this->_comm.registerCallback(TWIPR_COMM_CALLBACK_NEW_TRAJECTORY,
//			core_utils_Callback<void, uint16_t>(&this->_control,
//					&TWIPR_ControlManager::newTrajectoryReceived_callback));

// Initialize the sensors
	twipr_sensors_config_t twipr_sensors_config = { .drive = &this->_drive, };
	this->_sensors.init(twipr_sensors_config);

	// Initialize the estimation module
	twipr_estimation_config_t twipr_estimation_config = {
			.drive = &this->_drive, .sensors = &this->_sensors,
			.enable_slip_detection = 1, .enable_angle_threshold = 1,
			.angle_threshold = deg2rad(70.0), .model = twipr_model_small };

	this->_estimation.init(twipr_estimation_config);

	// Initialize the control module
	twipr_control_config_t twipr_control_config = { .estimation =
			&this->_estimation, .drive = &this->_drive, .max_torque =
	TWIPR_CONTROL_MAX_TORQUE, .freq = 100 };
	memcpy(twipr_control_config.K, twipr_control_default_K, sizeof(float) * 8);

	this->_control.init(twipr_control_config);

//	this->_control.registerCallback(TWIPR_CONTROL_CALLBACK_STEP,
//			core_utils_Callback<void, uint32_t>(this,
//					&TWIPR_Firmware::_controlStep_callback));

// Initialize the drive module
	if (TWIPR_FIRMWARE_USE_MOTORS) {
		twipr_drive_config_t twipr_drive_config =
				{ .id_left = 1, .id_right = 2, .direction_left = -1,
						.direction_right = 1, .torque_max = 0.3,
						.modbus_config = { .huart = BOARD_RS485_UART,
								.EN_GPIOx = BOARD_RS485_UART_EN_GPIOx,
								.EN_GPIO_Pin = BOARD_RS485_UART_EN_GPIO_PIN,
								.hardware = MB_UART_DMA }, };

		this->_drive.init(twipr_drive_config);

		ret = this->_drive.startup_check();
		if (!ret) {
			nop();
		}
	}

	// Initialize the supervisor module
	TWIPR_Safety_Config_t safety_config = { .drive = &this->_drive, .control =
			&this->_control, .max_speed = 50, .off_button = &off_button };

	this->_safety.init(safety_config);

	// Initialize the data transfer to the compute module
//	HAL_DMA_RegisterCallback(TWIPR_FIRMWARE_SAMPLE_DMA_STREAM,
//			HAL_DMA_XFER_CPLT_CB_ID, sample_dma_transfer_cmplt_callback);

// Register all communication register entries
	this->reg_entries.firmware_state.set(0x04, &this->register_map,
			&this->firmware_state, REGISTER_ENTRY_READ);
	this->reg_entries.tick.set(0x02, &this->register_map, &this->tick,
			REGISTER_ENTRY_READ);
//	this->reg_entries.led_color_array.set(0x03, &this->register_map, &led_color_array, REGISTER_ENTRY_READWRITE);
	this->reg_entries.debug.set(0x01, &this->register_map,
			core_utils_Callback<void, uint8_t>(debug));

	// If everything ran until here: Beep and set the status LED to green

	rc_buzzer.setConfig(900, 250, 1);
	rc_buzzer.start();
	rc_rgb_led_status.setColor(0, 60, 0);
	rc_rgb_led_status.state(1);
}

/* =======================================================*/
void TWIPR_Firmware::start() {

	// Start the communication module
	this->_comm.start();

	// Start the Sensors
	this->_sensors.start();

	// Start the estimation module
	this->_estimation.start();

	// Start the drive
	if (TWIPR_FIRMWARE_USE_MOTORS) {
		this->_drive.start();
	}

	// Start the control module
	this->_control.start();
//
//	// Start the Safety Module
	this->_safety.start();

//	HAL_TIM_PWM_Start(&htim15, TIM_CHANNEL_1);
//	TIM15->CCR1 = 5000;
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
//void TWIPR_Firmware::_controlStep_callback(uint32_t tick) {
//	this->tick = tick;
//}
void debug(uint8_t state) {
	rc_rgb_led_side_2.state(state);
	rc_rgb_led_side_2.setColor(0, 0, 80);
}
