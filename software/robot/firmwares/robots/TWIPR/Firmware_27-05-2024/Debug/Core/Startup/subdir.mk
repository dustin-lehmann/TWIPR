################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
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
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -DRCSTD_CONFIG_BOARD_REV_3 -c -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/robot-control_std_lib" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/estimation" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/control" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/drive" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/errors" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/logging" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication/modules" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/communication/messages" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/utils" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/include" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I"/Users/lehmann/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Firmware_27-05-2024/firmware/safety" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Core-2f-Startup

clean-Core-2f-Startup:
	-$(RM) ./Core/Startup/startup_stm32h743vitx.d ./Core/Startup/startup_stm32h743vitx.o

.PHONY: clean-Core-2f-Startup

