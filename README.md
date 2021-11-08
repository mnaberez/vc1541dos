# VC-1541-DOS

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered an old EPROM marked `VC-1541-DOS/80` in the UD11 option ROM socket of his Commodore CBM 8032.  It turned out to be for a user port adapter that allows PET/CBM computers to use CBM IEC serial peripherals like the 1541 disk drive.  Sven did not have the hardware but he reverse engineered the requirements from the EPROM and designed his [own PCB](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter).  With the EPROM and Sven's PCB, you can use IEC peripherals with the PET.

This is a disassembly of `VC-1541-DOS/80` in the form of commented, relocatable source code.

## Assemble

This source code is written for the `as6500` assembler, which is part of Alan Baldwin's [ASxxxx Cross-Assemblers](https://shop-pdp.net/ashtml/asxxxx.php) package.  The code can be assembled in one command using GNU Make:

```
$ make
```

It will output a binary file that is bit-for-bit identical to the `VC-1541-DOS/80` to the original.  It will also produce a listing file that shows the assembled bytes alongside the source lines.  See the `Makefile` for the individual commands.  

The EPROM installs in the UD11 ($A000) socket.  It is 4K and can be burned into a 2532.  You can also build a version for UD12 ($9000) by changing the start address at the top of the assembly file.  This is useful if you alread have a ROM in UD11, such as PaperClip or WordPro.

## Requirements

An 80-column PET with BASIC 4.0 is required such as an 8032, 8096, 8296, or SuperPET.  A 40-column PET with BASIC 4.0 such as a 4016 or 4032 can be used but not all commands will work.

The code is heavily dependent on the BASIC 4.0 ROMs.  Due to its use of location $87D0, the code requires an 80-column machine to fully function.  Location $87D0 is part of 80-column screen RAM that is not part of the visible screen.  This location is required for the wedge commands `!PRINT#`, `!GET#`, `!INPUT#`, and `!CMD#`.  These will not work correctly on a 40-column machine.  However, the other commands will work.

## Credits

The original author of the `VC-1541-DOS/80` system is unknown.  There is a copyright string `(C) G MUTZ (84)` in the code.  Since the VIC-1541 was called "VC-1541" in Germany, the system may have originated in Germany.

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered the "VC-1541-DOS/80" EPROM, disassembled large parts of it, determined the hardware requirements, and designed a circuit and PCB for it.  He was the first to bring up a working system.  Sven published extensive documentation with his findings, along some unanswered questions about using the wedge commands.

Martin Hoffman-Vetter is credited by Sven for noticing that the IEC routines in the ROM are nearly identical to those in the C64 KERNAL, which greatly simplified disassembly.

I created my own disassembly to investigate the unanswered questions and to have a relocatable source that could be changed or improved.  I started from the ROM binary using my [`m740dasm`](https://github.com/mnaberez/m740dasm) disassembler.  My primary reference materials were the book "Programming the PET/CBM" by Raeto West, the original C64 KERNAL source code from CBM, and some of my past PET/CBM disassemblies.  

## License

No rights are claimed on the original `VC-1541-DOS/80` code or C64 KERNAL code.  All other work is made available under the BSD 3-Clause "New" or "Revised" License.

## Author

[Mike Naberezny](https://github.com/mnaberez)
