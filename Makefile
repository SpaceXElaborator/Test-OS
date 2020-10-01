# $@ = Target File
# $< = First Dependency
# $^ = All Dependencies

root_dir := .

include $(root_dir)/scripts/config.mk

tag := $(BLUE)[Prosaiber OS]$(NORMAL)
succ := $(GREEN)Success!$(NORMAL)

all: boot

boot: .force
	@$(MAKE) $(MAKE_FLAGS) --directory=$(boot_dir)
	@$(MAKE) $(MAKE_FLAGS) --directory=$(kern_dir)
	@echo "$(tag) - $(succ)"

debug_real:
	qemu-system-x86_64 -s -S Prosaiber.bin &
	gdb -ex "target remote localhost:1234"

debug:
	qemu-system-x86_64 Prosaiber.bin -no-reboot -monitor stdio -d int

run:
	qemu-system-x86_64 Prosaiber.bin

clean:
	rm -rf *.bin *.elf
	rm -rf boot/*.bin kernel/*.bin kernel/*.o kernel/*.tmp

.force:
