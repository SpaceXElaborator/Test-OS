root_dir := ..
include $(root_dir)/scripts/config.mk

tag := $(BLUE)[Kernel]$(NORMAL)

default: Prosaiber.bin Prosaiber.elf
	@echo "$(tag) - Compiling..."

kernel.o: kernel.c
	x86_64-elf-gcc -ffreestanding -m64 -c $< -o $@

kernel.bin: sector1.o kernel.o
	x86_64-elf-ld -o $@ -Ttext 0x7e00 $^ --oformat binary

Prosaiber.elf: sector1.o kernel.o
	@echo "$(tag) - Making debug..."
	x86_64-elf-ld -o $(root_dir)/$@ -Ttext 0x7e00 $^

Prosaiber.bin: bootloader.bin kernel.bin
	cat $^ > $(root_dir)/$@
