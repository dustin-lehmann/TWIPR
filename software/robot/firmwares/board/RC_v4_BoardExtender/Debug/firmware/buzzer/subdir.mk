################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../firmware/buzzer/buzzer.cpp 

OBJS += \
./firmware/buzzer/buzzer.o 

CPP_DEPS += \
./firmware/buzzer/buzzer.d 


# Each subdirectory must supply rules for building sources it contributes
firmware/buzzer/%.o firmware/buzzer/%.su firmware/buzzer/%.cyclo: ../firmware/buzzer/%.cpp firmware/buzzer/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m4 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L431xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/neopixel" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/utils" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/led" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/i2c" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/eeprom" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/callbacks" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/buzzer" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-firmware-2f-buzzer

clean-firmware-2f-buzzer:
	-$(RM) ./firmware/buzzer/buzzer.cyclo ./firmware/buzzer/buzzer.d ./firmware/buzzer/buzzer.o ./firmware/buzzer/buzzer.su

.PHONY: clean-firmware-2f-buzzer
