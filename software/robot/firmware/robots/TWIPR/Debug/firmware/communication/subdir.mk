################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../firmware/communication/twipr_communication.cpp 

OBJS += \
./firmware/communication/twipr_communication.o 

CPP_DEPS += \
./firmware/communication/twipr_communication.d 


# Each subdirectory must supply rules for building sources it contributes
firmware/communication/%.o firmware/communication/%.su firmware/communication/%.cyclo: ../firmware/communication/%.cpp firmware/communication/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -DRCSTD_CONFIG_BOARD_REV_3 -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/robot-control_std_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/estimation" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/control" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/drive" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/errors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/logging" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/modules" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/messages" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/include" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2 -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-firmware-2f-communication

clean-firmware-2f-communication:
	-$(RM) ./firmware/communication/twipr_communication.cyclo ./firmware/communication/twipr_communication.d ./firmware/communication/twipr_communication.o ./firmware/communication/twipr_communication.su

.PHONY: clean-firmware-2f-communication

