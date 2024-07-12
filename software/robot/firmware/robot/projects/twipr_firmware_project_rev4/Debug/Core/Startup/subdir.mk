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
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -DBOARD_REV_4 -c -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/robot-control_std_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/estimation" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/control" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/drive" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/errors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/logging" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication/modules" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/communication/messages" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/include" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/Firmware_v4_24-06-2024/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/robots/TWIPR/firmware_v1/safety" -I"J:/work_dir/work_dir/projects/testbed/software/robots/firmwares/libraries/general/stm32_core_cpp_lib/estimation" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Core-2f-Startup

clean-Core-2f-Startup:
	-$(RM) ./Core/Startup/startup_stm32h743vitx.d ./Core/Startup/startup_stm32h743vitx.o

.PHONY: clean-Core-2f-Startup

