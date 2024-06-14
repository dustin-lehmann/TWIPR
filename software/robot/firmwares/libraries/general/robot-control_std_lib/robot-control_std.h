/*
 * robot-control_std.h
 *
 *  Created on: Jul 29, 2022
 *      Author: Dustin Lehmann
 */

#ifndef ROBOT_CONTROL_STD_H_
#define ROBOT_CONTROL_STD_H_

#include <core.h>
#include "robot-control_board.h"
#include "robot-control_default_config.h"
#include "robot-control_extender.h"
#include "robot-control_indicators.h"

extern core_hardware_LED rc_status_led_1;
extern core_hardware_LED rc_status_led_2;
extern core_hardware_LED rc_button_led;
extern core_hardware_LED rc_activity_led;


extern RobotControl_RGBLED rc_rgb_led_status;
extern RobotControl_RGBLED rc_rgb_led_side_1;
extern RobotControl_RGBLED rc_rgb_led_side_2;
extern RobotControl_StatusLED rc_error_led;

extern RobotControl_Buzzer rc_buzzer;

extern core_hardware_Button button;

extern core_hardware_Button side_button;
extern core_hardware_Button off_button;

extern RobotControl_Extender extender;

extern UART debug_uart;

void robot_control_init();
void robot_control_start();


#endif /* ROBOT_CONTROL_STD_H_ */
