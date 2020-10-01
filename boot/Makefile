root_dir := ..

include $(root_dir)/scripts/config.mk

tag := $(BLUE)[boot]$(NORMAL)

default: bootloader.bin sector1.o
	@echo "$(tag) - Staging..."

bootloader.bin: bootloader.asm
	nasm $< -f bin -o $(kern_dir)/$@

sector1.o: sector1.asm
	nasm $< -f elf64 -o $(kern_dir)/$@
