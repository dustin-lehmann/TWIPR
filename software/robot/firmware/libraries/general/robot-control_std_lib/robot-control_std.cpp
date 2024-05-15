/*
 * robot-control_std.cpp
 *
 *  Created on: Jul 29, 2022
 *      Author: Dustin Lehmann
 */

#include "robot-control_std.h"
#include <stdio.h>

core_hardware_LED rc_status_led_1(BOARD_LED_1_PORT, BOARD_LED_1_PIN);
core_hardware_LED rc_status_led_2(BOARD_LED_2_PORT, BOARD_LED_2_PIN);

core_hardware_LED rc_button_led(GPIOA, GPIO_PIN_0);
core_hardware_Button big_button(GPIOC, GPIO_PIN_0);

core_hardware_LED rc_activity_led(BOARD_LED_ACT_PORT, BOARD_LED_ACT_PIN);
RobotControl_StatusLED rc_error_led;

core_hardware_Button button(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN);

RobotControl_Extender extender;

RobotControl_RGBLED rc_rgb_led_status(0);
RobotControl_RGBLED rc_rgb_led_side_1(1);
RobotControl_RGBLED rc_rgb_led_side_2(2);



RobotControl_Buzzer rc_buzzer;



//core_debug_Interface debug(CORE_DEBUG_INTERFACE_UART, BOARD_DEBUG_UART);
Madgwick sensor_fusion;


const osThreadAttr_t rc_task_attributes = { .name = "rc_default", .stack_size =
		128 * 4, .priority = (osPriority_t) osPriorityHigh4, };


void robot_control_start();
void robot_control_sensor_task(void *argument);
void robot_control_task(void *argument);



// ------------------------------------------------------------------------------------------------------------
void robot_control_init(){
	extender_config_struct_t extender_config = {
			.hi2c = BOARD_I2C_INTERN,
	};
	extender.init(extender_config);
//	debug_uart.init();
//	debug_uart.registerCallback(CORE_COMM_SERIAL_SOCKET_CB_RX, uart_rx_fun, NULL);

}
// ------------------------------------------------------------------------------------------------------------
void robot_control_start(){
//	debug_uart.start();
	osThreadNew(robot_control_task, NULL, &rc_task_attributes);
}

// ------------------------------------------------------------------------------------------------------------
void robot_control_task(void *argument){
//	debug.start();
	rc_error_led.setState(0);
	rc_rgb_led_status.setColor(100, 40, 0);
	rc_rgb_led_status.state(1);

	rc_buzzer.setConfig(440, 250, 1);
	rc_buzzer.start();

	rc_button_led.on();


	uint32_t kernel_ticks = 0;
	while (true){
			kernel_ticks = osKernelGetTickCount();
			rc_activity_led.toggle();
			osDelayUntil(kernel_ticks + (uint32_t) 250);
	}
}
