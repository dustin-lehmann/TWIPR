/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32g0xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "firmware_c.h"
/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define ENABLE_SD_Pin GPIO_PIN_2
#define ENABLE_SD_GPIO_Port GPIOA
#define DETECT_SD_Pin GPIO_PIN_4
#define DETECT_SD_GPIO_Port GPIOA
#define DETECT_USB_Pin GPIO_PIN_6
#define DETECT_USB_GPIO_Port GPIOA
#define LED_USB_Pin GPIO_PIN_0
#define LED_USB_GPIO_Port GPIOB
#define BUTTON_EXT_Pin GPIO_PIN_1
#define BUTTON_EXT_GPIO_Port GPIOB
#define DEBUG_JMP_Pin GPIO_PIN_8
#define DEBUG_JMP_GPIO_Port GPIOA
#define ENABLE_CM4_Pin GPIO_PIN_6
#define ENABLE_CM4_GPIO_Port GPIOC
#define LED_Pin GPIO_PIN_15
#define LED_GPIO_Port GPIOA
#define ENABLE_5V_Pin GPIO_PIN_5
#define ENABLE_5V_GPIO_Port GPIOB
#define CM4_3V3_Pin GPIO_PIN_8
#define CM4_3V3_GPIO_Port GPIOB

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
