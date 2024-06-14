################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../firmware/callbacks/callback.cpp 

OBJS += \
./firmware/callbacks/callback.o 

CPP_DEPS += \
./firmware/callbacks/callback.d 


# Each subdirectory must supply rules for building sources it contributes
firmware/callbacks/%.o firmware/callbacks/%.su firmware/callbacks/%.cyclo: ../firmware/callbacks/%.cpp firmware/callbacks/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m4 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32L431xx -c -I../Core/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc -I../Drivers/STM32L4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32L4xx/Include -I../Drivers/CMSIS/Include -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/neopixel" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/utils" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/led" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/i2c" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/eeprom" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/callbacks" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware/buzzer" -I"C:/work_dir/work_dir/projects/testbed/software/robots/software_board/board_manager_mcu/RC_v4_BoardExtender/firmware" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-firmware-2f-callbacks

clean-firmware-2f-callbacks:
	-$(RM) ./firmware/callbacks/callback.cyclo ./firmware/callbacks/callback.d ./firmware/callbacks/callback.o ./firmware/callbacks/callback.su

.PHONY: clean-firmware-2f-callbacks

