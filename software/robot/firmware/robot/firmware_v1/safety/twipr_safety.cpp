/*
 * twipr_safety.cpp
 *
 *  Created on: Feb 22, 2023
 *      Author: lehmann_workstation
 */

#include "twipr_safety.h"


const osThreadAttr_t safety_task_attributes = { .name = "safety",
		.stack_size = 256 * 4, .priority = (osPriority_t) osPriorityNormal, };



TWIPR_Safety::TWIPR_Safety(){

}


void TWIPR_Safety::init(TWIPR_Safety_Config_t config){
	this->config = config;
}


void TWIPR_Safety::start(){
	osThreadNew(twipr_safety_task, (void*) this,
			&safety_task_attributes);
}


void TWIPR_Safety::task_function(){
	twipr_drive_speed_t speed;
	while (true) {
		speed = this->config.drive->getSpeed();
		if (abs(speed.speed_left) > 50 || abs(speed.speed_right) > 50) {
			this->config.control->stop();
		}

		if (this->config.off_button->check() == 0){
			this->config.control->stop();
		}
		osDelay(10);
	}
}


void twipr_safety_task(void* args){

	TWIPR_Safety* argument = (TWIPR_Safety*) args;
	argument->task_function();

}
