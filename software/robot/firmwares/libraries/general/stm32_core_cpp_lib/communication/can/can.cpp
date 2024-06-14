/*
 * can.cpp
 *
 *  Created on: May 26, 2024
 *      Author: lehmann
 */

#include "can.h"

extern FDCAN_HandleTypeDef hfdcan1;
FDCAN_TxHeaderTypeDef TxHeader;

void tryCan() {

	uint8_t txData[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };

//	uint32_t txMailbox;

	TxHeader.Identifier = 0xAA;
	TxHeader.IdType = FDCAN_STANDARD_ID;
	TxHeader.TxFrameType = FDCAN_DATA_FRAME;
	TxHeader.DataLength = 8;
	TxHeader.ErrorStateIndicator = FDCAN_ESI_ACTIVE;
	TxHeader.BitRateSwitch = FDCAN_BRS_OFF;
	TxHeader.FDFormat = FDCAN_CLASSIC_CAN;
	TxHeader.TxEventFifoControl = FDCAN_NO_TX_EVENTS;
	TxHeader.MessageMarker = 0;


	while(true){
		if (HAL_FDCAN_AddMessageToTxFifoQ(&hfdcan1, &TxHeader, txData)!= HAL_OK)
		 {

		 }

//		osDelay(1000);
	}

}
