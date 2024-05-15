################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c 

C_DEPS += \
./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.d 

OBJS += \
./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/%.o Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/%.su Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/%.cyclo: ../Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/%.c Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -DRCSTD_CONFIG_BOARD_REV_3 -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/robot-control_std_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/communication/modbus_rtu" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/robot/simplexmotion_motors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/estimation" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/control" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/drive" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/errors" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/logging" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/modules" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/firmware/communication/messages" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/utils" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/libraries/general/stm32_core_cpp_lib/hardware/UART" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/include" -I"J:/work_dir/work_dir/projects/testbed/software/robots/software_board/robots/TWIPR/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I../Middlewares/Third_Party/FreeRTOS/Source/include -I../Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2 -I../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-MemMang

clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-MemMang:
	-$(RM) ./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.cyclo ./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.d ./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.o ./Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-MemMang

