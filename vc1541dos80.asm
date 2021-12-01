;VC-1541-DOS/80
;Reverse-engineered source code
;Assembles with AS6500 (part of Alan R. Baldwin's ASXXXX cross-assemblers package)

    charac = 0x03           ;Search Character for Scanning BASIC Text Input
    endchr = 0x04           ;Search Character for Statement Termination or Quote
    valtyp = 0x07           ;Data type of value: 0=numeric, 0xff=string
    intflg = 0x08           ;Type of number: 0=floating point, 0x80=integer
    subflg = 0x0a           ;Subscript flag; FN flag
    inpflg = 0x0b           ;Input flag: 0=INPUT, 0x40=GET, 0x98=READ
    channl = 0x10           ;Current I/O channel (CMD logical file) number for prompt-suppress
    temppt = 0x13           ;Next available slot in Descriptor Stack for Temp Strings (1 byte)
    tempst = 0x16           ;Descriptor Stack for Temp Strings (9 bytes: 3 slots of 3 bytes)
    index = 0x1f            ;Pointer: Utility (various uses)
    txttab = 0x28           ;Pointer: Start of BASIC text
    vartab = 0x2a           ;Pointer: Start of BASIC variables
    oldtxt = 0x3a           ;Pointer: Next BASIC statement for CONTINUE
    inpptr = 0x40           ;Pointer: INPUT, READ, and GET vector to save CHRGET
    forpnt = 0x46           ;Pointer: Index Variable for FOR/NEXT
    tmpptr = 0x48           ;Pointer: Various temporary storage uses
    facexp = 0x5e           ;Floating-Point Accumulator #1: Exponent
    chrget = 0x70           ;Subroutine: Get Next Byte of BASIC Text (patched)
    chrgot = 0x76           ;Subroutine: Get the Same Byte of BASIC Text again
    txtptr = 0x77           ;Pointer: Current Byte of BASIC Text
    satus = 0x96            ;KERNAL Status byte for I/O operations
    verchk = 0x9d           ;KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    iec_c3p0 = 0xa0         ;VC-1541-DOS Buffered Character Flag
    iec_bsour = 0xa5        ;VC-1541-DOS byte buffer for output (FF means no character)
    tapend = 0xab           ;Preserves X in CHRGET wedge ***
    ealptr = 0xb7           ;Pointer: end address for SAVE ***
    tapwct = 0xba           ;Tape write countdown ***
    salptr = 0xc9           ;Pointer: start address for LOAD or SAVE ***
    fnlen = 0xd1            ;Length of file name: 0=no name
    sa = 0xd3               ;Current secondary address
    fa = 0xd4               ;Current device number
    datax = 0xd9            ;Current Character to Print
    fnadr = 0xda            ;Pointer: Start of filename
    prscr = 0xeb            ;Print to screen vector
    ml1ptr = 0xfb           ;Pointer: start of tape address for .S ***
    iec_r2d2 = 0xfd         ;VC-1541-DOS EOI Flag
    iec_bsour1 = 0xfe       ;VC-1541-DOS Receive Byte (bits shifted in)
    iec_count = 0xff        ;VC-1541-DOS Count of bits to send or receive
    stkbot = 0x100          ;Lowest address of the stack page
    inpbuf = 0x200          ;Buffer used by INPUT, also MONITOR work area (0x200-0x250)
    dosbuf = 0x353          ;DOS command string buffer (0x353-0x380)
    def_iec_dev = 0x3fe     ;Default device number for IEC bus (default 8)
    cur_iec_dev = 0x3ff     ;Current IEC device number for in-progress wedge command
    mem_87d0_torl = 0x87d0  ;Stores TALK or LISTEN state: 0x40=TALK, 0x20=LISTEN

    error = 0xb3cf          ;BASIC Print error message offset by X in msgs table and return to prompt
    resbas = 0xb4ad         ;BASIC Reset execution to start, clear, and chain
    rsgetc = 0xb622         ;BASIC Reset GETCHR to start of program
    restor = 0xb7b7         ;BASIC Perform RESTORE
    okgoto = 0xb8c2         ;BASIC Perform GOTO or THEN if expression in IF evaluated to true
    qintgr = 0xb94d         ;BASIC Store integer or floating point number in [FORPNT]
    inpcom = 0xb965
    prstr = 0xbb1d          ;BASIC Print null-terminated string at A=addr low, Y=addr hi
    defdev = 0xbb44         ;BASIC Restore default devices
    doagin = 0xbb4c         ;BASIC Print error message for GET, INPUT, or READ
    extra = 0xbcda          ;BASIC ?EXTRA IGNORED if INPPTR is not at end of buffer
    frmevl = 0xbd98         ;BASIC Input and evaluate any expression
    chkcom = 0xbef5         ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    synchr = 0xbef7         ;BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A
    snerr  = 0xbf00         ;BASIC ?SYNTAX ERROR
    patchh = 0xbf21         ;BASIC Get the first char of a new statement
    ptrget = 0xc12b         ;BASIC Find a variable or create if not found; sets valtyp and varpnt
    strlit = 0xc5b0         ;BASIC Build descriptor for str literal termed by a quote at pointer AY
    strlt2 = 0xc5b6         ;BASIC Build descriptor for str lit termed by CHARAC or ENDCHAR at AY
    frestr = 0xc7b5         ;BASIC Discard temp string, returns A=length, XY=pointer to str
    gtbytc = 0xc8d1         ;BASIC Evaluate an expr for 1-byte param (0-255), return in X
    st2txt  = 0xc918        ;BASIC Copy STRNG2 (0x006E) to TXTPTR (0x0077)
    fin = 0xce29            ;BASIC Convert an ASCII string to a floating point number in FAC1
    linprt = 0xcf83         ;BASIC Print 256*A + X in decimal
    fout = 0xcf93           ;BASIC Convert FAC1 to an ASCII string, returns AY=pointer to str
    pr2spc = 0xd52e         ;BASIC Print two spaces
    prtcr = 0xd534          ;BASIC Print carriage return
    wroa = 0xd717           ;MONITOR Print word at (ml1ptr) as 4 hex digits
    hexit = 0xd78d          ;MONITOR Evaluate char in A to a hex nibble
    dprscr = 0xe787         ;EDITOR Default routine for PRSCR vector
    talk = 0xf0d2           ;KERNAL Send TALK to IEEE
    listn = 0xf0d5          ;KERNAL Send LISTEN to IEEE
    list1 = 0xf0d7          ;KERNAL Send a command byte to IEEE
    isour = 0xf109          ;KERNAL Send last byte to IEEE
    secnd = 0xf143          ;KERNAL Send Secondary Address to IEEE
    scatn = 0xf148          ;KERNAL Release ATN on IEEE
    ciout = 0xf19e          ;KERNAL Send a byte to IEEE
    untlk = 0xf1ae          ;KERNAL Send UNTALK to IEEE
    unlsn = 0xf1b9          ;KERNAL Send UNLISTEN to IEEE
    acptr = 0xf1c0          ;KERNAL Read a byte from IEEE
    prmsg = 0xf349          ;KERNAL Print a message from 0xF000 table at offset Y
    is7802 = 0xf351         ;KERNAL Compare TXTPTR+1: LDA 0x78; CMP #2; RTS
    srchng = 0xf449         ;KERNAL Print SEARCHING if in direct mode
    lodmsg = 0xf46d         ;KERNAL Print LOADING or VERIFYING if in direct mode
    openi = 0xf4a5          ;KERNAL Send LISTEN, OPEN and filename to IEEE
    nprsnt = 0xf4bb         ;KERNAL ?DEVICE NOT PRESENT ERROR
    notfnd = 0xf5ad         ;KERNAL ?FILE NOT FOUND ERROR
    krnerr = 0xf5b7         ;KERNAL ?<message> ERROR from KERNAL error in Y
    clsei = 0xf72f          ;KERNAL Send CLOSE, UNLISTEN to IEEE (also known as CLSE1)
    stop = 0xf92b           ;KERNAL Test STOP key and act if pressed
    chrout = 0xffd2         ;KERNAL Send a char to the current output device

    ;I/O Registers
    pia1_portb = 0xe812     ;PIA 1 Port B
    via_portb = 0xe840      ;VIA Port B
    via_porta = 0xe841      ;VIA Port A
    via_ddra = 0xe843       ;VIA DDR A
    via_timer_2_lo = 0xe848 ;VIA Timer 2 Low
    via_timer_2_hi = 0xe849 ;VIA Timer 2 High
    via_acr = 0xe84b        ;VIA ACR
    via_ifr = 0xe84d        ;VIA IFR

    ;IEEE-488 I/O Pin Assignments
    via_pb2_ieee_atn_out = 4  ;VIA PB2 IEEE-488 ATN output

    ;IEC I/O Pin Assignments
                              ;VIA PA7 IEC DATA in direct from IEC
                              ;VIA PA6 IEC CLK in direct from IEC
    via_pa5_iec_data_out = 32 ;VIA PA5 IEC DATA output to 7406
    via_pa4_iec_clk_out = 16  ;VIA PA4 IEC CLK output to 7406
    via_pa3_iec_atn_out = 8   ;VIA PA3 IEC ATN output to 7406
                              ;VIA PA2 unused
                              ;VIA PA1 unused
                              ;VIA PA0 unused

    ;BASIC tokens
    tok_load = 0x93         ;LOAD
    tok_save = 0x94         ;SAVE
    tok_verify = 0x95       ;VERIFY
    tok_catalog = 0xd7      ;CATALOG
    tok_open = 0x9f         ;OPEN
    tok_printn = 0x98       ;PRINT#
    tok_get = 0xa1          ;GET
    tok_close = 0xa0        ;CLOSE
    tok_inputn = 0x84       ;INPUT#
    tok_cmd = 0x9d          ;CMD

    ;PETSCII characters
    cr = 0x0d               ;Carriage return
    lf = 0x0a               ;Linefeed
    space = 0x20            ;Space

    ;6502 Opcodes
    opc_bit = 0x2c          ;BIT absaddr
    opc_bne = 0xd0          ;BNE reladdr
    opc_incz = 0xe6         ;INC zpaddr
    opc_jmp = 0x4c          ;JMP absaddr

    ;IEC Protocol
    iec_talk = 0x40         ;TALK command (hi nib; low nib = primary addr)
    iec_listen = 0x20       ;LISTEN command (hi nib; low nib = primary addr)
    iec_untalk = 0x5f       ;UNTALK command (untalks all addresses)
    iec_unlisten = 0x3f     ;UNLISTEN command (unlistens all addresses)
    iec_second = 0x60       ;SECOND command (hi nib; low nib = secondary addr)
    iec_open = 0xf0         ;OPEN command (hi nib; low nib = secondary addr)
    iec_close = 0xe0        ;CLOSE command (hi nib; low nib = secondary addr)
    iec_sa_load = 0         ;LOAD secondary address
    iec_sa_save = 1         ;SAVE secondary address
    iec_sa_cmd = 15         ;Command channel secondary address

    ;SATUS flags
    st_ok = 0               ;OK (all bits off)
    st_write = 1            ;Direction when timeout occurred = writing
    st_timeout = 2          ;Timeout error
    st_verify = 16          ;Verify error
    st_eof = 64             ;End of file
    st_notpres = 128        ;Device not present error

    ;VC-1541-DOS/80 was originally for 0xA000 (socket UD11) but this source is relocatable.
    ;It also works at 0x9000 (socket UD12) if the origin address is changed.  The origin
    ;address is set in the linker options (aslink command).
    .area vc1541dos

    ;Entry points at the beginning of the ROM
    ;Only the first two entry points are intended to be called from BASIC.  The others
    ;provide a "unified" or "universal" API for assembly programmers to control both
    ;IEC and IEEE-488 devices (the bus is determined by the device number in FA).

    jmp sub_a036_install        ;a000   Install the CHRGET patch to jump to the wedge
    jmp sub_a09c_command        ;a003   Perform a VC-1541-DOS command without wedge
    jmp sub_a377_uni_isour      ;a006   Send last byte to IEC or IEEE
    jmp sub_a382_uni_list1      ;a009   Send a command byte to IEC or IEEE
    jmp sub_a128_uni_openi      ;a00c   Send LISTEN, OPEN and filename to IEC or IEEE
    jmp sub_a128_uni_clsei      ;a00f   Send CLOSE, UNLISTEN to IEC or IEEE
    jmp sub_a141_uni_acptrs     ;a012   Read a byte from IEC or IEEE
    jmp sub_a306_uni_ciout      ;a015   Send a byte to IEC or IEEE
    jmp sub_a314_uni_listn      ;a018   Send LISTEN to IEC or IEEE
    jmp sub_a32a_uni_unlsn      ;a01b   Send UNLISTEN to IEC or IEEE
    jmp sub_a31f_uni_talk       ;a01e   Send TALK to IEC or IEEE
    jmp sub_a335_uni_untlk      ;a021   Send UNTALK to IEC or IEEE
    jmp sub_a345_uni_secnd      ;a024   Send secondary address for LISTEN to IEC or IEC
    jmp sub_a353_uni_tksa       ;a027   Send secondary address for TALK to IEC or IEEE
    jmp sub_a340_uni_lstksa     ;a02a   Send secondary address for TALK or LISTEN to IEC or IEEE
    jmp sub_a361_uni_atnon      ;a02d   Assert ATN on IEC or IEEE
    jmp sub_a36c_uni_scatn      ;a030   Release ATN on IEC or IEEE
    jmp sub_a119_jmp_uni_lstksa ;a033   Redundant; Jumps to sub_a340_uni_lstksa

;Install the CHRGET patch to jump to the wedge,
;then perform setup and print the banner.
;
;Before:                            After:
;
;chrget 0070 e6 77    inc txtptr    chrget 0070 4c 61 a0 jmp sub_a061_wedge  <--
;       0072 d0 02    bne chrgot
;       0074 e6 78    inc txtptr+1         0074 e6 78    inc txtptr+1
;chrgot 0076 ad 00 04 lda 0x0400    chrgot 0076 ad 00 04 lda 0x0400
;       0079 c9 ea    cmp #0xea            0079 c9 ea    cmp #0xea
;       007b b0 0a    bcs 0x0087           007b b0 0a    bcs 0x0087
;       007d c9 20    cmp #0x20            007d c9 20    cmp #0x20
;       007f f0 ef    beq chrget           007f f0 ef    beq chrget
;
;Note: TXTPTR is CHRGOT+1, meaning the code self-modifies its LDA instruction.
;
sub_a036_install:
    lda #opc_jmp            ;0070 4C 61 A0 JMP A061
    sta chrget
    lda #<sub_a061_wedge
    sta chrget+1
    lda #>sub_a061_wedge
    sta chrget+2

    lda #8
    sta def_iec_dev         ;Default device number to use for IEC bus = 8

    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0

    lda #<banner
    ldy #>banner
    jmp prstr               ;BASIC Print null-terminated string at A=addr low, Y=addr hi

banner:
    .ascii "VC-1541-DOS/80"
    .byte cr, 0

;Wedge
;The first instruction of CHRGET is patched to jump here.
;
sub_a061_wedge:
    ;Since we patched the first instruction of CHRGET to jump here,
    ;we need to increment TXTPTR as CHRGET would have done.
    inc txtptr
    bne lab_a067_nc
    inc txtptr+1

lab_a067_nc:
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
                            ;(This is actually getting it for the first time, as
                            ; the original CHRGET routine falls into CHRGOT.)
    php                     ;Save processor status after CHRGOT

    cmp #'!                 ;Is it the wedge character?
    bne lab_a090_not_exc    ;Branch if not

    ;Got the "!" wedge character; now look at the return address
    ;on the stack to see if we should parse it

    stx tapend              ;Save X before we use it
    tsx
    lda stkbot+3,x          ;A = high byte of (return address - 1)

    cmp #>(patchh+3-1)
    beq lab_a07d_high_match ;Branch if high byte of PATCHH+3 matches

    cmp #>(okgoto-1)
    bne lab_a08c_ignore_exc ;Branch if high byte does not match OKGOTO

;High byte of return address matches PATCHH+3 or OKGOTO
lab_a07d_high_match:
    lda stkbot+2,x          ;A = low byte of (return address - 1)

    ;Check if we are fetching the first char of a new statement.  If the return
    ;address is PATCHH+3, then GONE did JSR PATCHH, which just did JSR CHRGET
    ;(that's us) to get the char.

    cmp #<(patchh+3-1)
    beq lab_a092_parse_exc  ;Branch to parse if return address is PATCHH+3

    ;Return address is not PATCHH+3.

    ;Check if we are fetching the first char after THEN.  If the return address
    ;is OKGOTO, then IF did JSR SYNCHR to test for the THEN token.  SYNCHR found
    ;THEN, so it just did JMP CHRGET (that's us) to get the char.

    cmp #<(okgoto-1)
    bne lab_a08c_ignore_exc ;Branch to ignore if return address is not OKGOTO

    ;Return address is OKGOTO.  If the expression in the IF evaluated to true,
    ;FACEXP has been set to non-zero.

    lda facexp
    bne lab_a092_parse_exc  ;Branch to parse if the expression evaluated to true

    ;The expression in the IF statement evaluated to false,
    ;so fall through to ignore this "!".

;Character is a "!" but we are not parsing it
lab_a08c_ignore_exc:
    ldx tapend              ;Restore original X
    lda #'!                 ;Restore original A

;Character is not a "!"
lab_a090_not_exc:
    plp                     ;Restore processor status after CHRGOT
    rts                     ;Return to the caller of CHRGET

;Character is a "!" and we are parsing it
lab_a092_parse_exc:
    plp                     ;Restore processor status after CHRGOT
                            ;(not needed but we must pull it since we pushed it)

    jsr chrget              ;Get the byte after the "!", which is the VC-1541-DOS command

    lda def_iec_dev         ;A = Default device number for IEC bus (default 8)
    sta cur_iec_dev         ;Save as Current IEC device number for in-progress wedge command

    ;Fall through to perform command after "!"

;Perform a VC-1541-DOS command without wedge
;
;This is used by the wedge (immediately above) but is also an entry point
;in the jump table at the top.  It allows the VC-1541-DOS commands to be
;used from BASIC without installing the wedge.  For example:
;
;  SYS40963@                Print IEC command channel status
;  SYS40963LOAD"FILENAME"   Load a program from IEC
;
;Due to the way SYS parsing works, it's not possible to prefix the command
;with a temporary device number (such as "!9@" in the wedge).
;
sub_a09c_command:
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    pha
    jsr chrget
    pla

    cmp #tok_load
    beq lab_a10f_wedge_load

    cmp #tok_save
    bne lab_a0af_not_save
    jmp lab_a5e5_wedge_save

lab_a0af_not_save:
    cmp #tok_verify
    beq lab_a112_wedge_verify

    cmp #tok_catalog
    bne lab_a0ba_not_catalog
    jmp lab_a7c7_wedge_catalog

lab_a0ba_not_catalog:
    cmp #tok_open
    bne lab_a0c1_not_open
    jmp lab_a11c_wedge_open

lab_a0c1_not_open:
    cmp #tok_printn
    bne lab_a0c8_not_printn
    jmp lab_a175_wedge_printn

lab_a0c8_not_printn:
    cmp #tok_get
    bne lab_a0cf_not_get
    jmp lab_a1e0_wedge_get

lab_a0cf_not_get:
    cmp #tok_close
    bne lab_a0d6_not_close
    jmp lab_a133_wedge_close

lab_a0d6_not_close:
    cmp #tok_inputn
    bne lab_a0dd_not_inputn
    jmp lab_a226_wedge_inputn

lab_a0dd_not_inputn:
    cmp #tok_cmd
    bne lab_a0e4_not_cmd
    jmp lab_a14c_wedge_cmd

lab_a0e4_not_cmd:
    cmp #'Q
    bne lab_a0f5_not_quit

    ;Wedge command is !Q (Quit)
    ;Restore normal CHRGET processing; see "Before:" listing in sub_a036_install
    lda #opc_incz           ;0070 E6 77 INC 77
    sta chrget
    lda #<txtptr
    sta chrget+1
    lda #opc_bne            ;0072 D0 xx BNE ...
    sta chrget+2
    rts

lab_a0f5_not_quit:
    cmp #'@
    bne lab_a0fc_not_dos
    jmp lab_a586_wedge_dos

lab_a0fc_not_dos:
    ;None of the commands matched, so we assume that a device number
    ;follows the "!", such as in these examples:
    ;  !9@                Read command channel on device 9
    ;  !9LOAD"FILENAME"   Load program from device 9

    ;Decrement TXTPTR so GETBYTC can parse the number
    dec txtptr
    lda txtptr
    cmp #0xff
    bne lab_a106_no_borrow
    dec txtptr+1

lab_a106_no_borrow:
    ;Parse device number after the "!"
    jsr gtbytc+3          ;BASIC Evaluate integer 0-255, return it in X
    stx cur_iec_dev       ;Save as Current IEC device number for in-progress wedge command

    ;Loop to parse a wedge command after the device number.  A wedge command
    ;must follow the device number or a ?SYNTAX ERROR will result.
    jmp sub_a09c_command

;Wedge command !LOAD
;
;  !LOAD"FILENAME"        Load a program from an IEC device starting at the address in the file.
;                         The BASIC pointers `TXTTAB` and `VARTAB` will be updated.
;
;  !LOAD;"FILENAME"       Load a program from an IEC device starting at the address in the file.
;                         The BASIC pointers will not be changed.
;
;  !LOAD"FILENAME",027A   Load a program from an IEC device starting at the given address instead
;                         of the address in the file.  Only a start address may be given and it
;                         must be four hexadecimal digits.  The BASIC pointers will not be changed.
;
lab_a10f_wedge_load:
    lda #0                  ;A = 0 (LOAD)
    .byte opc_bit           ;Skip next 2 bytes

;Wedge command !VERIFY
;
;  !VERIFY"FILENAME"        Verify a program on an IEC device starting at the address in the file.
;
;  !VERIFY"FILENAME",027A   Verify a program on an IEC device starting at the given address instead
;                           of the address in the file.  Only a start address may be given and it
;                           must be four hexadecimal digits.
;
lab_a112_wedge_verify:
    lda #0xff              ;A = 0xFF (VERIFY) for VERCHK.  It's normally 0 or 1 but we set
                           ;it to 0xFF so we can test for verify with "bmi verchk" later.
    sta verchk             ;Store in KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    jmp lab_a6b7_load_or_verify

;Redundant; Jumps to Send secondary address for TALK or LISTEN to IEC or IEEE
sub_a119_jmp_uni_lstksa:
    jmp sub_a340_uni_lstksa;Send secondary address for TALK or LISTEN to IEC or IEEE

;Wedge command !OPEN
;
;Open a file on the current IEC device on the given secondary address.
;Sends LISTEN, OPEN, and filename to the device.
;
;  !OPEN#2,"FILENAME"     Open a file on secondary address 2.  The comma and the quotes
;                         are required.  The filename can not be empty.
;
lab_a11c_wedge_open:
    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
    jsr sub_a8a8_parse_sa_1 ;Parse #integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    jsr chkcom              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    ;Fall through

;Send LISTEN, OPEN and filename to IEC or IEEE
sub_a128_uni_openi:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a130_not_iec
    jmp sub_a689_openi      ;Send LISTEN, OPEN and filename to IEC

lab_a130_not_iec:
    jmp openi               ;Send LISTEN, OPEN and filename to IEEE


;Wedge command !CLOSE
;
;Close a file on the current IEC device on the given secondary address.
;Sends CLOSE, UNLISTEN to the device.
;
;  !CLOSE#2   Close a file on secondary address 2
;
;Note: this cannot be the very first command if the wedge
;is not installed because it does not call sub_a390_setup.
;
lab_a133_wedge_close:
    jsr sub_a8a8_parse_sa_1 ;Parse #integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    ;Fall through


;Send CLOSE, UNLISTEN to IEC or IEEE
sub_a128_uni_clsei:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a13e_not_iec
    jmp sub_a65e_clsei      ;Send CLOSE, UNLISTEN to IEC

lab_a13e_not_iec:
    jmp clsei               ;Send CLOSE, UNLISTEN to IEEE (also known as CLSE1)
                            ;
                            ;Note: the CBM sources for the PET KERNALs call this routine CLSE1,
                            ;but the CBM-II, VIC-20, and C64 KERNAL sources call it CLSEI.  A
                            ;DOS SUPPORT listing dated 1979 in the 2040 Service Manual also calls
                            ;it CLSEI.  To be consistent with OPENI, we call it CLSEI here too.


;Read a byte from IEC or IEEE
;
;Note: On IEC, this is not a normal ACPTR (sub_a50e_acptr).  It instead calls sub_a507_acptrs,
;      which first checks SATUS and does nothing if it is nonzero.  On IEEE-488, the normal
;      ACPTR routine in the KERNAL is called, which does not have this behavior.
;
sub_a141_uni_acptrs:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a149_not_iec
    jmp sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).

lab_a149_not_iec:
    jmp acptr               ;Read a byte from IEEE


;Wedge command !CMD
;
;Redirect output to the current IEC device on the given secondary address.
;If bit 7 of cur_iec_dev is set, CR will automatically be translated to CRLF.
;
;  !CMD#2   Redirect output to secondary address 2 on device FA.
;
;Note: this cannot be the very first command if the wedge
;is not installed because it does not call sub_a390_setup.
;
lab_a14c_wedge_cmd:
    jsr sub_a8a8_parse_sa_1 ;Parse #integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    lda #<lab_a15f_prscr
    sta prscr
    lda #>lab_a15f_prscr
    sta prscr+1
    jsr sub_a314_uni_listn  ;Send LISTEN to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jmp sub_a340_uni_lstksa ;Send secondary address for TALK or LISTEN to IEC or IEEE


;Routine installed in prscr vector
lab_a15f_prscr:
    lda datax               ;A = Current character to print
    cmp #cr                 ;Is it a carriage return?
    bne lab_a16f_no_lf
    ;It's a carriage return
    bit cur_iec_dev         ;Test Current IEC device number for in-progress wedge command
    bpl lab_a16f_no_lf      ;Branch if auto-linefeed mode is off
    ;Auto-linefeed mode is on
    ;Send the CR
    jsr sub_a306_uni_ciout  ;Send a byte to IEC or IEEE
    ;Send the LF
    lda #lf

lab_a16f_no_lf:
    jsr sub_a306_uni_ciout  ;Send a byte to IEC or IEEE
    jmp dprscr              ;EDITOR Default routine for PRSCR vector


;Wedge command !PRINT#
;
;Print to the given secondary address on the current IEC device.  If `!cmd#` was
;started, it is automatically ended first.  If bit 7 of cur_iec_dev is set, CR
;will automatically be translated to CRLF.
;
;  !PRINT#2           Print a blank line to secondary address 2.
;
;  !PRINT#2,"TEST"    Print an expression followed by a CR to secondary address 2.
;                     Multiple expressions can be combined with ";" such as
;                     PRINT#2,"TEST";X;A$.  Unlike CBM BASIC, expressions cannot
;                     be combined with a comma.  If a trailing ";" is given, do
;                     not send the CR at the end.
;
;Note: this cannot be the very first command if the wedge
;is not installed because it does not call sub_a390_setup.
;
lab_a175_wedge_printn:
    ;Are we in !CMD# mode?  If so, the PRSCR vector points to our routine.
    lda prscr
    cmp #<lab_a15f_prscr
    bne lab_a18c_not_in_cmd
    lda prscr+1
    cmp #>lab_a15f_prscr
    bne lab_a18c_not_in_cmd

    ;We're in !CMD# mode.  Before we !PRINT#, restore the default
    ;PRSCR routine and UNLISTEN to get out of CMD# mode.

    lda #<dprscr            ;EDITOR Default routine for PRSCR vector
    sta prscr
    lda #>dprscr            ;EDITOR Default routine for PRSCR vector
    sta prscr+1

    jsr sub_a32a_uni_unlsn  ;Send UNLISTEN to IEC or IEEE
    ;Fall through

;We're not in !CMD# mode.  Now do the !PRINT#.
lab_a18c_not_in_cmd:
    jsr sub_a8ad_parse_sa_2 ;Parse integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    jsr sub_a314_uni_listn  ;Send LISTEN to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_uni_lstksa ;Send secondary address for TALK or LISTEN to IEC or IEEE
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a1ce_send_crlf  ;Branch if not a comma to send CR or CRLF, UNLISTEN, and return

    ;Byte at txtptr+0 is a comma
    jsr chrget              ;Consume the comma

;Parse BASIC expression and send its value to IEC
lab_a19f_expr_loop:
    jsr frmevl              ;BASIC Input and evaluate any expression
    bit valtyp              ;Test type of value (0=numeric, 0xff=string)
    bmi lab_a1ac_str        ;Branch if value is a string

    ;Value is numeric, so make a string from it
    jsr fout                ;BASIC Convert FAC1 to an ASCII string, returns AY=pointer to str
    jsr strlit              ;BASIC Build descriptor for str literal termed by a quote at pointer AY

;Value is a string
lab_a1ac_str:
    jsr frestr              ;BASIC Discard temp string, returns A=length, XY=pointer to str
    sta fnlen               ;FNLEN = length of string

    ;Send the string to IEC
    ldy #0                  ;Y = 0 (string offset)

lab_a1b3_str_loop:
    cpy fnlen               ;Compare Y to length of string
    beq lab_a1bf_eos        ;Branch if end of string reached

    lda [index],y           ;A = byte from string
    jsr sub_a306_uni_ciout  ;Send a byte to IEC or IEEE
    iny                     ;Increment string offset
    bne lab_a1b3_str_loop   ;Branch if potentially more string to send

;End of string reached
lab_a1bf_eos:
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;Is byte at txtptr+0 a semicolon?
    bne lab_a1ce_send_crlf  ;Branch if not a semicolon to send CR or CRLF, UNLISTEN, and return

    ;Got a semicolon, so do not send a CRLF at the end
    jsr chrget              ;Consume semicolon
    beq lab_a1dd_done       ;Branch if end of BASIC statement reached

    ;Got more stuff after the semicolon
    jmp lab_a19f_expr_loop ;Branch to parse BASIC after delimiter (comma or semicolon)

;Byte at txtptr+0 is not a delimiter (semicolon or comma)
;Send CR or CRLF, depending on auto-linfeed mode bit
lab_a1ce_send_crlf:
    lda #cr                 ;A = carriage return
    jsr sub_a306_uni_ciout  ;Send a byte to IEC or IEEE

    bit cur_iec_dev         ;Test Current IEC device number for in-progress wedge command
    bpl lab_a1dd_done       ;Branch if auto-linefeed mode is off

    ;Auto-linefeed mode is on
    ;Send the LF
    lda #lf                 ;A = linefeed
    jsr sub_a306_uni_ciout  ;Send a byte to IEC or IEEE

lab_a1dd_done:
    jmp sub_a32a_uni_unlsn  ;Send UNLISTEN to IEC or IEEE

;Wedge command !GET
;
;Read a byte from the given secondary address on the current IEC device.
;
;  !GET#2,A$          Read a byte from secondary address 2.
;
;Note: this cannot be the very first command if the wedge
;is not installed because it does not call sub_a390_setup.
;
lab_a1e0_wedge_get:
    jsr sub_a8a8_parse_sa_1 ;Parse #integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    jsr chkcom              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma

    lda cur_iec_dev         ;A = Current IEC device number for in-progress wedge command
    and #0b01111111         ;Mask off bit 7 auto-linefeed flag
    sta channl              ;Store Current I/O channel (CMD logical file) number for prompt-suppress
    jsr sub_a31f_uni_talk   ;Send TALK to IEC or IEEE

    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_uni_lstksa ;Send secondary address for TALK or LISTEN to IEC or IEEE

    ldx #<(inpbuf+1)        ;XY = pointer to inpbuf+1
    ldy #>(inpbuf+1)
    lda #0                  ;A = NULL (0x00) character to terminate the string
    sta inpbuf+1            ;Store in INPUT buffer (0x200-0x250)

    lda #0x40               ;A=0x40 (Input flag: GET)
    jmp lab_a245_get_or_input

;Read a CR-terminated string from IEC into INPBUF, set XY = INPBUF-1
;-1 because callers copy XY to TXTPTR and call CHRGET or PTRGET, which increment TXTPTR first
;The CR (0x0D) is replaced with NULL (0x00).
;Jumps to ?STRING TO LONG ERROR if string did not fit
sub_a203_read_str:
    ldx #0

lab_a205_loop:
    jsr sub_a141_uni_acptrs ;Read a byte from IEC or IEEE.  On IEC only, check SATUS first:
                            ;  If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    cmp #cr
    beq lab_a21c_cr         ;Branch if a carriage return was received or if an error occurred

    sta inpbuf,x            ;Store in INPUT buffer (0x200-0x250)
    inx
    cpx #0x51
    bne lab_a205_loop       ;Branch to get another byte if still within buffer size

    ;Next byte would exceed INPBUF buffer size
    jsr sub_a335_uni_untlk  ;Send UNTALK to IEC or IEEE
    ldx #0xb0               ;X = 0xB0 (?STRING TOO LONG ERROR)
    jmp error               ;BASIC Print error message offset by X in msgs table and return to prompt

lab_a21c_cr:
    lda #0                  ;A = NULL (0x00) to replace CR in buffer
    sta inpbuf,x            ;Store NULL in INPUT buffer (0x200-0x250)
    ldx #<(inpbuf-1)        ;XY = Pointer to inpbuf-1
    ldy #>(inpbuf-1)
    rts

;Wedge command !INPUT#
;
;Read CR-delimited data from the given secondary address on an IEC device
;into one or more variables separated by commas.
;
;  !INPUT#15,A,B$,C,D   Read the command channel of a drive.
;
;Note: this cannot be the very first command if the wedge
;is not installed because it does not call sub_a390_setup.
;
lab_a226_wedge_inputn:
    jsr sub_a8ad_parse_sa_2 ;Parse integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
    jsr chkcom              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a31f_uni_talk   ;Send TALK to IEC or IEEE

    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_uni_lstksa ;Send secondary address for TALK or LISTEN to IEC or IEEE

    lda cur_iec_dev         ;A = Current IEC device number for in-progress wedge command
    and #0b01111111         ;Mask off bit 7 auto-linefeed flag
    sta channl              ;Store Current I/O channel (CMD logical file) number for prompt-suppress

    lda #',                 ;Add a comma before INPUT buffer so every chunk start with a comma.
    sta inpbuf-1            ;See "Programming the PET/CBM" page 79 "How INPUT and INPUT# Work"
    jsr sub_a203_read_str   ;Read a CR-terminated string from IEC into inpbuf, set XY = inpbuf-1
    lda #0                  ;A=0 (Input flag: 0=INPUT)

lab_a245_get_or_input:
    sta inpflg              ;Store 0 or 0x40 as Input flag: 0=INPUT, 0x40=GET, 0x98=READ
    ;Copy pointer returned from sub_a203_read_str into INPPTR
    stx inpptr              ;INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1

lab_a24b_input_loop:
    ;Set FORPNT to location of variable
    jsr ptrget              ;BASIC Find a variable or create if not found; sets valtyp and varpnt
    sta forpnt              ;Pointer: Index Variable for FOR/NEXT
    sty forpnt+1

    ;Copy TXTPTR to TMPPTR
    lda txtptr
    ldy txtptr+1
    sta tmpptr              ;Pointer: Various temporary storage uses
    sty tmpptr+1

    ;Copy INPPTR to TXTPTR
    ldx inpptr              ;INPUT, READ, and GET vector to save CHRGET
    ldy inpptr+1
    stx txtptr
    sty txtptr+1

    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    bne lab_a285            ;Branch if not end of BASIC statement

    ;End of BASIC statement
    bit inpflg              ;Input flag: 0=INPUT, 0x40=GET, 0x98=READ (will be 0 or 0x40 only)
    bvc lab_a277_input      ;Branch is Input flag is INPUT

    ;Input flag is GET
    jsr sub_a141_uni_acptrs ;Read a byte from IEC or IEEE.  On IEC only, check SATUS first:
                            ;  If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta inpbuf              ;Store in input buffer used by MONITOR (0x200-0x250)
    ldx #<(inpbuf-1)        ;XY = pointer to inpbuf-1
    ldy #>(inpbuf-1)        ;     (-1 because CHRGET increments first)
    bne lab_a281            ;Branch always

lab_a277_input:
    lda channl              ;A = Current I/O channel (CMD logical file) number for prompt-suppress
    bne lab_a27e_not_keyb   ;Branch if it is not 0 (keyboard; the default input device)

    jsr defdev              ;BASIC Restore default devices

lab_a27e_not_keyb:
    jsr sub_a203_read_str   ;Read a CR-terminated string from IEC into inpbuf, set XY = inpbuf-1

lab_a281:
    ;Copy pointer in XY to TXTPTR
    stx txtptr
    sty txtptr+1

lab_a285:
    jsr chrget
    bit valtyp              ;Test type of value (0=numeric, 0xff=string)
    bpl lab_a2bd_numeric    ;Branch if not a string

    ;Value is a string
    bit inpflg              ;Input flag: 0=INPUT, 0x40=GET, 0x98=READ (will be 0 or 0x40 only)
    bvc lab_a299_input      ;Branch if Input flag is INPUT

    ;Input flag is GET
    inx
    stx txtptr
    lda #0
    sta charac              ;Store as Search Character for Scanning BASIC Text Input
    beq lab_a2a5            ;Branch always

;Input flag is INPUT
lab_a299_input:
    sta charac              ;Store as Search Character for Scanning BASIC Text Input
    cmp #'"
    beq lab_a2a6
    lda #':
    sta charac              ;Store as Search Character for Scanning BASIC Text Input
    lda #',

lab_a2a5:
    clc

lab_a2a6:
    sta endchr              ;Store as Search Character for Statement Termination or Quote

    ;Increment TXTPTR
    lda txtptr
    ldy txtptr+1
    adc #0
    bcc lab_a2b1_nc
    iny

lab_a2b1_nc:
    jsr strlt2              ;BASIC Build descriptor for str lit termed by CHARAC or ENDCHAR at AY
    jsr st2txt              ;BASIC Copy STRNG2 (0x006E) to TXTPTR (0x0077)
    jsr inpcom
    jmp lab_a2c5

lab_a2bd_numeric:
    jsr fin                 ;BASIC Convert an ASCII string to a floating point number in FAC1
    lda intflg              ;A = type of number (used by QINTGR)
    jsr qintgr              ;BASIC Store integer or floating point number in [FORPNT]

lab_a2c5:
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2d1_null_comma ;Branch if null
    cmp #',
    beq lab_a2d1_null_comma ;Branch if comma

    ;Not a null or a comma
    jmp doagin              ;BASIC Print error message for GET, INPUT, or READ

lab_a2d1_null_comma:
    ;Copy TXTPTR to INPPTR
    lda txtptr
    ldy txtptr+1
    sta inpptr              ;INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1

    ;Copy TMPPTR to TXTPTR
    lda tmpptr              ;Pointer: Various temporary storage uses
    ldy tmpptr+1
    sta txtptr
    sty txtptr+1

    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2ec_eos        ;Branch if end of statement reached

    jsr chkcom              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jmp lab_a24b_input_loop

lab_a2ec_eos:
    jsr extra               ;BASIC ?EXTRA IGNORED if INPPTR is not at end of buffer
    jsr sub_a335_uni_untlk  ;Send UNTALK to IEC or IEEE
    lda #0                  ;A = 0 (keyboard; the default input device)
    sta channl              ;Store Current I/O channel (CMD logical file) number for prompt-suppress
    rts

copyright:
    .ascii "(C) G MUTZ (84)"


;Send a byte to IEC or IEEE
sub_a306_uni_ciout:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a310_not_iec
    pla
    jmp sub_a4d2_ciout      ;Send a byte to IEC

lab_a310_not_iec:
    pla
    jmp ciout               ;Send a byte to IEEE


;Send LISTEN to IEC or IEEE
sub_a314_uni_listn:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a31c_not_iec
    jmp sub_a3f2_listn      ;Send LISTEN to IEC

lab_a31c_not_iec:
    jmp listn               ;KERNAL Send LISTEN to IEEE


;Send TALK to IEC or IEEE
sub_a31f_uni_talk:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a327_not_iec
    jmp sub_a3ef_talk       ;Send TALK to IEC

lab_a327_not_iec:
    jmp talk                ;KERNAL Send TALK to IEEE


;Send UNLISTEN to IEC or IEEE
sub_a32a_uni_unlsn:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a332_not_iec
    jmp sub_a4ef_unlsn      ;Send UNLISTEN to IEC

lab_a332_not_iec:
    jmp unlsn               ;KERNAL Send UNLISTEN to IEEE


;Send UNTALK to IEC or IEEE
sub_a335_uni_untlk:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a33d_not_iec
    jmp sub_a4e4_untlk      ;Send UNTALK to IEC

lab_a33d_not_iec:
    jmp untlk               ;KERNAL Send UNTALK to IEEE


;Send secondary address for TALK or LISTEN to IEC or IEEE
sub_a340_uni_lstksa:
    bit mem_87d0_torl       ;Bit test for TALK or LISTEN state
    bvs sub_a353_uni_tksa   ;If we sent TALK, branch to send
                            ;  secondary address for TALK to IEC or IEEE
    ;We sent LISTEN so fall through

;Send secondary address for LISTEN to IEC or IEC
sub_a345_uni_secnd:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a34f_not_iec
    pla
    jmp sub_a49c_secnd      ;Send secondary address for LISTEN to IEC

lab_a34f_not_iec:
    pla
    jmp secnd               ;KERNAL Send Secondary Address to IEEE


;Send secondary address for TALK to IEC or IEEE
sub_a353_uni_tksa:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a35d_not_iec
    pla
    jmp sub_a4bc_tksa       ;Send secondary address for TALK to IEC

lab_a35d_not_iec:
    pla
    jmp secnd               ;KERNAL Send Secondary Address to IEEE


;Assert ATN on IEC or IEEE
sub_a361_uni_atnon:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a369_not_iec
    jmp sub_a4aa_atnon      ;Assert ATN (turns VIA PA3 on)

lab_a369_not_iec:
    jmp sub_a4b3_ieee_aton  ;Assert ATN on IEEE (turns VIA PB2 off)


;Release ATN on IEC or IEEE
sub_a36c_uni_scatn:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a374_not_iec
    jmp sub_a4a1_scatn      ;Release ATN on IEC

lab_a374_not_iec:
    jmp scatn               ;Release ATN on IEEE


;Send last byte to IEC or IEEE
sub_a377_uni_isour:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a37f_not_iec
    jmp sub_a423_isour      ;Send last byte to IEC

lab_a37f_not_iec:
    jmp isour               ;KERNAL Send last byte to IEEE


;Send a command byte to IEC or IEEE
;Command byte in A can be 0x20=LISTEN, 0x3F=UNLISTEN, 0x40=TALK, 0x5F=UNTALK
;and this routine will OR it with the device address (FA).
sub_a382_uni_list1:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a38c_not_iec
    pla
    jmp sub_a3f4_list1      ;Send a command byte to IEC

lab_a38c_not_iec:
    pla
    jmp list1               ;KERNAL Send a command byte to IEEE


;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
sub_a390_setup:
    lda #0b00111111
    sta via_ddra

    lda #0
    sta via_timer_2_lo
    sta via_timer_2_hi
    sta via_acr

    lda #',                 ;A = "," (Update BASIC pointers on !LOAD)
    sta tapwct              ;Store as TAPWCT (","=update BASIC pointers on !LOAD, ";"=do not)

    lda #0b00010111
    sta via_porta

    lda #0b10000000
    sta iec_r2d2            ;Set the EOI flag

    ;Fall through

;Set FA = IEC device for in-progress command, set SATUS = 0
sub_a3ad_set_fa_st:
    lda cur_iec_dev         ;A = Current IEC device number for in-progress wedge command
    and #0b01111111         ;Mask off bit 7 auto-linefeed flag
    sta fa                  ;Set KERNAL current device number

    lda #st_ok
    sta satus               ;KERNAL SATUS = 0 (no error)
    rts

;==================================================================================================
;Start of code based on C64 KERNAL
;==================================================================================================

;XXX Order of clklo and clkhi subroutines is swapped in C64 KERNAL.

;Set clock line low (holds IEC CLK to GND)
;Write 1 to VIA port bit, so 7406 output is GND
sub_a3b9_clklo:
    lda via_porta
    ora #via_pa4_iec_clk_out
    sta via_porta
    rts

;Set clock line high (allows IEC CLK to be pulled to 5V)
;Write 0 to VIA port bit, so 7406 output is Hi-Z
sub_a3c2_clkhi:
    lda via_porta
    and #~via_pa4_iec_clk_out
    sta via_porta
    rts

;Set data line high (allows IEC DATA to be pulled up to 5V)
;Write 0 to VIA port bit, so 7406 output is Hi-Z
sub_a3cb_datahi:
    lda via_porta
    and #~via_pa5_iec_data_out
    sta via_porta
    rts

;Set data line low (holds IEC DATA to GND)
;Write 1 to VIA port bit, so 7406 output is GND
sub_a3d4_datalo:
    lda via_porta
    ora #via_pa5_iec_data_out
    sta via_porta
    rts

;Debounce VIA PA then ASL A
sub_a3dd_debpia:
    lda via_porta
    cmp via_porta
    bne sub_a3dd_debpia     ;Debounce VIA PA then ASL A
    asl a                   ;Shift the data bit into the carry...
    rts                     ;...and the clock into neg flag

;Delay 1 ms using loop
sub_a3e7_w1ms:
    txa                     ;Save .X
    ldx #0xc0               ;XXX value is different from C64, which has 0xB8
lab_a3ea_w1ms1:             ;5us loop
    dex
    bne lab_a3ea_w1ms1
    tax                     ;Restore X
    rts

;Send TALK to IEC
;XXX different from C64 KERNAL
sub_a3ef_talk:
    lda #iec_talk           ;A = 0x40 (TALK)
    .byte opc_bit           ;Skip next 2 bytes

;Send LISTEN to IEC
;XXX different from C64 KERNAL
sub_a3f2_listn:
    lda #iec_listen         ;A = 0x20 (LISTEN)
    ;Fall through

;Send a command byte to IEC
;XXX This first instruction to remember the command is a VC-1541-DOS addition.
;It exists to support sub_a340_uni_lstksa (also a VC-1541-DOS addition), which is
;used by !CMD#, !PRINT#, !GET#, and !INPUT#.  Call here instead of the real
;LIST1 immediately below.
sub_a3f4_list1:
    sta mem_87d0_torl       ;Remember if we sent TALK (0x40) or LISTEN (0x20)

;Start of real LIST1 from C64 KERNAL
sub_a3f7_c64_list1:
    ora fa                  ;XXX different from C64 KERNAL
                            ;OR the command with FA (device address)
    pha

    bit iec_c3p0            ;Character left in buf?
    bpl lab_a408_list2      ;No...

    ;Send buffered character
    sec                     ;Set EOI flag
    ror iec_r2d2
    jsr sub_a423_isour      ;Send last character
    lsr iec_c3p0            ;Buffer clear flag
    lsr iec_r2d2            ;Clear EOI flag

lab_a408_list2:
    pla                     ;TALK/LISTEN address
    sta iec_bsour           ;VC-1541-DOS byte buffer for output (FF means no character)
    sei
    jsr sub_a3cb_datahi     ;Set data line high
    cmp #iec_unlisten       ;CLKHI only on UNLISTEN
    bne lab_a416_list5
    jsr sub_a3c2_clkhi      ;Set clock line high

lab_a416_list5:
    jsr sub_a4aa_atnon      ;Assert ATN (turns VIA PA3 on)
                            ;XXX different from C64 but does the same thing
sub_a419_isoura:
    sei
    jsr sub_a3b9_clklo      ;Set clock line low
    jsr sub_a3cb_datahi     ;Set data line high
    jsr sub_a3e7_w1ms       ;Delay 1 ms

sub_a423_isour:
    sei
    jsr sub_a3cb_datahi     ;Make sure data is released / Set data line high
    jsr sub_a3dd_debpia     ;Data should be low / Debounce VIA PA then ASL A
    bcs lab_a490_notpres    ;Branch to device not present error
    jsr sub_a3c2_clkhi      ;Set clock line high
    bit iec_r2d2            ;EOI flag test
    bpl lab_a43d_noeoi

;Do the EOI
lab_a433_isr02:
    jsr sub_a3dd_debpia     ;Wait for DATA to go high / Debounce VIA PA then ASL A
    bcc lab_a433_isr02

lab_a438_isr03:
    jsr sub_a3dd_debpia     ;Wait for DATA to go low / Debounce VIA PA then ASL A
    bcs lab_a438_isr03

lab_a43d_noeoi:
    jsr sub_a3dd_debpia     ;Wait for DATA high / Debounce VIA PA then ASL A
    bcc lab_a43d_noeoi
    jsr sub_a3b9_clklo      ;Set clock line low

    ;Set to send data
    lda #8                  ;Count 8 bits
    sta iec_count

lab_a449_isr01:
    lda via_porta           ;Debounce the bus
    cmp via_porta
    bne lab_a449_isr01
    asl a                   ;Set the flags
    bcc lab_a493_frmerr     ;Data must be high
    ror iec_bsour           ;Next bit into carry
    bcs lab_a45d_isrhi
    jsr sub_a3d4_datalo     ;Set data line low
    bne lab_a460_isrclk

lab_a45d_isrhi:
    jsr sub_a3cb_datahi     ;Set data line high

lab_a460_isrclk:
    jsr sub_a3c2_clkhi      ;Set clock line high
    nop
    nop
    nop
    nop
    lda via_porta
    and #~via_pa5_iec_data_out  ;Data high
    ora #via_pa4_iec_clk_out    ;Clock low
    sta via_porta
    dec iec_count
    bne lab_a449_isr01
    lda #0                  ;XXX does not match C64 KERNAL
    sta via_timer_2_lo
    lda #0x04               ;Trigger timer
    sta via_timer_2_hi
    lda via_ifr             ;Clear the timer flags

lab_a482_isr04:
    lda via_ifr
    and #0x20               ;XXX does not match C64 KERNAL, since C64 has CIA and PET has VIA
    bne lab_a493_frmerr     ;Branch to write timeout error
    jsr sub_a3dd_debpia     ;Debounce VIA PA then ASL A
    bcs lab_a482_isr04
    cli
    rts

lab_a490_notpres:
    lda #st_notpres         ;A = SATUS bit for device not present error
    .byte opc_bit           ;Skip next 2 bytes

lab_a493_frmerr:
    lda #st_timeout|st_write;A = SATUS bits timeout during write
                            ;(C64 KERNAL calls this "framing")

;Commodore Serial Bus Error Entry
lab_a495_csberr:
    jsr sub_a580_udst       ;KERNAL SATUS = SATUS | A
    cli                     ;IRQ's were off...turn on
    clc                     ;Make sure no KERNAL error returned
    bcc lab_a4f3_dlabye     ;Branch always to turn ATN off, release all lines

;Send secondary address for LISTEN to IEC
sub_a49c_secnd:
    sta iec_bsour           ;Buffer character
    jsr sub_a419_isoura     ;Send it

;Release ATN after LISTEN
sub_a4a1_scatn:
    lda via_porta
    and #~via_pa3_iec_atn_out
    sta via_porta          ;Release ATN
    rts

;Assert ATN
;XXX this routine does not exist in the C64 KERNAL
;Turn VIA PA3 on (ATN out)
sub_a4aa_atnon:
    lda via_porta
    ora #via_pa3_iec_atn_out
    sta via_porta
    rts

;Assert ATN on IEEE (turns VIA PB2 off)
;XXX obviously being IEEE this routine does not exist in C64 KERNAL
sub_a4b3_ieee_aton:
    lda via_portb
    and #~via_pb2_ieee_atn_out
    sta via_portb
    rts

;Send secondary address for TALK to IEC
sub_a4bc_tksa:
    sta iec_bsour           ;Buffer character
    jsr sub_a419_isoura     ;Send secondary address
    sei                     ;No IRQ's here
    jsr sub_a3d4_datalo     ;Set data line low
    jsr sub_a4a1_scatn      ;Release ATN
    jsr sub_a3c2_clkhi      ;Set clock line high

lab_a4cb_tkatn1:
    jsr sub_a3dd_debpia     ;Wait for clock to go low / Debounce VIA PA then ASL A
    bmi lab_a4cb_tkatn1
    cli                     ;IRQ's okay now
    rts

;Send a byte to IEC
;Buffered output to IEC
sub_a4d2_ciout:
    bit iec_c3p0            ;Buffered char?
    bmi lab_a4db_ci2        ;Yes...send last

    sec                     ;No...
    ror iec_c3p0            ;Set buffered char flag
    bne lab_a4e0_ci4        ;Branch always

lab_a4db_ci2:
    pha                     ;Save current char
    jsr sub_a423_isour      ;Send last char
    pla                     ;Restore current char

lab_a4e0_ci4:
    sta iec_bsour           ;Buffer current char
    clc                     ;Carry-Good exit
    rts

;Send UNTALK to IEC
sub_a4e4_untlk:
    sei
    jsr sub_a3b9_clklo      ;Set clock line low
    jsr sub_a4aa_atnon      ;Assert ATN (turns VIA PA3 on)
    lda #iec_untalk         ;A = 0x5F (UNTALK)
    .byte opc_bit           ;Skip next 2 bytes

;Send UNLISTEN to IEC
sub_a4ef_unlsn:
    lda #iec_unlisten       ;A = 0x3F (UNLISTEN)
    jsr sub_a3f7_c64_list1  ;Send it

;Release all lines
lab_a4f3_dlabye:
    jsr sub_a4a1_scatn      ;Always release ATN

;Delay approx 60 us then release clock and data
sub_a4f6_dladlh:
    txa                     ;Delay approx 60 us
    ldx #10

lab_a4f9_dlad00:
    dex
    bne lab_a4f9_dlad00
    tax
    jsr sub_a3c2_clkhi      ;Set clock line high

    lda #0                  ;XXX different from C64 KERNAL
    sta iec_c3p0            ;XXX

    jmp sub_a3cb_datahi     ;Set data line high

;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
;XXX This is unique to VC-1541-DOS and is not from the C64 KERNAL.
sub_a507_acptrs:
    lda satus               ;A = last SATUS
    beq sub_a50e_acptr      ;Branch to do ACPTR if SATUS is OK
    ;SATUS != 0
    lda #cr                 ;A = carriage return
    rts

;Read a byte from IEC
;Input a byte from serial bus
sub_a50e_acptr:
    sei                     ;No IRQ allowed
    lda #0                  ;Set EOI/ERROR Flag
    sta iec_count
    jsr sub_a3c2_clkhi      ;Make sure clock line is released / Set clock line high

lab_a516_acp00a:
    jsr sub_a3dd_debpia     ;Wait for clock high / Debounce VIA PA then ASL A
    bpl lab_a516_acp00a

lab_a51b_eoiacp:
    lda #0                  ;XXX
    sta via_timer_2_lo      ;XXX Order of VIA registers is different from CIA
    lda #1                  ;XXX registers in C64 KERNAL, but values are the same
    sta via_timer_2_hi      ;XXX

    jsr sub_a3cb_datahi     ;Data line high (Makes timing more like VIC-20) / Set data line high
    lda via_ifr             ;Clear the timer flags

lab_a52b_acp00:
    lda via_ifr             ;Check the timer
    and #0x20               ;XXX Different from C64 KERNAL, since C64 has CIA and PET has VIA
    bne lab_a539_acp00b     ;Ran out...
    jsr sub_a3dd_debpia     ;Check the clock line / Debounce VIA PA then ASL A
    bmi lab_a52b_acp00      ;No, not yet
    bpl lab_a551_acp01      ;Yes...

lab_a539_acp00b:
    lda iec_count      ;Check for error (twice thru timeouts)
    beq lab_a542_acp00c
    lda #st_timeout         ;A = SATUS bit for timeout error
    jmp lab_a495_csberr     ;ST = 2 read timeout

;Timer ran out, do an EOI thing
lab_a542_acp00c:
    jsr sub_a3d4_datalo     ;Set data line low
    jsr sub_a3c2_clkhi      ;Delay and then set DATAHI (fix for 40us C64) / Set clock line high
    lda #st_eof             ;A = SATUS bit for End of File (EOF)
    jsr sub_a580_udst       ;KERNAL SATUS = SATUS | A
    inc iec_count      ;Go around again for error check on EOI
    bne lab_a51b_eoiacp

;Do the byte transfer
lab_a551_acp01:
    lda #8                  ;Set up counter
    sta iec_count

lab_a555_acp03:
    lda via_porta           ;Wait for clock high
    cmp via_porta           ;Debounce
    bne lab_a555_acp03
    asl a                   ;Shift data into carry
    bpl lab_a555_acp03      ;Clock still low...
    ror iec_bsour1          ;Rotate data in

lab_a562_acp03a:
    lda via_porta           ;Wait for clock low
    cmp via_porta           ;Debounce
    bne lab_a562_acp03a
    asl a
    bmi lab_a562_acp03a
    dec iec_count
    bne lab_a555_acp03      ;More bits...
    ;...exit...
    jsr sub_a3d4_datalo     ;Set data line low
    bit satus               ;Check for EOI
    bvc lab_a57b_acp04      ;None...

    jsr sub_a4f6_dladlh     ;Delay approx 60 then set data high

lab_a57b_acp04:
    lda iec_bsour1
    cli                     ;IRQ is OK
    clc                     ;Good exit
    rts

;KERNAL SATUS = SATUS or A
sub_a580_udst:
    ora satus
    sta satus
    rts

;XXX never used
sub_a585_settmo:
    rts                     ;XXX no timeout is actually set

;==================================================================================================
;End of code based on C64 KERNAL
;==================================================================================================

;Wedge Command !@
;
;  !@     Read the command channel and print it.
;
;  !@"V"  Send an arbitrary string to the command channel.  It must be quoted.
;
lab_a586_wedge_dos:
    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    bne lab_a591_more       ;Branch if end of BASIC statement not yet reached

    ;Nothing after @ so jump to print device status
    jmp sub_a83c_rd_cmd_ch  ;Jump out to Read the IEC command channel and print it

    ;Something after the @
lab_a591_more:
    cmp #'U
    bne lab_a5c2_not_u
    ;Character = "U"
    jsr chrget              ;Consume the "U"
    jsr gtbytc+3            ;BASIC Evaluate integer 0-255, return it in X
    txa                     ;A = evaluated integer after the "U"

    ;Set up pointer to DOSBUF
    ldx #<dosbuf
    ldy #>dosbuf
    stx index
    sty index+1

    ldy #mem_a834_m_w_len   ;Y = 8
    sty fnlen               ;FNLEN = 8 (length of command to change drive's device number)

    dey                     ;Now Y = 7
    and #0x0f               ;A = Force device number in range 0-15
                            ;    (also clears bit 7 auto-linefeed flag)
    sta cur_iec_dev         ;Store as Current IEC device number for in-progress wedge command

    ;A = new device number and is in range 0-15

    ;Write TALK byte into M-W command in DOSBUF
    ora #iec_talk           ;Turn on bit 6 (TALK)
    sta [index],y           ;Store A in DOSBUF+7
                            ;  0x0078: IEC bus TALK command to accept (device num | 0x40).

    ;Write LISTEN byte into M-W command in DOSBUF
    eor #iec_talk|iec_listen;Turn off bit 6 (TALK), turn on bit 5 (LISTEN)
    dey                     ;Now Y = 6
    sta [index],y           ;Store A in DOSBUF+6
                            ;  0x0077: IEC bus LISTEN command to accept (device num | 0x20).

    dey                     ;Now Y = 5

    ;Write the rest of the M_W command into DOSBUF
lab_a5b8_loop:
    lda mem_a834_m_w,y      ;A = command to change drive's device number
    sta [index],y           ;Store in DOSBUF
    dey
    bpl lab_a5b8_loop

    ;DOSBUF now contains command to change the drive's current device number,
    ;INDEX and FNLEN have been set up for it, so branch to send it
    bmi lab_a5ca_send_dos_cmd ;Branch always

lab_a5c2_not_u:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temp string, returns A=length, XY=pointer to str
    sta fnlen

;Send DOS command in buffer [INDEX]
;
;Call with INDEX = pointer to buffer with command string
;      and FNLEN = length of command
;
lab_a5ca_send_dos_cmd:
    lda #st_ok
    sta satus               ;KERNAL SATUS = 0 (no error)
    jsr sub_a3f2_listn      ;Send LISTEN to IEC
    lda #iec_second | iec_sa_cmd ;A = 0x60 (SECOND) | 0x0F (Command Channel)
    jsr sub_a49c_secnd      ;Send secondary address for LISTEN to IEC

    ldy #0

lab_a5d8_loop:
    lda [index],y           ;A = byte from string to send to command channel
    jsr sub_a4d2_ciout      ;Send a byte to IEC
    iny
    cpy fnlen
    bne lab_a5d8_loop

    jmp sub_a4ef_unlsn      ;Send UNLISTEN to IEC

;Wedge command !SAVE
;
;  !SAVE"FILENAME"            Saves the current BASIC program
;
;  !SAVE"FILENAME",027A,0300  Save memory from 0x027A-0x02FF inclusive.
;                             Both addresses are required and must be 4 hex digits.
;
lab_a5e5_wedge_save:
    jsr sub_a5eb_save       ;Try to save the file as requested
    jmp sub_a83c_rd_cmd_ch  ;Read the IEC command channel and print it

sub_a5eb_save:
    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    lda #iec_second | iec_sa_save ;A =  0x60 (SECOND) | secondary address 1 (SAVE)
    sta sa                  ;Set SA (KERNAL current secondary address)
    ldy fnlen
    bne lab_a5fc_fnlen_ok   ;Branch if filename is not empty
    ;Filename is empty
    jmp snerr               ;BASIC ?SYNTAX ERROR

lab_a5fc_fnlen_ok:
    jsr sub_a689_openi      ;Send LISTEN, OPEN and filename to IEC
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a623_no_addr    ;Branch if it's not a comma
    ;Found a comma
    jsr chrget              ;Consume the comma
    ;Parse start address for SAVE into salptr
    jsr sub_a861_parse_addr ;Parse a 4-digit hex address from BASIC text into ml1ptr
    lda ml1ptr
    sta salptr
    lda ml1ptr+1
    sta salptr+1
    ;Parse end address for SAVE into ealptr
    jsr chkcom              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a861_parse_addr ;Parse a 4-digit hex address from BASIC text into ml1ptr
    lda ml1ptr
    sta ealptr
    lda ml1ptr+1
    sta ealptr+1
    jmp lab_a633_with_addr

;No start/end address supplied with !SAVE command, so use BASIC program area (from TXTTAB to VARTAB)
lab_a623_no_addr:
    ;Set start address for SAVE in salptr
    lda txttab
    sta salptr
    lda txttab+1
    sta salptr+1
    ;Set end address for SAVE in ealptr
    lda vartab
    sta ealptr
    lda vartab+1
    sta ealptr+1
    ;Fall through

;Perform SAVE.  Start address in salptr, end address in ealptr
lab_a633_with_addr:
    jsr sub_a3f2_listn     ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL secondary address; already set up for SAVE in sub_a5eb_save
    jsr sub_a49c_secnd      ;Send secondary address for LISTEN to IEC

    ldy #0                  ;Y is always 0 in lab_a647_data_loop below

    ;Send program address
    lda salptr              ;A = low byte of program start address
    jsr sub_a4d2_ciout      ;Send a byte to IEC
    lda salptr+1            ;A = high byte of program start address
    jsr sub_a4d2_ciout      ;Send a byte to IEC

;Send program data
lab_a647_data_loop:
    jsr sub_a672_cmp_sal_eal;Compare SALPTR with EALPTR, sets C=1 if equal
    bcs lab_a65b_done       ;Branch to done if end reach of range reached

    lda [salptr],y          ;A = get byte at SALPTR (Y is always 0)
    jsr sub_a4d2_ciout      ;Send a byte to IEC

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    beq lab_a65b_done       ;  Yes: branch to done

    ;STOP key not pressed

    jsr sub_a682_inc_salptr ;Increment SALPTR
    bne lab_a647_data_loop

lab_a65b_done:
    jsr sub_a4ef_unlsn      ;Send UNLISTEN to IEC
    ;Fall through

;Send CLOSE, UNLISTEN to IEC
sub_a65e_clsei:
    bit sa                  ;Test SA byte to check high nibble:
                            ;  11110000 0xF0 = OPEN
                            ;  11100000 0xE0 = CLOSE
                            ;  01100000 0x60 = SECOND
    bmi lab_a671_done       ;Branch to do nothing if it is OPEN or CLOSE

    ;SA byte high nibble is SECOND
    jsr sub_a3f2_listn      ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL current secondary address
    and #0b11101111         ;AND 0xEF so high nibble when OR'd becomes 0xE
    ora #iec_close          ;OR  0xE0 = CLOSE
    jsr sub_a49c_secnd      ;Send secondary address for LISTEN to IEC
    jsr sub_a4ef_unlsn      ;Send UNLISTEN to IEC

lab_a671_done:
    rts

;Compare SALPTR with EALPTR, sets C=1 if equal
sub_a672_cmp_sal_eal:
    lda salptr
    cmp ealptr
    bne lab_a680_noteq
    lda salptr+1
    cmp ealptr+1
    bne lab_a680_noteq
    sec
    rts

lab_a680_noteq:
    clc
    rts

;Increment SALPTR
;Used during !LOAD and !SAVE
sub_a682_inc_salptr:
    inc salptr
    bne lab_a688_nc
    inc salptr+1

lab_a688_nc:
    rts

;Send LISTEN, OPEN and filename to IEC
sub_a689_openi:
    lda sa                  ;A = KERNAL current secondary address
                            ;High nibble contains:
                            ;  11110000 0xF0 = OPEN
                            ;  11100000 0xE0 = CLOSE
                            ;  01100000 0x60 = SECOND
    bpl lab_a68f            ;Branch if high nibble of SA is SECOND

;Do nothing if high nibble is OPEN or CLOSE
lab_a68d_error:
    clc
    rts

lab_a68f:
    ldy fnlen
    beq lab_a68d_error      ;Branch to do nothing if filename is empty
    ;Filename is not empty
    lda #st_ok
    sta satus               ;KERNAL SATUS = 0 (no error)
    jsr sub_a3f2_listn      ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL current secondary address
    ora #iec_open           ;OR it with 0xF0 = OPEN
    jsr sub_a49c_secnd      ;Send secondary address for LISTEN to IEC
    lda satus               ;A = KERNAL SATUS
    bpl lab_a6a8_present    ;Branch if device not present error bit = 0
    ;device not present
    jmp nprsnt              ;KERNAL ?DEVICE NOT PRESENT ERROR

;device is present
lab_a6a8_present:
    ldy #0

lab_a6aa_loop:
    lda [fnadr],y           ;A = byte from filename
    jsr sub_a4d2_ciout      ;Send a byte to IEC
    iny
    cpy fnlen
    bne lab_a6aa_loop       ;Loop until entire filename is sent
    ;Filename has been sent
    jmp sub_a4ef_unlsn      ;Send UNLISTEN to IEC

;Wedge commands !LOAD and !VERIFY set VERCHK=0 for LOAD
;or VERCHK=0xFF for VERIFY then jump directly here
lab_a6b7_load_or_verify:
    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;Is the byte at txtptr+0 a semicolon?
    bne lab_a6c6_not_semi

    ;Byte at txtptr+0 is a semicolon
    sta tapwct              ;Store semicolon = do not update BASIC pointers on !LOAD
    jsr chrget              ;Consume the semicolon

lab_a6c6_not_semi:
    jsr sub_a6f6_search_load_verify ;Evaluate expression as filename, print SEARCHING if direct
                                    ;mode, then try to load or verify the file.  Prints the error
                                    ;message if something goes wrong.

    jsr is7802              ;KERNAL Compare TXTPTR+1: LDA 0x78; CMP #2; RTS
    bne lab_a6d1_not_0x02
    jsr sub_a83c_rd_cmd_ch  ;Read the IEC command channel and print it

lab_a6d1_not_0x02:
    bit verchk              ;Bit KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bmi lab_a6f5_done       ;Branch if to finish if perfoming VERIFY
                            ;  (BMI works because we actually set verchk to 0xFF)
    ;Peforming LOAD
    jsr stop                ;KERNAL test STOP key and act if pressed
    ldy #0xae               ;A = index to message "READY."
    jsr prmsg               ;KERNAL Print a message from 0xF000 table at offset Y
    jsr is7802              ;KERNAL Compare TXTPTR+1: LDA 0x78; CMP #2; RTS
    bne lab_a6e5_not_0x02
    jmp resbas              ;Jump out to BASIC restart execution to start, clear, and chain

lab_a6e5_not_0x02:
    jsr rsgetc              ;BASIC Reset GETCHR to start of program
    jsr restor              ;BASIC Perform RESTORE

    ldx #<tempst            ;X = Next available slot = first of three slots (stack is empty)
    stx temppt              ;Store as Next available slot in Descriptor Stack for Temp Strings
                            ;This location may contain:
                            ;  tempst+0 = 0x16 = first of three slots (stack is empty)
                            ;  tempst+3 = 0x19 = second of three slots
                            ;  tempst+6 = 0x1c = third of three slots
                            ;  tempst+9 = 0x1f = past third slot (stack is full)

    ;Set OLDTXT+1 and SUBFLG to 0, just like the BASIC routine FLOAD does
    lda #0                  ;A = 0
    sta oldtxt+1            ;Store in high byte of pointer to next BASIC statement for CONTINUE
                            ;  (Low byte does not need to be set because the BASIC routine CONT
                            ;   checks high byte and does ?CAN'T CONTINUE ERROR if it is zero.)
    sta subflg              ;Store in Subscript flag; FN flag

lab_a6f5_done:
    rts

;Evaluate expression as filename, print SEARCHING if direct mode,
;then try to load or verify the file.  Prints the error message
;if something goes wrong.
sub_a6f6_search_load_verify:
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    ldy fnlen
    bne lab_a6ff_fnlen_ok   ;Branch if filename is not empty
    ;Filename is empty
    clc                     ;XXX seems to never be used
    rts

lab_a6ff_fnlen_ok:
    jsr srchng              ;KERNAL Print SEARCHING if in direct mode
    lda #iec_second | iec_sa_load ;A = 0x60 (SECOND) | secondary address 0 (LOAD)
    sta sa                  ;Set SA (KERNAL current secondary address)
    jsr sub_a689_openi      ;Send LISTEN, OPEN and filename to IEC
    jsr sub_a3ef_talk       ;Send TALK to IEC
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr              ;Store program's start address low (or the CR) in pointer low

    lda satus               ;A = SATUS
    lsr a                   ;Bit 1 (timeout error) -> Bit 0
    lsr a                   ;Bit 0 -> C
    bcc lab_a71f_no_tmo     ;Branch if C is clear, meaning no timeout occurred

    jmp notfnd              ;KERNAL ?FILE NOT FOUND ERROR

lab_a71f_no_tmo:
    jsr lodmsg              ;KERNAL Print LOADING or VERIFYING if in direct mode

    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr+1            ;Store program's start address high (or the CR) in pointer high

    ;SALPTR now contains the start address in the file

    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a73e_not_comma  ;Branch to keep SALPTR if comma in command for start address

    ;Found a comma; parse start address from command
    jsr chrget              ;Consume the comma
    jsr sub_a861_parse_addr ;Parse a 4-digit hex address from BASIC text into ml1ptr

    ;Copy ml1ptr (start address from command) into salptr
    lda ml1ptr
    sta salptr
    lda ml1ptr+1
    sta salptr+1

    lda #';
    sta tapwct              ;Store semicolon = Do not update BASIC pointers on !LOAD

lab_a73e_not_comma:
    lda tapwct              ;A = TAPWCT ("," = update BASIC pointers on !LOAD, ";" = do not)
    cmp #',
    bne lab_a750_read_loop  ;Branch if BASIC pointers should not be updated
    ;BASIC pointers should be updated

    lda verchk              ;A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a750_read_loop  ;Branch if performing VERIFY
    ;Performing a LOAD

    ;Update BASIC's TXTPTR for LOAD
    lda salptr
    sta txttab
    lda salptr+1
    sta txttab+1

lab_a750_read_loop:
    lda #~st_timeout        ;A = mask off SATUS bit 1 (timeout error)
    and satus
    sta satus               ;Store SATUS with timeout error cleared

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a75e_no_stop    ;  No: branch to keep going

    ;STOP key pressed
    jmp sub_a65e_clsei      ;Jump out to Send CLOSE, UNLISTEN to IEC

;STOP key not pressed
lab_a75e_no_stop:
    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).

    tax                     ;X = byte received from IEC
    lda satus               ;A = SATUS
    lsr a                   ;Bit 1 (timeout error) -> Bit 0
    lsr a                   ;Bit 0 -> C
    bcs lab_a750_read_loop  ;Branch if C is set, meaning a timeout occurred
    txa                     ;A = byte received from IEC

    ldy verchk              ;Y = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    beq lab_a794_sta_byte   ;Branch if performing LOAD

    ;Performing VERIFY
    ldy #0
    cmp [salptr],y          ;Compare byte received with byte to verify
    beq lab_a796_next_byte  ;Branch if bytes are equal

    ;VERIFY failed
    lda #st_verify          ;A = SATUS bit for VERIFY error
    jsr sub_a580_udst       ;KERNAL SATUS = SATUS | A
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jsr sub_a65e_clsei      ;Send CLOSE, UNLISTEN to IEC

    jsr prtcr               ;BASIC Print carriage return

    ;Print the address of the verify error as 4 hex digits
    lda salptr
    sta ml1ptr
    lda salptr+1
    sta ml1ptr+1
    jsr wroa                ;MONITOR Print word at (ml1ptr) as 4 hex digits
    jsr pr2spc              ;BASIC Print two spaces

    ldy #0x6e               ;Y = 0x6E (?VERIFY ERROR)
    jmp krnerr              ;KERNAL ?<message> ERROR from KERNAL error in Y

lab_a794_sta_byte:
    sta [salptr],y          ;Store the byte received in memory

lab_a796_next_byte:
    jsr sub_a682_inc_salptr ;Increment SALPTR
    bit satus
    bvc lab_a750_read_loop  ;Branch if EOF not yet reached

    ;EOF reached
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jsr sub_a65e_clsei      ;Send CLOSE, UNLISTEN to IEC

    lda tapwct              ;TAPWCT ("," = update BASIC pointers on !LOAD, ";" = do not)
    cmp #',
    bne lab_a7b5_done       ;Branch if BASIC pointers should not be updated
    ;BASIC pointers should be updated

    lda verchk              ;A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a7b5_done       ;Branch if performing VERIFY
    ;Performing a LOAD

    ;Update BASIC's VARTAB for LOAD
    lda salptr
    sta vartab
    lda salptr+1
    sta vartab+1

lab_a7b5_done:
    rts

;Evaluate expression as filename; set up FNLEN and FNADR
sub_a7b6_eval_fname:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temp string, returns A=length, XY=pointer to str
    sta fnlen

    lda index
    sta fnadr
    lda index+1
    sta fnadr+1
    rts

;Wedge command !CATALOG
;
;  !CATALOG             List directory without filename; equivalent to CATALOG"$"
;
;  !CATALOG"filename"   List directory with filename
;
lab_a7c7_wedge_catalog:
    jsr sub_a390_setup      ;Set up VIA, set TAPWCT=",", R2D2=0x80, FA=IEC device, SATUS=0
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a7d5_no_fname   ;No filename, so branch to set the default of "$"

    ;A filename was given; evaluate it
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    jmp lab_a7e1_fname      ;Jump to perform !CATALOG with the set filename

;No filename given for !CATALOG so set the filename to "$"
lab_a7d5_no_fname:
    lda #<mem_a83a_dollr
    sta fnadr
    lda #>mem_a83a_dollr
    sta fnadr+1
    lda #mem_a83a_dollr_len
    sta fnlen
    ;Fall through

;Perform !CATALOG with the set filename
lab_a7e1_fname:
    lda #iec_second | iec_sa_load ;A = 0x60 (SECOND) | secondary address 0 (LOAD)
    sta sa                  ;Set SA (KERNAL current secondary address)
    jsr sub_a689_openi      ;Send LISTEN, OPEN and filename to IEC
    jsr sub_a3ef_talk       ;Send TALK to IEC
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

    lda #st_ok
    sta satus               ;KERNAL SATUS = 0 (no error)

    ;salptr is not used as a pointer below, rather as two temporary locations:
    ;  salptr:   counts down bytes (used with Y register)
    ;  salptr+1: low byte received from IEC

    ldy #3                  ;Countdown = 3, meaning 6 bytes will be read:
                            ;  Program start address low, high
                            ;  Next BASIC line address low, high
                            ;  Current BASIC line number low, high

;Read and print BASIC line number (block size of program)
lab_a7f4_line_loop:
    sty salptr              ;Store Y in byte countdown

    ;Receive low byte from IEC, store in salptr+1
    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr+1            ;Store low byte received from IEC (or the CR)
    ldy satus
    bne lab_a831_error      ;Branch if SATUS != 0

    ;Receive high byte from IEC, leave it in A
    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    ldy satus
    bne lab_a831_error      ;Branch if SATUS != 0

    ;Loop until line number has been read
    ldy salptr              ;Y = byte countdown
    dey                     ;Decrement countdown
    bne lab_a7f4_line_loop  ;Keep going until line number has been read

    ;Print line number (block size of progam)
                            ;A still contains the high byte received from IEC
    ldx salptr+1            ;X = low byte received from IEC
    jsr linprt              ;BASIC Print 256*A + X in decimal

    ;Print space after line number
    lda #space              ;A = SPACE character
    jsr chrout              ;KERNAL Send a char to the current output device

;Read and print BASIC line contents (program filename and type)
lab_a815_fname_loop:
    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    ldx satus
    bne lab_a831_error      ;Branch if SATUS != 0

    tax                     ;X = A (byte received), just to set Z flag
    beq lab_a825_eol        ;Branch if byte received = 0, meaning end of BASIC line

    ;Print byte in BASIC line
    jsr chrout              ;KERNAL Send a char to the current output device
    jmp lab_a815_fname_loop

;End of current BASIC line reached
lab_a825_eol:
    ;Print carriage return after line
    lda #cr                 ;A = carriage return
    jsr chrout              ;KERNAL Send a char to the current output device

    ldy #2                  ;Countdown = 2, meaning 4 bytes will be read:
                            ;  Next BASIC line address low, high
                            ;  Current BASIC line number low, high

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a7f4_line_loop  ;  Branch to get next line if not pressed

    ;STOP key pressed

lab_a831_error:
    jmp sub_a65e_clsei      ;Jump out to Send CLOSE, UNLISTEN to IEC

;Command to change the drive's device number
mem_a834_m_w:
    .ascii "M-W"            ;CBM DOS Memory-Write command
    .word 0x0077            ;Start address = 0x0077 in drive RAM
    .byte 2                 ;Number of data bytes to write = 2
    .ascii "$"              ;0x0077: IEC bus LISTEN command to accept. (Device number OR $20)
    .byte 0                 ;0x0078: IEC bus TALK command to accept. (Device number OR $40)
mem_a834_m_w_len = ( . - mem_a834_m_w)  ;Length of "M-W" command above

;Dollar sign used with CATALOG command (one byte from above is reused for this)
mem_a83a_dollr = ( . - 2)
mem_a83a_dollr_len = 1

;Read the IEC command channel and print it
;Prints like: "00, OK,00,00"
sub_a83c_rd_cmd_ch:
    jsr sub_a65e_clsei      ;Send CLOSE, UNLISTEN to IEC
    jsr sub_a3ad_set_fa_st  ;Set FA = IEC device for in-progress command, set SATUS = 0
    jsr sub_a3ef_talk       ;Send TALK to IEC
    lda #iec_second | iec_sa_cmd ;A = 0x60 (SECOND) | 0x0F (Command Channel)
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

lab_a84a_more:
    jsr sub_a507_acptrs     ;If SATUS=0 then read a byte from IEC, else return a CR (0x0D).
    jsr chrout              ;KERNAL Send a char to the current output device
    cmp #cr                 ;Is the character a carriage return?
    bne lab_a84a_more       ;  No: loop for another character
    ;Carriage return; end of input
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jmp sub_a65e_clsei      ;Send CLOSE, UNLISTEN to IEC

;Compare byte at txtptr with a comma
sub_a85a_cmp_comma:
    ldy #0
    lda [txtptr],y
    cmp #',
    rts

;Parse a 4-digit hex address from BASIC text into ml1ptr
;Evals expression, calls hexit 4 times, sets ml1ptr
;Called only from !LOAD, !SAVE, or !VERIFY
sub_a861_parse_addr:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temp string, returns A=length, XY=pointer to str
    cmp #4                  ;Is it exactly 4 characters?
    bne lab_a88c_snerr      ;  No: jump to ?SYNTAX ERROR
    ldy #0xff               ;Y=FF so it rolls to 0 on first call
    ;high byte, high nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [index],Y (0)
    jsr sub_a88f_lo_nib_hi  ;Rotate low nib into high nib, low nib = 0
    sta ml1ptr+1            ;Store as pointer high byte
    ;high byte, low nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [index],Y (1)
    ora ml1ptr+1            ;OR it with pointer high byte to add the high nibble
    sta ml1ptr+1            ;Store as pointer high byte
    ;low byte, high nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [index],Y (2)
    jsr sub_a88f_lo_nib_hi  ;Rotate low nib into high nib, low nib = 0
    sta ml1ptr              ;Store as pointer low byte
    ;low byte, low nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [index],Y (3)
    ora ml1ptr              ;OR it pointer low byte to add the high nibble
    sta ml1ptr              ;Store as pointer low byte
    rts

lab_a88c_snerr:
    jmp snerr               ;?SYNTAX ERROR

;Rotate low nib into high nib, low nib = 0
sub_a88f_lo_nib_hi:
    asl a
    asl a
    asl a
    asl a
    rts

;INCY then hexit value at [index],Y
sub_a894_hexit:
    iny
    lda [index],y
    jmp hexit               ;MONITOR Evaluate char in A to a hex nibble

;STOP key pressed?  Returns Z=1 if so.
sub_a89a_chk_stop:
    lda pia1_portb
    cmp #0b11101111         ;STOP is row 9, col 4 on both bus and gfx keyboards
    rts

;Is the KERNAL's current device number (FA) the current IEC device?
;Returns Z=1 if so.
sub_a8a0_is_fa_iec:
    lda cur_iec_dev         ;A = Current IEC device number for in-progress wedge command
    and #0b01111111         ;Mask off bit 7 auto-linefeed flag
    cmp fa                  ;Compare to KERNAL current device number
    rts

;Parse #integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
sub_a8a8_parse_sa_1:
    lda #'#                 ;A = leading '#' expected before integer
    jsr synchr              ;BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A
    ;Fall through

;Parse integer or ?SYNTAX ERROR, set FA=IEC, SA=integer|SECOND, SATUS=0
sub_a8ad_parse_sa_2:
    jsr sub_a3ad_set_fa_st  ;Set FA = IEC device for in-progress command, set SATUS = 0
    jsr gtbytc+3            ;BASIC Evaluate integer 0-255, return it in X
    txa                     ;A = secondary address
    ora #iec_second         ;OR secondary address with 0x60 (SECOND)
    sta sa                  ;Set SA (KERNAL current secondary address)
    rts
