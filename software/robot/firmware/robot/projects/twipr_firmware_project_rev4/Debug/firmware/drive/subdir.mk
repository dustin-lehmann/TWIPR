################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/drive/twipr_drive.cpp 

OBJS += \
./firmware/drive/twipr_drive.o 

CPP_DEPS += \
./firmware/drive/twipr_drive.d 


# Each subdirectory must supply rules for building sources it contributes
firmware/drive/twipr_drive.o: J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/drive/twipr_drive.cpp firmware/drive/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -DBOARD_REV_4 -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/robot-control_std_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/estimation" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/control" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/drive" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/errors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/logging" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication/modules" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication/messages" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/include" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2 -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/safety" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/estimation" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-firmware-2f-drive

clean-firmware-2f-drive:
	-$(RM) ./firmware/drive/twipr_drive.cyclo ./firmware/drive/twipr_drive.d ./firmware/drive/twipr_drive.o ./firmware/drive/twipr_drive.su

.PHONY: clean-firmware-2f-drive
