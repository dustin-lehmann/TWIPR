################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../firmware/led/led.cpp 

OBJS += \
./firmware/led/led.o 

CPP_DEPS += \
./firmware/led/led.d 


# Each subdirectory must supply rules for building sources it contributes
firmware/led/%.o firmware/led/%.su firmware/led/%.cyclo: ../firmware/led/%.cpp firmware/led/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m0plus -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32G031xx -c -I../Core/Inc -I../Drivers/STM32G0xx_HAL_Driver/Inc -I../Drivers/STM32G0xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32G0xx/Include -I../Drivers/CMSIS/Include -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/neopixel" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/buzzer" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/led" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/eeprom" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/i2c" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/rc_board-extender_firmware/firmware/callbacks" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-firmware-2f-led

clean-firmware-2f-led:
	-$(RM) ./firmware/led/led.cyclo ./firmware/led/led.d ./firmware/led/led.o ./firmware/led/led.su

.PHONY: clean-firmware-2f-led

