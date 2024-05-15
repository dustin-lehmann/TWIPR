################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Core/Startup/startup_stm32h743vitx.s 

S_DEPS += \
./Core/Startup/startup_stm32h743vitx.d 

OBJS += \
./Core/Startup/startup_stm32h743vitx.o 


# Each subdirectory must supply rules for building sources it contributes
Core/Startup/%.o: ../Core/Startup/%.s Core/Startup/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -DRCSTD_CONFIG_BOARD_REV_3 -c -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/robot-control_std_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/estimation" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/control" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/drive" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/errors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/logging" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/modules" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/messages" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/include" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Core-2f-Startup

clean-Core-2f-Startup:
	-$(RM) ./Core/Startup/startup_stm32h743vitx.d ./Core/Startup/startup_stm32h743vitx.o

.PHONY: clean-Core-2f-Startup

