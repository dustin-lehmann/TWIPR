################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.cpp 

OBJS += \
./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.o 

CPP_DEPS += \
./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.d 


# Each subdirectory must supply rules for building sources it contributes
stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.o: /Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.cpp stm32_core_cpp_lib/ext/madgwick_ahrs/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -DRCSTD_CONFIG_BOARD_REV_3 -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/robot-control_std_lib" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/estimation" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/control" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/drive" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/errors" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/logging" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication/modules" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication/messages" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/utils" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/include" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2 -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/safety" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-stm32_core_cpp_lib-2f-ext-2f-madgwick_ahrs

clean-stm32_core_cpp_lib-2f-ext-2f-madgwick_ahrs:
	-$(RM) ./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.cyclo ./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.d ./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.o ./stm32_core_cpp_lib/ext/madgwick_ahrs/MadgwickAHRS.su

.PHONY: clean-stm32_core_cpp_lib-2f-ext-2f-madgwick_ahrs

