/*
 * robot-control_indicators.h
 *
 *  Created on: Apr 24, 2024
 *      Author: Dustin Lehmann
 */

#ifndef ROBOT_CONTROL_INDICATORS_H_
#define ROBOT_CONTROL_INDICATORS_H_

#include <core.h>
#include "robot-control_extender.h"



class RobotControl_RGBLED{
public:
	RobotControl_RGBLED(uint8_t position);

	void setColor(uint8_t red, uint8_t green, uint8_t blue);
	void blink(uint16_t on_time);
	void state(uint8_t state);

private:

	uint8_t position;

};

class RobotControl_Buzzer {
public:
	RobotControl_Buzzer();

	void setConfig(float freq, uint16_t on_time, uint8_t repeats);
	void start();
};

class RobotControl_StatusLED {
public:
	RobotControl_StatusLED();
	void setState(int8_t state);
private:

};



#endif /* ROBOT_CONTROL_INDICATORS_H_ */
