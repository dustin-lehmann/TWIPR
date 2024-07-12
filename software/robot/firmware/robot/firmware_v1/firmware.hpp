/*
 * firmware.hpp
 *
 *  Created on: Feb 13, 2023
 *      Author: lehmann_workstation
 */

#ifndef FIRMWARE_HPP_
#define FIRMWARE_HPP_

#include "twipr_communication.h"
#include "twipr_control.h"
#include "robot-control_std.h"
#include "simplexmotion.hpp"
#include "twipr_estimation.h"
#include "twipr_errors.h"
#include "twipr_logging.h"
#include "firmware_defs.h"
#include "twipr_safety.h"

extern TIM_HandleTypeDef htim15;

typedef enum twipr_firmware_error_t {
	TWIPR_FIRMWARE_ERROR_NONE = 0,
	TWIPR_FIRMWARE_ERROR_TIMEOUT = 1,
} twipr_firmware_error_t;

typedef enum twipr_firmware_state_t {
	TWIPR_FIRMWARE_STATE_ERROR = -1,
	TWIPR_FIRMWARE_STATE_IDLE = 0,
	TWIPR_FIRMWARE_STATE_RUNNING = 1,
	TWIPR_FIRMWARE_STATE_RESET = 2,
} twipr_firmware_state_t;

typedef struct twipr_firmware_register_entries_t {
	core_utils_RegisterEntry<twipr_firmware_state_t> firmware_state;
	core_utils_RegisterFunction<void, int[3]> set_led_color_array;
	core_utils_RegisterEntry<uint32_t> tick;
	core_utils_RegisterFunction<void, uint8_t> debug;
} twipr_firmware_register_entries_t;

class TWIPR_Firmware {

public:
	TWIPR_Firmware();
	void init();
	void start();
	void step();

	void task_function();

	core_utils_RegisterMap<60> register_map = core_utils_RegisterMap<60>(TWIPR_FIRMWARE_REGISTER_MAP_GENERAL);
	twipr_firmware_register_entries_t reg_entries;


	twipr_firmware_state_t firmware_state = TWIPR_FIRMWARE_STATE_RESET;
	twipr_firmware_error_t firmware_error = TWIPR_FIRMWARE_ERROR_NONE;

	xTaskHandle task;
	osThreadId_t thread;
private:
	TWIPR_Drive _drive;
	TWIPR_CommunicationManager _comm;
	TWIPR_ControlManager _control;
	TWIPR_Estimation _estimation;
	TWIPR_Safety _safety;
	TWIPR_Sensors _sensors;
	uint32_t tick;
};

void firmware_task(void *argument);

#endif /* FIRMWARE_HPP_ */
