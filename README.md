# VC-1541-DOS

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered an old EPROM marked `VC-1541-DOS/80` in the UD11 option ROM socket of a Commodore CBM 8032.  It turned out to be for a user port adapter that allows PET/CBM computers to use CBM IEC serial peripherals like the 1541 disk drive.  Sven did not have the hardware but he reverse engineered the requirements from the EPROM and designed his [own PCB](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter).  With the EPROM and Sven's PCB, you can use IEC peripherals with the PET.

This is a disassembly of the `VC-1541-DOS/80` EPROM.

## Requirements

- BASIC 4.0.  The code makes many calls that are specific to the BASIC 4.0 ROMs.

- 80-column Screen RAM.  For the wedge commands `!print#`, `!get#`, `!input#`, and `!cmd#`, the code uses `$87D0`, which is a non-visible location in the 80-column RAM.  These commands will not work on a 40-column machine, although all others will.  To adapt the code for 40-column PETs, `$87D0` could be replaced with `$83E8`.

- An 80-column Editor ROM.  For the `!cmd#` command only, the code changes the `VOUT` vector to redirect output through its own routine.  The `VOUT` vector is [a feature](https://github.com/sjgray/cbm-edit-rom/blob/0cfc920f6a031ac71b7168bd8705d8ed6231346a/disassemblies/CBM8000-EDIT-ROM-disassembly-sjg.txt#L364-L390) of the 80-column Editor ROMs only.  It is present in the 80-column North American and German (DIN) Editor versions but is [not present](https://github.com/sjgray/cbm-edit-rom/blob/0cfc920f6a031ac71b7168bd8705d8ed6231346a/disassemblies/edit-4-40-n-60Hz-901499-01-disassembly-sjg.txt#L465-L485) in any 40-column version.

- An unknown 80-column Editor ROM.  Again for the `!cmd#` command only, the code expects `$E787` to be the default address that the Editor ROM stores in `VOUT`.  However, in the standard Editor ROMs for North America and Germany (DIN), there is nothing at `$E787`, meaning VC-1541-DOS was written for use with an unknown Editor ROM.  To adapt the code to the standard 80-column editor ROMs, replace `$E787` with `$E20C`.

## Usage

VC-1541-DOS provides a BASIC wedge.  Install it with `sys 40960` and it will show:

```text
vc-1541-dos/80
```

All commands in the VC-1541-DOS wedge are prefixed with a `!`.  The standard CBM BASIC commands can still access IEEE-488 devices but only the `!` commands can access IEC devices.  Although most `!` commands share the same names as their CBM BASIC counterparts, the usage of these commands is not exactly the same.

| Command | Description |
| ------- | ----------- |
| `!q` | Quit.  Uninstalls the VC-1541-DOS wedge. |
| `!@` | Read the command channel on an IEC device and print it. |
| `!@"s0:filename"` | Send a CBM DOS command to the command channel on an IEC device.  The command must be quoted. |
| `!9@` | Use the given IEC device number for the wedge command that follows it.  Another wedge command must follow the number, e.g. `!9@`, `!9load"filename"`, or `!9open#2,"filename"`.  The device number applies only to the given command. |
| `!u9` | Reprogram the device number of an IEC device to the given device number.  This sends an `M-W` command to overwrite locations `$77` and `$78` in the drive, as described in the 1541 User's Guide. |
| `!catalog` | Read the directory on an IEC device.  This is equivalent to `!catalog"$"`. |
| `!catalog"$0:foo*"` | Read the directory on an IEC device with the given search pattern.  Enter the search pattern the same as you would with `load"$0:foo*",8` in CBM BASIC. |
| `!load"filename"` | Load a program from an IEC device starting at the address in the file.  The BASIC pointers `TXTTAB` and `VARTAB` will be updated. |
| `!load;"filename"` | Load a program from an IEC device starting at the address in the file.  The BASIC pointers will not be changed. |
| `!load"filename",027a` | Load a program from an IEC device starting at the given address instead of the address in the file.  Only a start address may be given and it must be four hexadecimal digits.  The BASIC pointers will not be changed.  |
| `!verify"filename"` | Verify a program on an IEC device starting at the address in the file. |
| `!verify"filename",027a` | Verify a program on an IEC device starting at the given address instead of the address in the file.  Only a start address may be given and it must be four hexadecimal digits. |
| `!save"filename"` | Save a BASIC program to an IEC device. |
| `!save"filename",027a,0300` |  Save memory from `$027A`-`$02FF` inclusive.  Both the start and the end addresses are required and must be four hexadecimal digits. |
| `!open#2,"filename,s,r"` | Open a file with the given secondary address on an IEC device.  The comma and the quotes are required.  The filename can not be empty.  Note that secondary addresses 0 (load), 1 (save), and 15 (command) are special in CBM DOS.  For general purpose file access, use a secondary address between 2 and 14. |
| `!cmd#2` | Redirect output to the given secondary address on an IEC device. |
| `!print#2` | Print a CR to the given secondary address on an IEC device.  If `!cmd#` was started, it is automatically ended first. |
| `!print#2,"test"` | Print an expression to the given secondary address on an IEC device.  Multiple expressions can be combined with a `;` such as in `print#2,"test";x;a$`.  Unlike CBM BASIC, expressions cannot be combined with a comma.  If a trailing `;` is given, do not send the CR at the end. |
| `!get#2,a$` | Read a byte from the given secondary address on an IEC device into a variable. |
| `!input#2,a$` | Read CR-delimited data from the given secondary address on an IEC device into one or more variables separated by commas.  The command channel of a drive can be read with `!input#15,a,b$,c,d`. |
| `!close#2` | Close a file with the given secondary address on an IEC device. |

Command shortcuts, whitespace, and quoting works like CBM BASIC, e.g. `!load "foo"` can be shortened to `!lO"foo`.  Variables and expressions can be used, e.g. `f$="name":!load $f` or `!print#2,chr$(x+1);`.  Most commands work from direct mode or from within a program, but some do not work in direct mode, like their CBM BASIC counterparts.  The variable `st` is updated after commands but `ds`and `ds$` are not supported.

### Device Number

VC-1541-DOS uses a default device number stored in location `1022` (`$03fe`).  It is set to `8` when the wedge starts.  If a wedge command is entered without a device number, such as `!load"filename"`, then the default will be used.  You can `poke` a new default.  After `poke1022,9`, the command `!load"filename"` will load from device 9.

A wedge command may be prefixed with a device number to override the default.  For example, `!9load"filename"` will load from device 9.  The prefixed device number will only be used for the command that immediately follows it.

If bit 7 of the device number is set, an automatic CR (`0x0d`) to CRLF (`0x0d`, `0x0a`) translation mode is activated.  The `!print#` and `!cmd#` commands will automatically send an LF after every CR in this mode.

### No Wedge

VC-1541-DOS can also be used without installing the wedge by entering `sys 40963` followed by a command.  This statement is equivalent to `!load"filename"`:

```text
sys40963load"filename"
```

All of the VC-1541-DOS commands may be used this way, regardless of whether the wedge is installed or not.  Due to the way `sys` parsing works, a device number prefix (such as `!9load"filename"` in the wedge) cannot be used.

The commands `!print#`, `!get#`, `!cmd#`, and `!close#` can be used with `sys40963` but they cannot be the very first VC-1541-DOS command executed because they do not initialize the VIA.  This is not a problem when working with disk files, since `!open` is always called first.  However, to read the command channel of a drive into variables without first sending a command, or to send data to a printer, `!open` is not called first.  As a workaround, you can use `sys40960:!q` first, which installs the wedge (initializing the VIA in the process) and then immediately uninstalls it.

### Additional Entry Points

Only the first two entry points are intended to be used from BASIC.  However, there are 15 additional entry points available for use by assembly language programs.  These provide a "unified" or "universal" API to control both IEC and IEEE-488 devices.  Please see the source code.

## Credits

The original author is unknown.  The EPROM contained the strings `vc-1541-dos/80` and `(C) g mutz (84)`.

[Sven Petersen](https://github.com/svenpetersen1965/PET_CBM_1541_Adapter) discovered the EPROM, disassembled large parts of it, determined the hardware requirements, and designed a circuit and PCB for it.  He was the first to get it working and published extensive documentation.

Martin Hoffman-Vetter is [credited](https://www.forum64.de/index.php?thread/106364-1541er-interface-f%C3%BCr-cbm8032-mystery-eprom/&postID=1742166#post1742166) by Sven for noticing that the IEC routines in the ROM are nearly identical to those in the C64 KERNAL, which greatly simplified disassembly.

To make this disassembly, I ran [`m740dasm`](https://github.com/mnaberez/m740dasm) on the original binary and then added symbols and comments.

## License

No rights are claimed on the original VC-1541-DOS code or C64 KERNAL code.

All other work in this repository is made available under the [3-Clause BSD License](./LICENSE.txt).

## Contact

[Mike Naberezny](https://github.com/mnaberez)
