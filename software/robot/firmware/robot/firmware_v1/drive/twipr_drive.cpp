/*
 * twipr_drive.cpp
 *
 *  Created on: 22 Feb 2023
 *      Author: Dustin Lehmann
 */

#include "twipr_drive.h"

static const osThreadAttr_t drive_torque_task_attributes = { .name =
		"drive_torque", .stack_size = 1028 * 4, .priority =
		(osPriority_t) osPriorityNormal, };

static const osThreadAttr_t drive_speed_task_attributes = { .name =
		"drive_speed", .stack_size = 256 * 4, .priority =
		(osPriority_t) osPriorityNormal, };

static const osThreadAttr_t drive_voltage_task_attributes = { .name =
		"drive_speed", .stack_size = 256 * 4, .priority =
		(osPriority_t) osPriorityBelowNormal7, };

//osMessageQueueId_t drive_input_queue;
osSemaphoreId_t speed_semaphore;
osSemaphoreId_t voltage_semaphore;

osSemaphoreId_t torque_semaphore;

twipr_drive_input_t input_global;

void twipr_drive_torque_task(void *argument) {
	TWIPR_Drive *drive = (TWIPR_Drive*) argument;
	drive->torqueTaskFunction();
}

/* ================================================= */
void twipr_drive_speed_task(void *argument) {
	TWIPR_Drive *drive = (TWIPR_Drive*) argument;
	drive->speedTaskFunction();
}

/* ================================================= */
void twipr_drive_voltage_task(void *argument) {
	TWIPR_Drive *drive = (TWIPR_Drive*) argument;
	drive->voltageTaskFunction();
}
/* ================================================= */
void TWIPR_Drive::torqueTaskFunction() {
	twipr_drive_input_t drive_input;
	twipr_drive_speed_t speed;
	float voltage = 0;
	drive_input.torque_left = 0;
	drive_input.torque_right = 0;
	uint32_t tick = 0;
	uint32_t last_voltage_tick = 0;
	uint8_t mode = 0;

	while (true) {
		tick = osKernelGetTickCount();
		if ((tick - last_voltage_tick) > 1000) {
			last_voltage_tick = tick;
			voltage = this->_readVoltage();
			osSemaphoreAcquire(voltage_semaphore, portMAX_DELAY);
			this->_drive_voltage = voltage;
			osSemaphoreRelease(voltage_semaphore);
		} else {
			if (mode) { // Do torque
				osSemaphoreAcquire(torque_semaphore, portMAX_DELAY);
				drive_input.torque_left = input_global.torque_left;
				drive_input.torque_right = input_global.torque_right;
				osSemaphoreRelease(torque_semaphore);
				if (this->status == TWIPR_DRIVE_STATUS_RUNNING) {
					this->motor_left.setTorque(drive_input.torque_left);
					osDelay(2);
					this->motor_right.setTorque(drive_input.torque_right);
				}
			} else { // Do speed
				speed.speed_left = this->motor_left.getSpeed();
				osDelay(2);
				speed.speed_right = this->motor_right.getSpeed();
				osSemaphoreAcquire(speed_semaphore, portMAX_DELAY);
				this->_speed = speed;
				osSemaphoreRelease(speed_semaphore);
			}
			mode = !mode;
		}

		if ((osKernelGetTickCount() - tick) > 20) {
			nop();
		}
		osDelayUntil(tick + 20);
	}
}


/* ================================================= */
TWIPR_Drive::TWIPR_Drive() {

}

/* ================================================= */
uint8_t TWIPR_Drive::init(twipr_drive_config_t config) {
	this->_config = config;

	uint8_t ret = 0;
	input_global.torque_left = 0;
	input_global.torque_right = 0;

	// Initialize the Modbus Interface
	this->modbus_torque.init(this->_config.modbus_config);
	this->modbus_torque.start();

	// Initialize the motors
	simplexmotion_config_t config_left = { .id = this->_config.id_left,
			.direction = this->_config.direction_left, .modbus =
					&this->modbus_torque, };

	ret = this->motor_left.init(config_left);

	if (!ret) {
		this->_error_handler(TWIPR_DRIVE_ERROR_INIT);
	}

	simplexmotion_config_t config_right = { .id = this->_config.id_right,
			.direction = this->_config.direction_right, .modbus =
					&this->modbus_torque, };

	ret = this->motor_right.init(config_right);

	if (!ret) {
		this->_error_handler(TWIPR_DRIVE_ERROR_INIT);
	}

	// Set Torque Limits
	this->motor_left.setTorqueLimit(this->_config.torque_max);
	this->motor_right.setTorqueLimit(this->_config.torque_max);

	// Check if torque limits have been set correctly
	float torque_limit_left = this->motor_left.getTorqueLimit();
	float torque_limit_right = this->motor_right.getTorqueLimit();

	if (!(abs(this->_config.torque_max - torque_limit_left) < 0.01)) {
		this->_error_handler(TWIPR_DRIVE_ERROR_INIT);
	}

	if (!(abs(this->_config.torque_max - torque_limit_right) < 0.01)) {
		this->_error_handler(TWIPR_DRIVE_ERROR_INIT);
	}

//	drive_input_queue = osMessageQueueNew(1, sizeof(twipr_drive_input_t), NULL);
//
	osThreadNew(twipr_drive_torque_task, (void*) this,
			&drive_torque_task_attributes);

//	this->_drive_voltage = this->_readVoltage();

	speed_semaphore = osSemaphoreNew(1, 1, NULL);
	torque_semaphore = osSemaphoreNew(1, 1, NULL);
	voltage_semaphore = osSemaphoreNew(1, 1, NULL);

	return 1;
}
/* ================================================= */
void TWIPR_Drive::start() {
	this->motor_left.start(SIMPLEXMOTION_MODE_TORQUE);
	this->motor_right.start(SIMPLEXMOTION_MODE_TORQUE);
	this->status = TWIPR_DRIVE_STATUS_RUNNING;
}
/* ================================================= */
void TWIPR_Drive::stop() {

	// Stop both motors immediately
	this->motor_left.stop();
	this->motor_right.stop();
	this->status = TWIPR_DRIVE_STATUS_STOP;
}
/* ================================================= */
uint8_t TWIPR_Drive::startup_check() {
	// Check both motors
	uint8_t check_left = this->motor_left.startup_check();
	osDelay(250);
	uint8_t check_right = this->motor_right.startup_check();

	if (!check_left) {
		return 0;
	}

	if (!check_right) {
		return 0;
	}

	return 1;
}
/* ================================================= */
void TWIPR_Drive::check() {
	// Check both motors
}

/* ================================================= */
void TWIPR_Drive::update() {
	// Read status of motors and check if everything is running fine
}
/* ================================================= */
float TWIPR_Drive::getVoltage() {
	osSemaphoreAcquire(voltage_semaphore, portMAX_DELAY);
	float voltage = this->_drive_voltage;
	osSemaphoreRelease(voltage_semaphore);

	return voltage;
}
/* ================================================= */
float TWIPR_Drive::_readVoltage() {
	return this->motor_left.getVoltage();
}
/* ================================================= */
twipr_drive_speed_t TWIPR_Drive::getSpeed() {

	twipr_drive_speed_t speed;

	// TODO
	osSemaphoreAcquire(speed_semaphore, portMAX_DELAY);
	speed = this->_speed;
	osSemaphoreRelease(speed_semaphore);
	return speed;
}
/* ================================================= */
void TWIPR_Drive::setTorque(twipr_drive_input_t input) {

	if (this->status != TWIPR_DRIVE_STATUS_RUNNING) {
		return;
	}

	osSemaphoreAcquire(torque_semaphore, portMAX_DELAY);
	input_global.torque_left = input.torque_left;
	input_global.torque_right = input.torque_right;
	osSemaphoreRelease(torque_semaphore);

//	osMessageQueuePut(drive_input_queue, &input, 0, 0);

//	this->motor_left.setTorque(input.torque_left);
//	this->motor_right.setTorque(input.torque_right);
}

/* ================================================= */
void TWIPR_Drive::setTorque(float torque_left, float torque_right) {
	if (this->status != TWIPR_DRIVE_STATUS_RUNNING) {
		return;
	}
	this->motor_left.setTorque(torque_left);
	this->motor_right.setTorque(torque_right);
}

/* ================================================= */
void TWIPR_Drive::_error_handler(uint32_t error) {

	// Set the state to error
	this->status = TWIPR_DRIVE_STATUS_ERROR;
	this->error = (twipr_drive_error_t) error;

	// Call the error handler of the TWIPR
	twipr_error_handler(error);
}
