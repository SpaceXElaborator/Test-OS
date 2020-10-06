root_dir := ..
include $(root_dir)/scripts/config.mk

tag := $(BLUE)[Kernel]$(NORMAL)

default: Prosaiber.bin
	@echo "$(tag) - Compiling..."

kernel.o: kernel.cpp
	x86_64-elf-gcc -Ttext 0x8000 -ffreestanding -m64 -c $< -o $@

Kernel.bin: kernel.o
	x86_64-elf-ld -T "link.ld" --oformat binary

Prosaiber.elf: sector1.o kernel.o
	@echo "$(tag) - Making debug..."
	x86_64-elf-ld -o $(root_dir)/$@ -Ttext 0x7e00 $^

Prosaiber.bin: bootloader.bin Kernel.bin
	cat $^ > $(root_dir)/$@
