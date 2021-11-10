# VC-1541-DOS

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered an old EPROM marked `VC-1541-DOS/80` in the UD11 option ROM socket of his Commodore CBM 8032.  It turned out to be for a user port adapter that allows PET/CBM computers to use CBM IEC serial peripherals like the 1541 disk drive.  Sven did not have the hardware but he reverse engineered the requirements from the EPROM and designed his [own PCB](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter).  With the EPROM and Sven's PCB, you can use IEC peripherals with the PET.

This is a disassembly of `VC-1541-DOS/80` in the form of commented, relocatable source code.

## Assemble

This source code is written for the `as6500` assembler, which is part of Alan Baldwin's [ASxxxx Cross-Assemblers](https://shop-pdp.net/ashtml/asxxxx.php) package.  The code can be assembled in one command using GNU Make:

```text
$ make
```

It will output a binary file that is bit-for-bit identical to the original `VC-1541-DOS/80` EPROM.  It will also produce a listing file that shows the assembled bytes alongside the source lines.  See the `Makefile` for the individual commands.  

The EPROM installs in the UD11 ($A000) socket.  It is 4K and can be burned into a 2532.  You can also build a version for UD12 ($9000) by changing the start address at the top of the assembly file.  This is useful if you already have a ROM in UD11, such as PaperClip or WordPro.

## Requirements

- BASIC 4.0.  The code makes many calls into the BASIC 4.0 ROMs, and not only into the well-known entry points.

- Due to its use of location $87D0, the code requires an 80-column machine to fully function.  $87D0 is in the 80-column screen RAM but is not part of the visible screen.  This location is required for the wedge commands `!print#`, `!get#`, `!input#`, and `!cmd#`.  These will not work correctly on a 40-column machine.  However, the other commands will work.

- 2 bytes at the very top of Cassette Buffer 2: $03FE and $03FF.

## Usage

VC-1541-DOS is implemented as a BASIC wedge.  Activate the wedge with ``sys 40960``.  

All commands in VC-1541-DOS wedge are prefixed with a `!` such as `!load"filename"`.  IEEE-488 and IEC devices can be used at the same time but only the `!` prefixed commands can access an IEC device.  Although the `!` commands share the same names as their CBM BASIC counterparts, they do not work the same.  

Location `1022` holds the current IEC device number used by VC-1541-DOS.  When the wedge is installed, it defaults to `8`.  To use another IEC device such as `9`, enter `poke 1022,9`.

| Command | Description |
| - | - |
| `!q` | Quit.  Uninstalls the VC-1541-DOS wedge. |
| `!@` | Read the command channel on the current IEC device (location `1022`) and print it. |
| `!@"s0:filename"` | Send an arbitrary string to the command channel on the current IEC device.  The command must be quoted. |
| `!u9` | Temporarily change the device number of the current IEC device to the given device number.  This sends an `M-W` command to overwrite locations `$77` and `$78` in the drive, as described in the 1541 User's Guide.  Location `1022` will also be updated with the new device number. |
| `!catalog` | Read the directory on the current IEC device.  This is equivalent to `!catalog"$"`. |
| `!catalog"$0:foo*"` | Read the directory on the current IEC device with the given search pattern.  Enter the search pattern the same as you would with `load"$0:foo*",8` in CBM BASIC.` |
| `!load"filename"` | Load a program from the current IEC device into the BASIC program area. |
|  `!load"filename",027a` | Load a program from the current IEC device starting at the given addres.  Only a start address is supported.  It must be four hexadecimal digits. | |
| `!verify"filename"` | Verify a program on the current IEC device against the BASIC program area. |
| `!verify"filename",027a` | Verify a program on the current IEC device against the given addres.  Only a start address is supported.  It must be four hexadecimal digits. |
| `!save"filename"` | Save a BASIC program to the current IEC device. |
| `!save"filename",027a,0300` |  Save memory from 0x027A-0x02FF inclusive.  Both the start and the end addresses are required and must be four hexadecimal digits. |
| `!open#2,"filename"` | Open a file with the given secondary address on the current IEC device.  The comma and the quotes are required.  The filename can not be empty. |
| `!cmd#2` | Redirect output to the given secondary address on the current IEC device. |
| `!print#2` | Print a blank line to the given secondary address on the current IEC device.  If `!cmd#` was started, it is automatically ended first. |

### Additional Entry Points

Only the first entry point ($A000 or `sys 40960`) is intended to be used from BASIC.  However, there are 16 additional entry points available for use by assembly language programs.  Please see the source code.

## Credits

The original author is unknown.  The EPROM contains the strings `vc-1541-dos/80` and `(C) g mutz (84)`.

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered the EPROM, disassembled large parts of it, determined the hardware requirements, and designed a circuit and PCB for it.  He was the first to get it working.  Sven published extensive documentation on his findings, along some unanswered questions about the commands.

Martin Hoffman-Vetter is [credited](https://www.forum64.de/index.php?thread/106364-1541er-interface-f%C3%BCr-cbm8032-mystery-eprom/&postID=1742166#post1742166) by Sven for noticing that the IEC routines in the ROM are nearly identical to those in the C64 KERNAL, which greatly simplified disassembly.

I created my own disassembly to investigate the unanswered questions and to have a relocatable source that could be changed or improved.  I started from the ROM binary using my [`m740dasm`](https://github.com/mnaberez/m740dasm) disassembler.  My primary reference materials were the book "Programming the PET/CBM" by Raeto West, the original C64 KERNAL source code from CBM, and some of my past PET/CBM disassemblies.  

## License

No rights are claimed on the original `VC-1541-DOS/80` code or C64 KERNAL code.  All other work is made available under the 3-Clause BSD License.

## Author

[Mike Naberezny](https://github.com/mnaberez)
