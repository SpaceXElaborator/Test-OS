Prosaiber OS:

+-=-=-=-+ MADE +-=-=-=-+
- Reading from another disk
- Simple 16-bit print
- Make file script
- 32-bit CM enabled
- 64-bit LM enabled

+-=-=-=-+ TODO +-=-=-=-+
- Add C


+-=-=-=-+ Understanding +-=-=-=-+
- Entry Point: 0x7c00
- bootloader.asm - 512 bytes (0x200 hex)
- sector1.asm - 2048 bytes (0x800 hex)
- 0x7c00 + 0x200 = 0x7e00 (Entry point for Sector1.asm)
- 0x7e00 + 0x800 = 0x8600 (Entry point for Kernel.c)
