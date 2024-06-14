/*
 * twipr_safety.h
 *
 *  Created on: Feb 22, 2023
 *      Author: lehmann_workstation
 */

#ifndef SAFETY_TWIPR_SAFETY_H_
#define SAFETY_TWIPR_SAFETY_H_

#include "core.h"
#include "twipr_drive.h"
#include "twipr_control.h"

typedef struct TWIPR_Safety_Config_t {
	TWIPR_Drive *drive;
	TWIPR_ControlManager *control;
	float max_speed;
	core_hardware_Button *off_button;

} TWIPR_Safety_Config_t;

class TWIPR_Safety {
public:
	TWIPR_Safety();

	void init(TWIPR_Safety_Config_t config);
	void start();


	void task_function();

private:



	TWIPR_Safety_Config_t config;


};


void twipr_safety_task(void* args);

#endif /* SAFETY_TWIPR_SAFETY_H_ */
