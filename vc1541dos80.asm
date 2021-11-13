;VC-1541-DOS/80
;Reverse-engineered source code

    schchr = 0x03           ;Search character
    qteflg = 0x04           ;Scan-between-quotes flag
    valtyp = 0x07           ;Data type of value: 0=numeric, 0xff=string
    intflag = 0x08          ;Type of number: 0=floating point, 0x80=integer
    subflg = 0x0a           ;Subscript flag; FNX flag
    readop = 0x0b           ;Read operation: 0=INPUT, 0x40=GET, 0x98=READ
    mem_0010 = 0x10
    mem_0013 = 0x13
    utlptr = 0x1f           ;Pointer: Utility (various uses)
    txttab = 0x28           ;Pointer: Start of BASIC text
    vartab = 0x2a           ;Pointer: Start of BASIC variables
    mem_003b = 0x3b
    inpptr = 0x40           ;Pointer: INPUT, READ, and GET vector to save CHRGET
    forptr = 0x46           ;Pointer: Index Variable for FOR/NEXT
    tmpptr = 0x48           ;Pointer: Various temporary storage uses
    facexp = 0x5e           ;Floating-Point Accumulator #1: Exponent
    chrget = 0x70           ;Subroutine: Get Next Byte of BASIC Text (patched)
    chrgot = 0x76           ;Subroutine: Get the Same Byte of BASIC Text again
    txtptr = 0x77           ;Pointer: Current Byte of BASIC Text
    status = 0x96           ;KERNAL Status byte for I/O operations
    verchk = 0x9d           ;KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    mem_00a0_c3p0 = 0xa0
    bsour = 0xa5            ;IEEE byte buffer for output (FF means no character)
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
    mem_00fd_r2d2 = 0xfd
    mem_00fe_bsour1 = 0xfe
    mem_00ff_count = 0xff
    stkbot = 0x100          ;Lowest address of the stack page
    inpbuf = 0x200          ;Buffer used by INPUT, also MONITOR work area (0x200-0x250)
    dosbuf = 0x353          ;DOS command string buffer (0x353-0x380)
    mem_03fe = 0x3fe        ;Current device number on IEC bus (default 8)
    mem_03ff = 0x3ff        ;Copy of current IEC device number
    mem_87d0_torl = 0x87d0  ;Stores TALK or LISTEN state: 0x40=TALK, 0x20=LISTEN

    rsgetc = 0xb622         ;BASIC Reset GETCHR to start of program
    error = 0xb3cf          ;BASIC Print error message offset by X in msgs table and return to prompt
    resbas = 0xb4ad         ;BASIC Reset execution to start, clear, and chain
    sub_b965 = 0xb965
    prstr = 0xbb1d          ;BASIC Print null-terminated string at A=addr low, Y=addr hi
    defdev = 0xbb44         ;BASIC Restore default devices
    restor = 0xb7b7         ;BASIC Perform RESTORE
    frmevl = 0xbd98         ;BASIC Input and evaluate any expression
    syntax = 0xbf00         ;BASIC ?SYNTAX ERROR
    sub_b94d = 0xb94d
    doagin = 0xbb4c         ;BASIC Print error message for GET, INPUT, or READ
    extra = 0xbcda          ;BASIC ?EXTRA IGNORED if INPPTR is not at end of buffer
    iscoma = 0xbef5         ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    isaequ = 0xbef7         ;BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A
    lab_bf24 = 0xbf24
    lab_b8c2 = 0xb8c2
    ptrget = 0xc12b         ;BASIC Find a variable; sets valtyp and varpnt
    strmem = 0xc5b0         ;BASIC Set up string in memory
    list = 0xc5b5           ;BASIC Perform LIST; full check of parameters, including "-"
    frestr = 0xc7b5         ;BASIC Discard temporary string
    gtbytc = 0xc8d1         ;BASIC Evaluate an expr for 1-byte param (0-255), return in X
    wtxtptr = 0xc918        ;BASIC Copy FBUFPT (0x006E) to TXTPTR (0x0077)
    fin = 0xce29            ;BASIC Convert an ASCII string into a numeral in FPAcc #1
    linprt = 0xcf83         ;BASIC Print 256*A + X in decimal
    ntostr = 0xcf93         ;BASIC Convert number to string
    pr2spc = 0xd52e         ;BASIC Print two spaces
    prtcr = 0xd534          ;BASIC Print carriage return
    wroa = 0xd717           ;MONITOR Print word at (ml1ptr) as 4 hex digits
    hexit = 0xd78d          ;MONITOR Evaluate char in A to a hex nibble
    dprscr = 0xe787         ;EDITOR Default routine for PRSCR vector

    pia1_portb = 0xe812     ;PIA 1 Port B
    via_portb = 0xe840      ;VIA Port B
    via_porta = 0xe841      ;VIA Port A
    via_ddrb = 0xe843       ;VIA DDR B
    via_timer_2_lo = 0xe848 ;VIA Timer 2 Low
    via_timer_2_hi = 0xe849 ;VIA Timer 2 High
    via_acr = 0xe84b        ;VIA ACR
    via_ifr = 0xe84d        ;VIA IFR

    talk = 0xf0d2           ;KERNAL Send TALK to IEEE
    listen = 0xf0d5         ;KERNAL Send LISTEN to IEEE
    sndcmd = 0xf0d7         ;KERNAL Send a command byte to IEEE
    isour = 0xf109          ;KERNAL Send last byte to IEEE
    second = 0xf143         ;KERNAL Send Secondary Address to IEEE
    scatn = 0xf148          ;KERNAL Release ATN on IEEE
    ciout = 0xf19e          ;KERNAL Send a byte to IEEE
    untlk = 0xf1ae          ;KERNAL Send UNTALK to IEEE
    unlsn = 0xf1b9          ;KERNAL Send UNLISTEN to IEEE
    acptr = 0xf1c0          ;KERNAL Read a byte from IEEE
    lodmsg = 0xf46d         ;KERNAL Print LOADING or VERIFYING if in direct mode
    notfnd = 0xf5ad         ;KERNAL ?FILE NOT FOUND ERROR
    prmsg = 0xf349          ;KERNAL Print a message from 0xF000 table at offset Y
    is7802 = 0xf351         ;KERNAL Compare TXTPTR+1: LDA 0x78; CMP #2; RTS
    srchng = 0xf449         ;KERNAL Print SEARCHING if in direct mode
    open = 0xf4a5           ;KERNAL Send OPEN to IEEE
    nprsnt = 0xf4bb         ;KERNAL ?DEVICE NOT PRESENT ERROR
    krnerr = 0xf5b7         ;KERNAL ?<message> ERROR from KERNAL error in Y
    close = 0xf72f          ;KERNAL Send CLOSE to IEEE
    stop = 0xf92b           ;KERNAL Test STOP key and act if pressed
    chrout = 0xffd2         ;KERNAL Send a char to the current output device

    ;VC-1541-DOS/80 was originally for 0xA000 (socket UD11) but this source is relocatable.
    ;It also works at 0x9000 (socket UD12) if the origin address is changed.  The origin
    ;address can be changed in the Makefile.
    .area vc1541dos

    ;Entry points at the beginning of the ROM

    jmp sub_a036_install        ;a000   Install the wedge with CHRGET patch
    jmp sub_a09c_wedge_eval     ;a003   Evaluate and perform wedge command at txtptr+0
    jmp sub_a377_isour          ;a006   Send last byte to IEC or IEEE
    jmp sub_a382_sndcmd         ;a009   Send a command byte to IEC or IEEE
    jmp sub_a128_open           ;a00c   Send OPEN to IEC or IEEE
    jmp sub_a128_close          ;a00f   Send CLOSE to IEC or IEEE
    jmp sub_a141_acptrs         ;a012   Read a byte from IEC or IEEE
    jmp sub_a306_ciout          ;a015   Send a byte to IEC or IEEE
    jmp sub_a314_listen         ;a018   Send LISTEN to IEC or IEEE
    jmp sub_a32a_unlsn          ;a01b   Send UNLISTEN to IEC or IEEE
    jmp sub_a31f_talk           ;a01e   Send TALK to IEC or IEEE
    jmp sub_a335_untlk          ;a021   Send UNTALK to IEC or IEEE
    jmp sub_a345_second         ;a024   Send secondary address for LISTEN to IEC or IEC
    jmp sub_a353_tksa           ;a027   Send secondary address for TALK to IEC or IEEE
    jmp sub_a340_lstksa         ;a02a   Send secondary address for TALK or LISTEN to IEC or IEEE
    jmp sub_a361_atnon          ;a02d   Assert ATN on IEC or IEEE
    jmp sub_a36c_scatn          ;a030   Release ATN on IEC or IEEE
    jmp sub_a119_jmp_lstksa     ;a033   Jumps directly to sub_a340_lstksa

sub_a036_install:
    lda #0x4c               ;0x4C = JMP
    sta chrget
    lda #<lab_a061_wedge
    sta chrget+1
    lda #>lab_a061_wedge
    sta chrget+2            ;0070 4C 61 A0 JMP A061
    lda #0x08
    sta mem_03fe            ;Current unit number on IEC bus = 8
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
    lda #<banner
    ldy #>banner
    jmp prstr               ;BASIC Print null-terminated string at A=addr low, Y=addr hi

banner:
    .ascii "VC-1541-DOS/80"
    .byte 0x0d, 0x00

lab_a061_wedge:
    inc txtptr
    bne lab_a067_nc
    inc txtptr+1

lab_a067_nc:
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    php

    cmp #'!                 ;Is it the wedge character?
    bne lab_a090_not_exc    ;Branch if not

    ;Got the wedge character; now look at the return address
    ;on the stack to see if we should parse it

    stx tapend              ;Save X before we use it
    tsx
    lda stkbot+3,x          ;A = high byte of (return address - 1)

    cmp #>(lab_bf24-1)
    beq lab_a07d_bf_or_b8   ;Branch if high byte is 0xBF

    cmp #>(lab_b8c2-1)
    bne lab_a08c_ignore_exc ;Branch if high byte is not 0xB8

    ;High byte is 0xB8

;High byte of return address is 0xBF or 0xB8
lab_a07d_bf_or_b8:
    lda stkbot+2,x          ;A = low byte of (return address - 1)

    cmp #<(lab_bf24-1)
    beq lab_a092_parse_exc  ;Branch to parse if return address is 0xBF24

    cmp #<(lab_b8c2-1)
    bne lab_a08c_ignore_exc ;Branch to ignore if return address is not 0xB8C2

    ;Return address is 0xB8C2
    lda facexp
    bne lab_a092_parse_exc

;Character is a "!" but we are not parsing it
lab_a08c_ignore_exc:
    ldx tapend              ;Restore original X
    lda #'!                 ;Restore original A

;Character is not a "!"
lab_a090_not_exc:
    plp
    rts

;Character is a "!" and we are parsing it
lab_a092_parse_exc:
    plp
    jsr chrget
    lda mem_03fe            ;A = current device number on IEC bus
    sta mem_03ff            ;Save as copy of current IEC device number

sub_a09c_wedge_eval:
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    pha
    jsr chrget
    pla

    cmp #0x93               ;Is byte at txtptr+0 = 0x93 = LOAD token
    beq lab_a10f_wedge_load

    cmp #0x94               ;Is byte at txtptr+0 = 0x94 = SAVE token
    bne lab_a0af_not_save
    jmp lab_a5e5_wedge_save

lab_a0af_not_save:
    cmp #0x95               ;Is byte at txtptr+0 = 0x95 = VERIFY token
    beq lab_a112_wedge_verify

    cmp #0xd7               ;Is byte at txtptr+0 = 0xD7 = CATALOG token
    bne lab_a0ba_not_catalog
    jmp lab_a7c7_wedge_catalog

lab_a0ba_not_catalog:
    cmp #0x9f               ;Is byte at txtptr+0 = 0x9F = OPEN token
    bne lab_a0c1_not_open
    jmp lab_a11c_wedge_open

lab_a0c1_not_open:
    cmp #0x98               ;Is byte at txtptr+0 = 0x98 = PRINT# token
    bne lab_a0c8_not_print
    jmp lab_a175_wedge_print

lab_a0c8_not_print:
    cmp #0xa1               ;Is byte at txtptr+0 = 0xA1 = GET token
    bne lab_a0cf_not_get
    jmp lab_a1e0_wedge_get

lab_a0cf_not_get:
    cmp #0xa0               ;Is byte at txtptr+0 = 0xA0 = CLOSE token
    bne lab_a0d6_not_close
    jmp lab_a133_wedge_close

lab_a0d6_not_close:
    cmp #0x84               ;Is byte at txtptr+0 = 0x84 = INPUT# token
    bne lab_a0dd_not_input
    jmp lab_a226_wedge_input

lab_a0dd_not_input:
    cmp #0x9d               ;Is byte at txtptr+0 = 0x9D = CMD token
    bne lab_a0e4_not_cmd
    jmp lab_a14c_wedge_cmd

lab_a0e4_not_cmd:
    cmp #'Q                 ;Is byte at txtptr+0 = Q char?
    bne lab_a0f5_not_quit

    ;Wedge command is !Q (Quit)
    ;Restore normal CHRGET processing
    lda #0xe6               ;0xE6 = INC
    sta chrget
    lda #<txtptr
    sta chrget+1            ;0070 E6 77 INC 77
    lda #0xD0               ;0xD0 = BNE
    sta chrget+2            ;0072 D0 xx BNE ...
    rts

lab_a0f5_not_quit:
    cmp #'@                 ;Is byte at txtptr+0 = @ char?
    bne lab_a0fc_not_dos
    jmp lab_a586_wedge_dos

lab_a0fc_not_dos:
    ;None of the commands matched, so we assume that a device number
    ;follows the "!", such as in these examples:
    ;  !9@                Change to device 9 and then read command channel
    ;  !9LOAD"FILENAME"   Change to device 9 and then load program

    ;Decrement TXTPTR so GETBYTC can parse the number
    dec txtptr
    lda txtptr
    cmp #0xff
    bne lab_a106_devnum
    dec txtptr+1

lab_a106_devnum:
    ;Parse device number after the "!"
    jsr gtbytc+3            ;BASIC Evaluate integer 0-255, return it in X
    stx mem_03ff            ;Save as copy of current IEC device number

    ;Loop to parse a wedge command after the device number.  A wedge command
    ;must follow the device number of a ?SYNTAX ERROR will result.
    jmp sub_a09c_wedge_eval

;Wedge command !LOAD
;
;  !LOAD"FILENAME"        Load into BASIC program area (TXTTAB)
;
;  !LOAD"FILENAME",027A   Load at start address specified as 4 hex digits.
;                         All four digits are required.  An end address is not supported.
;
lab_a10f_wedge_load:
    lda #0                  ;A = 0 (LOAD)
    .byte 0x2c              ;Skip next 2 bytes

;Wedge command !VERIFY
;
;  !VERIFY"FILENAME"        Verify against BASIC program area (TXTTAB)
;
;  !VERIFY"FILENAME",027A   Verify against start address specified as 4 hex digits.
;                           All four digits are required.  An end address is not supported.
;
lab_a112_wedge_verify:
    lda #0xff              ;A = 0xFF (VERIFY) for VERCHK.  It's normally 0 or 1 but we set
                           ;it to 0xFF so we can test for verify with "bmi verchk" later.
    sta verchk             ;Store in KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    jmp lab_a6b7_load_or_verify

;Jump to Send secondary address for TALK or LISTEN to IEC or IEEE
sub_a119_jmp_lstksa:
    jmp sub_a340_lstksa     ;Send secondary address for TALK or LISTEN to IEC or IEEE

;Wedge command !OPEN
;
;Open a channel to the current IEC device on the given secondary address.
;
;  OPEN#2,"FILENAME"     Open a file with secondary address 2.  The comma and the quotes
;                        are required.  The filename can not be empty.
;
lab_a11c_wedge_open:
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
    jsr sub_a8a8_parse_sa_1 ;Parse int into SA with leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    jsr iscoma              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    ;Fall through

    ;Note: Since sub_a689_open does nothing if the filename is zero length,
    ;it's not possible to !OPEN a channel without a filename.

;Send OPEN to IEC or IEEE
sub_a128_open:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a130_not_iec
    jmp sub_a689_open       ;Send OPEN to IEC

lab_a130_not_iec:
    jmp open                ;Send OPEN to IEEE


;Wedge command !CLOSE
;
;Close a channel on the current IEC device with the given secondary address.
;
;  !CLOSE#2   Close channel with secondary address 2
;
lab_a133_wedge_close:
    jsr sub_a8a8_parse_sa_1 ;Parse int into SA with leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    ;Fall through


;Send CLOSE to IEC or IEEE
sub_a128_close:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a13e_not_iec
    jmp sub_a65e_close      ;Send CLOSE to IEC

lab_a13e_not_iec:
    jmp close               ;Send CLOSE to IEEE


;Read a byte from IEC or IEEE
;
;Note: On IEC, this is not a normal ACPTR (sub_a50e_acptr).  It instead calls sub_a507_acptrs,
;      which first checks STATUS and does nothing if it is nonzero.  On IEEE-488, the normal
;      ACPTR routine in the KERNAL is called, which does not have this behavior.
;
sub_a141_acptrs:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a149_not_iec
    jmp sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).

lab_a149_not_iec:
    jmp acptr               ;Read a byte from IEEE


;Wedge command !CMD
;
;Redirect output to the current IEC device on the given secondary address.
;
;  !CMD#2   Redirect output to secondary address 2 on device FA.
;
lab_a14c_wedge_cmd:
    jsr sub_a8a8_parse_sa_1 ;Parse int into SA with leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    lda #<lab_a15f_prscr
    sta prscr
    lda #>lab_a15f_prscr
    sta prscr+1
    jsr sub_a314_listen     ;Send LISTEN to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jmp sub_a340_lstksa     ;Send secondary address for TALK or LISTEN to IEC or IEEE


;Routine installed in prscr vector
lab_a15f_prscr:
    lda datax               ;A = Current character to print
    cmp #0x0d               ;Is it a carriage return?
    bne lab_a16f_not_cr
    ;It's a carriage return
    bit mem_03ff            ;Bit with copy of current IEC device number
    bpl lab_a16f_not_cr
    jsr sub_a306_ciout      ;Send a byte to IEC or IEEE
    lda #0x0a

lab_a16f_not_cr:
    jsr sub_a306_ciout      ;Send a byte to IEC or IEEE
    jmp dprscr              ;EDITOR Default routine for PRSCR vector


;Wedge command !PRINT#
;
;Print to an already-open channel on the given secondary address
;on the current IEC device.
;
;  !PRINT#2           Print a blank line to secondary address 2 (sends CRLF).
;
;  !PRINT#2,"TEST"    Print an expression followed by a CRLF to secondary address 2.
;                     Multiple expressions can be combined with ";" such as
;                     PRINT#2,"TEST";X;A$.  Unlike CBM BASIC, expressions cannot
;                     be combined with a comma.  If a trailing ";" is given, do
;                     not send the CRLF at the end.
;
lab_a175_wedge_print:
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

    jsr sub_a32a_unlsn      ;Send UNLISTEN to IEC or IEEE
    ;Fall through

;We're not in !CMD# mode.  Now do the !PRINT#.
lab_a18c_not_in_cmd:
    jsr sub_a8ad_parse_sa_2 ;Parse int into SA without leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    jsr sub_a314_listen     ;Send LISTEN to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;Send secondary address for TALK or LISTEN to IEC or IEEE
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a1ce_send_crlf  ;Branch if not a comma to send CRLF, UNLISTEN, and return

    ;Byte at txtptr+0 is a comma
    jsr chrget              ;Consume the comma

;Parse BASIC expression and send its value to IEC
lab_a19f_expr_loop:
    jsr frmevl              ;BASIC Input and evaluate any expression
    bit valtyp              ;Test type of value (0=numeric, 0xff=string)
    bmi lab_a1ac_str        ;Branch if value is a string

    ;Value is not a string, so convert it
    jsr ntostr              ;BASIC Convert number to string
    jsr strmem              ;BASIC Set up string in memory

;Value is a string
lab_a1ac_str:
    jsr frestr              ;BASIC Discard temporary string
    sta fnlen               ;FNLEN = length of string

    ;Send the string to IEC
    ldy #0x00               ;Y = 0 (string offset)

lab_a1b3_str_loop:
    cpy fnlen               ;Compare Y to length of string
    beq lab_a1bf_eos        ;Branch if end of string reached

    lda [utlptr],y          ;A = byte from string
    jsr sub_a306_ciout      ;Send a byte to IEC or IEEE
    iny                     ;Increment string offset
    bne lab_a1b3_str_loop   ;Branch if potentially more string to send

;End of string reached
lab_a1bf_eos:
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;Is byte at txtptr+0 a semicolon?
    bne lab_a1ce_send_crlf  ;Branch if not a semicolon to send CRLF, UNLISTEN, and return

    ;Got a semicolon, so do not send a CRLF at the end
    jsr chrget              ;Consume semicolon
    beq lab_a1dd_done       ;Branch if end of BASIC statement reached

    ;Got more stuff after the semicolon
    jmp lab_a19f_expr_loop ;Branch to parse BASIC after delimiter (comma or semicolon)

;Byte at txtptr+0 is not a delimiter (semicolon or comma)
lab_a1ce_send_crlf:
    lda #0x0d               ;A = carriage return
    jsr sub_a306_ciout      ;Send a byte to IEC or IEEE

    bit mem_03ff            ;Bit with copy of current IEC device number
    bpl lab_a1dd_done

    lda #0x0a               ;A = newline
    jsr sub_a306_ciout      ;Send a byte to IEC or IEEE

lab_a1dd_done:
    jmp sub_a32a_unlsn      ;Send UNLISTEN to IEC or IEEE

;Wedge command !GET#
;
lab_a1e0_wedge_get:
    jsr sub_a8a8_parse_sa_1 ;Parse int into SA with leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    jsr iscoma              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    lda mem_03ff            ;A = copy of current IEC device number
    and #0x7f
    sta mem_0010
    jsr sub_a31f_talk       ;Send TALK to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;Send secondary address for TALK or LISTEN to IEC or IEEE
    ldx #<(inpbuf+1)        ;XY = pointer to inpbuf+1
    ldy #>(inpbuf+1)
    lda #0x00               ;A = NULL (0x00) character
    sta inpbuf+1            ;Store in INPUT buffer (0x200-0x250)
    lda #0x40               ;A=0x40 (Read operation: GET)
    jmp lab_a245_get_or_input

;Read a CR-terminated string from IEC into INPBUF, set XY = INPBUF-1
;-1 because callers copy XY to TXTPTR and call CHRGET or PTRGET, which increment TXTPTR first
;The CR (0x0D) is replaced with NULL (0x00).
;Jumps to ?STRING TO LONG ERROR if string did not fit
sub_a203_read_str:
    ldx #0x00

lab_a205_loop:
    jsr sub_a141_acptrs     ;Read a byte from IEC or IEEE.  On IEC only, check STATUS first:
                            ;  If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    cmp #0x0d
    beq lab_a21c_cr         ;Branch if a carriage return was received or if an error occurred

    sta inpbuf,x            ;Store in INPUT buffer (0x200-0x250)
    inx
    cpx #0x51
    bne lab_a205_loop       ;Branch to get another byte if still within buffer size

    ;Next byte would exceed INPBUF buffer size
    jsr sub_a335_untlk      ;Send UNTALK to IEC or IEEE
    ldx #0xb0               ;X = 0xB0 (?STRING TOO LONG ERROR)
    jmp error               ;BASIC Print error message offset by X in msgs table and return to prompt

lab_a21c_cr:
    lda #0x00               ;A = NULL (0x00) to replace CR in buffer
    sta inpbuf,x            ;Store NULL in INPUT buffer (0x200-0x250)
    ldx #<(inpbuf-1)        ;XY = Pointer to inpbuf-1
    ldy #>(inpbuf-1)
    rts

;Wedge command !INPUT
;
lab_a226_wedge_input:
    jsr sub_a8ad_parse_sa_2 ;Parse int into SA without leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
    jsr iscoma              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a31f_talk       ;Send TALK to IEC or IEEE
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;Send secondary address for TALK or LISTEN to IEC or IEEE
    lda mem_03ff            ;A = copy of current IEC device number
    and #0x7f
    sta mem_0010
    lda #',                 ;Add a comma before INPUT buffer so every chunk start with a comma.
    sta inpbuf-1            ;See "Programming the PET/CBM" page 79 "How INPUT and INPUT# Work"
    jsr sub_a203_read_str   ;Read a CR-terminated string from IEC into inpbuf, set XY = inpbuf-1
    lda #0x00               ;A=0 (Read operation: 0=INPUT)

lab_a245_get_or_input:
    sta readop              ;Store 0 or 0x40 as Read operation: 0=INPUT, 0x40=GET, 0x98=READ
    ;Copy pointer returned from sub_a203_read_str into INPPTR
    stx inpptr              ;INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1

lab_a24b_input_loop:
    jsr ptrget              ;BASIC Find a variable; sets valtyp and varpnt
    sta forptr              ;Pointer: Index Variable for FOR/NEXT
    sty forptr+1

    lda txtptr
    ldy txtptr+1
    sta tmpptr              ;Pointer: Various temporary storage uses
    sty tmpptr+1

    ldx inpptr              ;INPUT, READ, and GET vector to save CHRGET
    ldy inpptr+1
    stx txtptr
    sty txtptr+1

    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    bne lab_a285            ;Branch if not end of BASIC statement

    ;End of BASIC statement
    bit readop              ;Read operation: 0=INPUT, 0x40=GET, 0x98=READ (will be 0 or 0x40 only)
    bvc lab_a277_input      ;Branch is read operation is INPUT

    ;Read operation is GET
    jsr sub_a141_acptrs     ;Read a byte from IEC or IEEE.  On IEC only, check STATUS first:
                            ;  If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta inpbuf              ;Store in input buffer used by MONITOR (0x200-0x250)
    ldx #<(inpbuf-1)        ;XY = pointer to inpbuf-1
    ldy #>(inpbuf-1)        ;     (-1 because CHRGET increments first)
    bne lab_a281            ;Branch always

lab_a277_input:
    lda mem_0010
    bne lab_a27e

    jsr defdev              ;BASIC Restore default devices

lab_a27e:
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
    bit readop              ;Read operation: 0=INPUT, 0x40=GET, 0x98=READ (will be 0 or 0x40 only)
    bvc lab_a299_input      ;Branch if read operation is INPUT

    ;Read operation is GET
    inx
    stx txtptr
    lda #0x00
    sta schchr
    beq lab_a2a5            ;Branch always

lab_a299_input:
    sta schchr
    cmp #'"
    beq lab_a2a6
    lda #':
    sta schchr
    lda #',

lab_a2a5:
    clc

lab_a2a6:
    sta qteflg              ;Scan-between-quotes flag
    lda txtptr
    ldy txtptr+1
    adc #0x00
    bcc lab_a2b1_nc
    iny

lab_a2b1_nc:
    jsr list+1              ;Call into BASIC Perform LIST mid-instruction
    jsr wtxtptr             ;BASIC Copy FBUFPT (0x006E) to TXTPTR (0x0077)
    jsr sub_b965
    jmp lab_a2c5

lab_a2bd_numeric:
    jsr fin                 ;BASIC Convert an ASCII string into a numeral in FPAcc #1
    lda intflag
    jsr sub_b94d

lab_a2c5:
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2d1_null_comma ;Branch if null
    cmp #',
    beq lab_a2d1_null_comma ;Branch if comma

    ;Not a null or a comma
    jmp doagin              ;BASIC Print error message for GET, INPUT, or READ

lab_a2d1_null_comma:
    lda txtptr
    ldy txtptr+1
    sta inpptr              ;INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1
    lda tmpptr              ;Pointer: Various temporary storage uses
    ldy tmpptr+1
    sta txtptr
    sty txtptr+1
    jsr chrgot              ;Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2ec
    jsr iscoma              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jmp lab_a24b_input_loop

lab_a2ec:
    jsr extra               ;BASIC ?EXTRA IGNORED if INPPTR is not at end of buffer
    jsr sub_a335_untlk      ;Send UNTALK to IEC or IEEE
    lda #0x00
    sta mem_0010
    rts

copyright:
    .ascii "(C) G MUTZ (84)"


;Send a byte to IEC or IEEE
sub_a306_ciout:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a310_not_iec
    pla
    jmp sub_a4d2_ciout      ;Send a byte to IEC

lab_a310_not_iec:
    pla
    jmp ciout               ;Send a byte to IEEE


;Send LISTEN to IEC or IEEE
sub_a314_listen:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a31c_not_iec
    jmp sub_a3f2_listen     ;Send LISTEN to IEC

lab_a31c_not_iec:
    jmp listen              ;KERNAL Send LISTEN to IEEE


sub_a31f_talk:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a327_not_iec
    jmp sub_a3ef_talk       ;Send TALK to IEC

lab_a327_not_iec:
    jmp talk                ;KERNAL Send TALK to IEEE


;Send UNLISTEN to IEC or IEEE
sub_a32a_unlsn:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a332_not_iec
    jmp sub_a4ef_unlsn      ;Send UNLISTEN to IEC

lab_a332_not_iec:
    jmp unlsn               ;KERNAL Send UNLISTEN to IEEE


;Send UNTALK to IEC or IEEE
sub_a335_untlk:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a33d_not_iec
    jmp sub_a4e4_untlk      ;Send UNTALK to IEC

lab_a33d_not_iec:
    jmp untlk               ;KERNAL Send UNTALK to IEEE


;Send secondary address for TALK or LISTEN to IEC or IEEE
sub_a340_lstksa:
    bit mem_87d0_torl       ;Bit test for TALK or LISTEN state
    bvs sub_a353_tksa       ;If we sent TALK, branch to send
                            ;  secondary address for TALK to IEC or IEEE
    ;We sent LISTEN so fall through

;Send secondary address for LISTEN to IEC or IEC
sub_a345_second:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a34f_not_iec
    pla
    jmp sub_a49c_second     ;Send secondary address for LISTEN to IEC

lab_a34f_not_iec:
    pla
    jmp second              ;KERNAL Send Secondary Address to IEEE


;Send secondary address for TALK to IEC or IEEE
sub_a353_tksa:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a35d_not_iec
    pla
    jmp sub_a4bc_tksa       ;Send secondary address for TALK to IEC

lab_a35d_not_iec:
    pla
    jmp second              ;KERNAL Send Secondary Address to IEEE


;Assert ATN on IEC or IEEE
sub_a361_atnon:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a369_not_iec
    jmp sub_a4aa_atnon      ;Assert ATN (turns bit 3 of VIA PORT A on)

lab_a369_not_iec:
    jmp sub_a4b3_ieee_aton  ;Assert ATN on IEEE (turns bit 2 of VIA PORT B off)


;Release ATN on IEC or IEEE
sub_a36c_scatn:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a374_not_iec
    jmp sub_a4a1_scatn      ;Release ATN on IEC

lab_a374_not_iec:
    jmp scatn               ;Release ATN on IEEE


;Send last byte to IEC or IEEE
sub_a377_isour:
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a37f_not_iec
    jmp sub_a423_isour      ;Send last byte to IEC

lab_a37f_not_iec:
    jmp isour               ;KERNAL Send last byte to IEEE


;Send a command byte to IEC or IEEE
;Command byte in A can be 0x20=LISTEN, 0x3F=UNLISTEN, 0x40=TALK, 0x5F=UNTALK
;and this routine will OR it with the device address (FA).
sub_a382_sndcmd:
    pha
    jsr sub_a8a0_is_fa_iec  ;Is the KERNAL's current device number (FA) the current IEC device?
    bne lab_a38c_not_iec
    pla
    jmp lab_a3f4_sndcmd     ;Send a command byte to IEC

lab_a38c_not_iec:
    pla
    jmp sndcmd              ;KERNAL Send a command byte to IEEE


;Set up VIA, set FA = IEC device, STATUS = 0
sub_a390_setup:
    lda #0x3f
    sta via_ddrb
    lda #0x00
    sta via_timer_2_lo
    sta via_timer_2_hi
    sta via_acr
    lda #',
    sta tapwct              ;Used with !LOAD and !VERIFY commands
    lda #0x17
    sta via_porta
    lda #0x80
    sta mem_00fd_r2d2
    ;Fall through

;Set FA = copy of current IEC device num, set KERNAL STATUS = 0
sub_a3ad_set_fa_st:
    lda mem_03ff            ;A = copy of current IEC device number
    and #0x7f
    sta fa                  ;Set KERNAL current device number
    lda #0x00
    sta status              ;KERNAL STATUS = 0 (no error)
    rts

;==================================================================================================
;Start of code based on C64 KERNAL
;==================================================================================================

;XXX order of clklo and clkhi subroutines is swapped in c64 kernal

;Set clock line low (inverted)
sub_a3b9_clklo:
    lda via_porta
    ora #0b00010000
    sta via_porta
    rts

;Set clock line high (inverted)
sub_a3c2_clkhi:
    lda via_porta
    and #0b11101111
    sta via_porta
    rts

;Set data line high (inverted)
sub_a3cb_datahi:
    lda via_porta
    and #0b11011111
    sta via_porta
    rts

;Set data line low (inverted)
sub_a3d4_datalo:
    lda via_porta
    ora #0b00100000
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
    lda #0x40               ;A = 0x40 (TALK)
    .byte 0x2c              ;Skip next 2 bytes

;Send LISTEN to IEC
;XXX different from C64 KERNAL
sub_a3f2_listen:
    lda #0x20               ;A = 0x20 (LISTEN)
    ;Fall through

;Send a command byte to IEC
;XXX different from C64 KERNAL
lab_a3f4_sndcmd:
    sta mem_87d0_torl       ;Remember if we sent TALK (0x40) or LISTEN (0x20)

sub_a3f7_list1:
    ora fa                  ;XXX different from C64 KERNAL
                            ;OR the command with FA (device address)
    pha

    bit mem_00a0_c3p0       ;Character left in buf?
    bpl lab_a408_list2      ;No...

    ;Send buffered character
    sec                     ;Set EOI flag
    ror mem_00fd_r2d2
    jsr sub_a423_isour      ;Send last character
    lsr mem_00a0_c3p0       ;Buffer clear flag
    lsr mem_00fd_r2d2       ;Clear EOI flag

lab_a408_list2:
    pla                     ;TALK/LISTEN address
    sta bsour               ;IEEE byte buffer for output (FF means no character)
    sei
    jsr sub_a3cb_datahi     ;Set data line high (inverted)
    cmp #0x3f               ;CLKHI only on UNLISTEN
    bne lab_a416_list5
    jsr sub_a3c2_clkhi      ;Set clock line high (inverted)

lab_a416_list5:
    jsr sub_a4aa_atnon      ;a416  20 aa a4   Assert ATN (turns bit 3 of VIA PORT A on)
                            ;XXX different from C64 but does the same thing
sub_a419_isoura:
    sei
    jsr sub_a3b9_clklo      ;Set clock line low (inverted)
    jsr sub_a3cb_datahi     ;Set data line high (inverted)
    jsr sub_a3e7_w1ms       ;Delay 1 ms

sub_a423_isour:
    sei
    jsr sub_a3cb_datahi     ;Make sure data is released / Set data line high (inverted)
    jsr sub_a3dd_debpia     ;Data should be low / Debounce VIA PA then ASL A
    bcs lab_a490_nodev      ;Branch to device not present error
    jsr sub_a3c2_clkhi      ;Set clock line high (inverted)
    bit mem_00fd_r2d2       ;EOI flag test
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
    jsr sub_a3b9_clklo      ;Set clock line low (inverted)

    ;Set to send data
    lda #0x08               ;Count 8 bits
    sta mem_00ff_count

lab_a449_isr01:
    lda via_porta          ;Debounce the bus
    cmp via_porta
    bne lab_a449_isr01
    asl a                   ;Set the flags
    bcc lab_a493_frmerr     ;Data must be high
    ror bsour               ;Next bit into carry
    bcs lab_a45d_isrhi
    jsr sub_a3d4_datalo     ;Set data line low (inverted)
    bne lab_a460_isrclk

lab_a45d_isrhi:
    jsr sub_a3cb_datahi     ;Set data line high (inverted)

lab_a460_isrclk:
    jsr sub_a3c2_clkhi      ;Set clock line high (inverted)
    nop
    nop
    nop
    nop
    lda via_porta
    and #(0xff-0x20)        ;Data high
    ora #0x10               ;Clock low
    sta via_porta
    dec mem_00ff_count
    bne lab_a449_isr01
    lda #0x00               ;XXX does not match C64 KERNAL
    sta via_timer_2_lo
    lda #0x04               ;Trigger timer
    sta via_timer_2_hi
    lda via_ifr             ;Clear the timer flags

lab_a482_isr04:
    lda via_ifr
    and #0x20               ;XXX does not match C64 KERNAL
    bne lab_a493_frmerr     ;Branch to write timeout error
    jsr sub_a3dd_debpia     ;Debounce VIA PA then ASL A
    bcs lab_a482_isr04
    cli
    rts

lab_a490_nodev:
    lda #0b10000000         ;A = status bit for device not present error
    .byte 0x2c              ;Skip next 2 bytes

lab_a493_frmerr:
    lda #0b00000011         ;A = status bits for framing error

;Commodore Serial Bus Error Entry
lab_a495_csberr:
    jsr sub_a580_udst       ;KERNAL STATUS = STATUS | A
    cli                     ;IRQ's were off...turn on
    clc                     ;Make sure no KERNAL error returned
    bcc lab_a4f3_dlabye     ;Branch always to turn ATN off, release all lines

;Send secondary address for LISTEN to IEC
sub_a49c_second:
    sta bsour               ;Buffer character
    jsr sub_a419_isoura     ;Send it

;Release ATN after LISTEN
sub_a4a1_scatn:
    lda via_porta
    and #0xff-0x08
    sta via_porta          ;Release ATN
    rts

;Assert ATN
;XXX this routine does not exist in the C64 KERNAL
;Turn bit 3 of VIA PORT A on (ATN out)
sub_a4aa_atnon:
    lda via_porta
    ora #0x08
    sta via_porta
    rts

;Assert ATN on IEEE (turns bit 2 of VIA PORT B off)
;XXX obviously being IEEE this routine does not exist in C64 KERNAL
sub_a4b3_ieee_aton:
    lda via_portb
    and #0xff-0x04
    sta via_portb
    rts

;Send secondary address for TALK to IEC
sub_a4bc_tksa:
    sta bsour               ;Buffer character
    jsr sub_a419_isoura     ;Send secondary address
    sei                     ;No IRQ's here
    jsr sub_a3d4_datalo     ;Set data line low (inverted)
    jsr sub_a4a1_scatn      ;Release ATN
    jsr sub_a3c2_clkhi      ;Set clock line high (inverted)

lab_a4cb_tkatn1:
    jsr sub_a3dd_debpia     ;Wait for clock to go low / Debounce VIA PA then ASL A
    bmi lab_a4cb_tkatn1
    cli                     ;IRQ's okay now
    rts

;Send a byte to IEC
;Buffered output to IEC
sub_a4d2_ciout:
    bit mem_00a0_c3p0       ;Buffered char?
    bmi lab_a4db_ci2        ;Yes...send last

    sec                     ;No...
    ror mem_00a0_c3p0       ;Set buffered char flag
    bne lab_a4e0_ci4        ;Branch always

lab_a4db_ci2:
    pha                     ;Save current char
    jsr sub_a423_isour      ;Send last char
    pla                     ;Restore current char

lab_a4e0_ci4:
    sta bsour               ;Buffer current char
    clc                     ;Carry-Good exit
    rts

;Send UNTALK to IEC
sub_a4e4_untlk:
    sei
    jsr sub_a3b9_clklo      ;Set clock line low (inverted)
    jsr sub_a4aa_atnon      ;Assert ATN (turns bit 3 of VIA PORT A on)
    lda #0x5f               ;A = 0x5F (UNTALK)
    .byte 0x2c              ;Skip next 2 bytes

;Send UNLISTEN to IEC
sub_a4ef_unlsn:
    lda #0x3f               ;A = 0x3F (UNLISTEN)
    jsr sub_a3f7_list1      ;Send it

;Release all lines
lab_a4f3_dlabye:
    jsr sub_a4a1_scatn      ;Always release ATN

;Delay then release close and data
sub_a4f6_dladlh:
    txa                     ;Delay approx 60 us
    ldx #10

lab_a4f9_dlad00:
    dex
    bne lab_a4f9_dlad00
    tax
    jsr sub_a3c2_clkhi      ;Set clock line high (inverted)

    lda #0x00               ;XXX different from C64 KERNAL
    sta mem_00a0_c3p0       ;XXX

    jmp sub_a3cb_datahi     ;Set data line high (inverted)

;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
;XXX This is unique to VC-1541-DOS and is not from the C64 KERNAL.
sub_a507_acptrs:
    lda status              ;A = last status
    beq sub_a50e_acptr      ;Branch to do ACPTR if status is OK
    ;STATUS != 0
    lda #0x0d               ;A = carriage return
    rts

;Read a byte from IEC
;Input a byte from serial bus
sub_a50e_acptr:
    sei                     ;No IRQ allowed
    lda #0x00               ;Set EOI/ERROR Flag
    sta mem_00ff_count
    jsr sub_a3c2_clkhi      ;Make sure clock line is released / Set clock line high (inverted)

lab_a516_acp00a:
    jsr sub_a3dd_debpia     ;Wait for clock high / Debounce VIA PA then ASL A
    bpl lab_a516_acp00a

lab_a51b_eoiacp:
    lda #0x00               ;XXX
    sta via_timer_2_lo      ;XXX Order of VIA registers is different
    lda #0x01               ;XXX from C64 KERNAL, but values are the same
    sta via_timer_2_hi      ;XXX

    jsr sub_a3cb_datahi     ;Data line high (Makes timing more like VIC-20) / Set data line high (inverted)
    lda via_ifr             ;Clear the timer flags

lab_a52b_acp00:
    lda via_ifr             ;Check the timer
    and #0x20               ;XXX Different from C64 KERNAL
    bne lab_a539_acp00b     ;Ran out...
    jsr sub_a3dd_debpia     ;Check the clock line / Debounce VIA PA then ASL A
    bmi lab_a52b_acp00      ;No, not yet
    bpl lab_a551_acp01      ;Yes...

lab_a539_acp00b:
    lda mem_00ff_count      ;Check for error (twice thru timeouts)
    beq lab_a542_acp00c
    lda #2                  ;A = status bit for timeout error
    jmp lab_a495_csberr     ;ST = 2 read timeout

;Timer ran out, do an EOI thing
lab_a542_acp00c:
    jsr sub_a3d4_datalo     ;Set data line low (inverted)
    jsr sub_a3c2_clkhi      ;Delay and then set DATAHI (fix for 40us C64) / Set clock line high (inverted)
    lda #0b01000000         ;A = status bit for End of File (EOF)
    jsr sub_a580_udst       ;KERNAL STATUS = STATUS | A
    inc mem_00ff_count      ;Go around again for error check on EOI
    bne lab_a51b_eoiacp

;Do the byte transfer
lab_a551_acp01:
    lda #0x08               ;Set up counter
    sta mem_00ff_count

lab_a555_acp03:
    lda via_porta           ;Wait for clock high
    cmp via_porta           ;Debounce
    bne lab_a555_acp03
    asl a                   ;Shift data into carry
    bpl lab_a555_acp03      ;Clock still low...
    ror mem_00fe_bsour1     ;Rotate data in

lab_a562_acp03a:
    lda via_porta           ;Wait for clock low
    cmp via_porta           ;Debounce
    bne lab_a562_acp03a
    asl a
    bmi lab_a562_acp03a
    dec mem_00ff_count
    bne lab_a555_acp03      ;More bits...
    ;...exit...
    jsr sub_a3d4_datalo     ;Set data line low (inverted)
    bit status              ;Check for EOI
    bvc lab_a57b_acp04      ;None...

    jsr sub_a4f6_dladlh     ;Delay then set data high

lab_a57b_acp04:
    lda mem_00fe_bsour1
    cli                     ;IRQ is OK
    clc                     ;Good exit
    rts

;KERNAL STATUS = STATUS or A
sub_a580_udst:
    ora status
    sta status
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
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
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
    stx utlptr
    sty utlptr+1

    ldy #mem_a834_m_w_len   ;Y = 8
    sty fnlen               ;FNLEN = 8 (length of command to change drive's device number)

    dey                     ;Now Y = 7
    and #0x0f               ;A = Force device number in range 0-15
    sta mem_03ff            ;Store as copy of current IEC device number

    ;A = new device number and is in range 0-15

    ;Write TALK byte into M-W command in DOSBUF
    ora #0x40               ;Turn on bit 6 (TALK)
    sta [utlptr],y          ;Store A in DOSBUF+7
                            ;  0x0078: IEC bus TALK command to accept (device num | 0x40).

    ;Write LISTEN byte into M-W command in DOSBUF
    eor #0x60               ;Turn off bit 6 (TALK), turn on bit 5 (LISTEN)
    dey                     ;Now Y = 6
    sta [utlptr],y          ;Store A in DOSBUF+6
                            ;  0x0077: IEC bus LISTEN command to accept (device num | 0x20).

    dey                     ;Now Y = 5

    ;Write the rest of the M_W command into DOSBUF
lab_a5b8_loop:
    lda mem_a834_m_w,y      ;A = command to change drive's device number
    sta [utlptr],y          ;Store in DOSBUF
    dey
    bpl lab_a5b8_loop

    ;DOSBUF now contains command to change the drive's current device number,
    ;UTLPTR and FNLEN have been set up for it, so branch to send it
    bmi lab_a5ca_send_dos_cmd ;Branch always

lab_a5c2_not_u:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temporary string
    sta fnlen

;Send DOS command in buffer [UTLPTR]
;
;Call with UTLPTR = pointer to buffer with command string
;      and FNLEN = length of command
;
lab_a5ca_send_dos_cmd:
    lda #0x00
    sta status              ;KERNAL STATUS = 0 (no error)
    jsr sub_a3f2_listen     ;Send LISTEN to IEC
    lda #(0x0f | 0x60)      ;A = 0x0F (Command Channel) | 0x60 (SECOND)
    jsr sub_a49c_second     ;Send secondary address for LISTEN to IEC

    ldy #0x00

lab_a5d8_loop:
    lda [utlptr],y          ;A = byte from string to send to command channel
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
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
    jsr sub_a7b6_eval_fname ;Evaluate expression as filename; set up FNLEN and FNADR
    lda #(1 | 0x60)         ;A = secondary address 1 (SAVE) | 0x60 (SECOND)
    sta sa                  ;Set SA (KERNAL current secondary address)
    ldy fnlen
    bne lab_a5fc_fnlen_ok   ;Branch if filename is not empty
    ;Filename is empty
    jmp syntax              ;BASIC ?SYNTAX ERROR

lab_a5fc_fnlen_ok:
    jsr sub_a689_open       ;Send OPEN to IEC
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
    jsr iscoma              ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
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
    jsr sub_a3f2_listen     ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a49c_second     ;Send secondary address for LISTEN to IEC
    ldy #0x00               ;Y is always 0 in lab_a647_loop below
    lda salptr
    jsr sub_a4d2_ciout      ;Send a byte to IEC
    lda salptr+1
    jsr sub_a4d2_ciout      ;Send a byte to IEC

lab_a647_loop:
    jsr sub_a672_cmp_sal_eal;Compare SALPTR with EALPTR, sets C=1 if equal
    bcs lab_a65b_done       ;Branch to done if end reach of range reached

    lda [salptr],y          ;A = get byte at SALPTR (Y is always 0)
    jsr sub_a4d2_ciout      ;Send a byte to IEC

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    beq lab_a65b_done       ;  Yes: branch to done

    ;STOP key not pressed

    jsr sub_a682_inc_salptr ;Increment SALPTR
    bne lab_a647_loop

lab_a65b_done:
    jsr sub_a4ef_unlsn      ;Send UNLISTEN to IEC

;Send CLOSE to IEC
sub_a65e_close:
    bit sa
    bmi lab_a671_done
    jsr sub_a3f2_listen     ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL current secondary address
    and #0b11101111         ;AND 0xEF so high nibble be OR'd to become 0xE
    ora #0b11100000         ;OR  0xE0 = CLOSE
    jsr sub_a49c_second     ;Send secondary address for LISTEN to IEC
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
sub_a682_inc_salptr:
    inc salptr
    bne lab_a688_nc
    inc salptr+1

lab_a688_nc:
    rts

;Send OPEN to IEC
sub_a689_open:
    lda sa                  ;A = KERNAL current secondary address
    bpl lab_a68f

lab_a68d_error:
    clc
    rts

lab_a68f:
    ldy fnlen
    beq lab_a68d_error      ;Branch to do nothing if filename is empty
    ;Filename is not empty
    lda #0x00
    sta status              ;KERNAL STATUS = 0 (no error)
    jsr sub_a3f2_listen     ;Send LISTEN to IEC
    lda sa                  ;A = KERNAL current secondary address
    ora #0xf0               ;OR it with 0xF0 = OPEN
    jsr sub_a49c_second     ;Send secondary address for LISTEN to IEC
    lda status              ;A = KERNAL status
    bpl lab_a6a8_present    ;Branch if device not present error bit = 0
    ;device not present
    jmp nprsnt              ;KERNAL ?DEVICE NOT PRESENT ERROR

;device is present
lab_a6a8_present:
    ldy #0x00

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
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;Is the byte at txtptr+0 a semicolon?
    bne lab_a6c6_not_semi

    ;Byte at txtptr+0 is a semicolon
    sta tapwct              ;Store the semicolon
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
    ldx #0x16
    stx mem_0013
    lda #0x00
    sta mem_003b
    sta subflg              ;Subscript flag; FNX flag

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
    lda #(0 | 0x60)         ;A = secondary address 0 (LOAD) | 0x60 (SECOND)
    sta sa                  ;Set SA (KERNAL current secondary address)
    jsr sub_a689_open       ;Send OPEN to IEC (does nothing if filename is empty)
    jsr sub_a3ef_talk       ;Send TALK to IEC
    lda sa                  ;A = KERNAL current secondary address
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr              ;Store program's start address low (or the CR) in pointer low

    lda status              ;A = status
    lsr a                   ;Bit 1 (timeout error) -> Bit 0
    lsr a                   ;Bit 0 -> C
    bcc lab_a71f_no_tmo     ;Branch if C is clear, meaning no timeout occurred

    jmp notfnd              ;KERNAL ?FILE NOT FOUND ERROR

lab_a71f_no_tmo:
    jsr lodmsg              ;KERNAL Print LOADING or VERIFYING if in direct mode

    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr+1            ;Store program's start address high (or the CR) in pointer high

    jsr sub_a85a_cmp_comma  ;Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a73e_not_comma  ;No start address specified in command, branch to keep salptr

    ;Found a comma; parse start address from command
    jsr chrget              ;Consume the comma
    jsr sub_a861_parse_addr ;Parse a 4-digit hex address from BASIC text into ml1ptr

    ;Copy ml1ptr (start address from command) into salptr
    lda ml1ptr
    sta salptr
    lda ml1ptr+1
    sta salptr+1

    lda #';
    sta tapwct

lab_a73e_not_comma:
    lda tapwct
    cmp #',
    bne lab_a750_read_loop
    lda verchk              ;A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a750_read_loop  ;Branch if performing VERIFY
    ;Performing LOAD
    lda salptr
    sta txttab
    lda salptr+1
    sta txttab+1

lab_a750_read_loop:
    lda #0b11111101         ;A = mask off status bit 1 (timeout error)
    and status
    sta status              ;Store STATUS with timeout error cleared

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a75e_no_stop    ;  No: branch to keep going

    ;STOP key pressed
    jmp sub_a65e_close      ;Jump out to Send CLOSE to IEC

;STOP key not pressed
lab_a75e_no_stop:
    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).

    tax                     ;X = byte received from IEC
    lda status              ;A = status
    lsr a                   ;Bit 1 (timeout error) -> Bit 0
    lsr a                   ;Bit 0 -> C
    bcs lab_a750_read_loop  ;Branch if C is set, meaning a timeout occurred
    txa                     ;A = byte received from IEC

    ldy verchk              ;Y = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    beq lab_a794_sta_byte   ;Branch if performing LOAD

    ;Performing VERIFY
    ldy #0x00
    cmp [salptr],y          ;Compare byte received with byte to verify
    beq lab_a796_next_byte  ;Branch if bytes are equal

    ;VERIFY failed
    lda #0b00010000         ;A = status bit for VERIFY error
    jsr sub_a580_udst       ;KERNAL STATUS = STATUS | A
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jsr sub_a65e_close      ;Send CLOSE to IEC

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
    bit status
    bvc lab_a750_read_loop  ;Branch if EOF not yet reached

    ;EOF reached
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jsr sub_a65e_close      ;Send CLOSE to IEC
    lda tapwct
    cmp #',
    bne lab_a7b5_done
    lda verchk              ;A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a7b5_done       ;Branch if performing VERIFY
    ;Performing LOAD
    lda salptr
    sta vartab
    lda salptr+1
    sta vartab+1

lab_a7b5_done:
    rts

;Evaluate expression as filename; set up FNLEN and FNADR
sub_a7b6_eval_fname:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temporary string
    sta fnlen
    lda utlptr
    sta fnadr
    lda utlptr+1
    sta fnadr+1
    rts

;Wedge command !CATALOG
;
;  !CATALOG             List directory without filename; equivalent to CATALOG"$"
;
;  !CATALOG"filename"   List directory with filename
;
lab_a7c7_wedge_catalog:
    jsr sub_a390_setup      ;Set up VIA, set FA = IEC device, STATUS = 0
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
    lda #(0 | 0x60)         ;A = secondary address 0 (LOAD) | 0x60 (SECOND)
    sta sa                  ;Set SA (KERNAL current secondary address)
    jsr sub_a689_open       ;Send OPEN to IEC
    jsr sub_a3ef_talk       ;Send TALK to IEC
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

    lda #0x00
    sta status              ;KERNAL STATUS = 0 (no error)

    ;salptr is not used as a pointer below, rather as two temporary locations:
    ;  salptr:   counts down bytes (used with Y register)
    ;  salptr+1: low byte received from IEC

    ldy #0x03               ;Countdown = 3, meaning 6 bytes will be read:
                            ;  Program start address low, high
                            ;  Next BASIC line address low, high
                            ;  Current BASIC line number low, high

;Read up to BASIC line number (block size of program), then print it
lab_a7f4_line_loop:
    sty salptr              ;Store Y in byte countdown

    ;Receive low byte from IEC, store in salptr+1
    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    sta salptr+1            ;Store low byte received from IEC (or the CR)
    ldy status
    bne lab_a831_error      ;Branch if STATUS != 0

    ;Receive high byte from IEC, leave it in A
    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    ldy status
    bne lab_a831_error      ;Branch if STATUS != 0

    ;Loop until line number has been read
    ldy salptr              ;Y = byte countdown
    dey                     ;Decrement countdown
    bne lab_a7f4_line_loop  ;Keep going until line number has been read

    ;Print line number (block size of progam)
                            ;A still contains the high byte received from IEC
    ldx salptr+1            ;X = low byte received from IEC
    jsr linprt              ;BASIC Print 256*A + X in decimal

    ;Print space after line number
    lda #0x20               ;A = SPACE character
    jsr chrout              ;KERNAL Send a char to the current output device

;Read and print BASIC line contents (program filename and type)
lab_a815_fname_loop:
    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    ldx status
    bne lab_a831_error      ;Branch if STATUS != 0

    tax                     ;X = A (byte received), just to set Z flag
    beq lab_a825_eol        ;Branch if byte received = 0, meaning end of BASIC line

    ;Print byte in BASIC line
    jsr chrout              ;KERNAL Send a char to the current output device
    jmp lab_a815_fname_loop

;End of current BASIC line reached
lab_a825_eol:
    ;Print carriage return after line
    lda #0x0d               ;A = carriage return
    jsr chrout              ;KERNAL Send a char to the current output device

    ldy #0x02               ;Countdown = 2, meaning 4 bytes will be read:
                            ;  Next BASIC line address low, high
                            ;  Current BASIC line number low, high

    jsr sub_a89a_chk_stop   ;STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a7f4_line_loop  ;  Branch to get next line if not pressed

    ;STOP key pressed

lab_a831_error:
    jmp sub_a65e_close      ;Jump out to Send CLOSE to IEC

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
    jsr sub_a65e_close      ;Send CLOSE to IEC
    jsr sub_a3ad_set_fa_st  ;Set FA = copy of current IEC device num, set KERNAL STATUS = 0
    jsr sub_a3ef_talk       ;Send TALK to IEC
    lda #(0x0F | 0x60)      ;A = 0x0F (Command Channel) | 0x60 (SECOND)
    jsr sub_a4bc_tksa       ;Send secondary address for TALK to IEC

lab_a84a_more:
    jsr sub_a507_acptrs     ;If STATUS=0 then read a byte from IEC, else return a CR (0x0D).
    jsr chrout              ;KERNAL Send a char to the current output device
    cmp #0x0d               ;Is the character a carriage return?
    bne lab_a84a_more       ;  No: loop for another character
    ;Carriage return; end of input
    jsr sub_a4e4_untlk      ;Send UNTALK to IEC
    jmp sub_a65e_close      ;Send CLOSE to IEC

;Compares byte at txtptr with a comma
sub_a85a_cmp_comma:
    ldy #0x00
    lda [txtptr],y
    cmp #',
    rts

;Parse a 4-digit hex address from BASIC text into ml1ptr
;Evals expression, calls hexit 4 times, sets ml1ptr
;Called only during LOAD, SAVE, or VERIFY
sub_a861_parse_addr:
    jsr frmevl              ;BASIC Input and evaluate any expression
    jsr frestr              ;BASIC Discard temporary string
    cmp #0x04               ;Is it exactly 4 characters?
    bne lab_a88c_syntax     ;  No: jump to ?SYNTAX ERROR
    ldy #0xff               ;Y=FF so it rolls to 0 on first call
    ;high byte, high nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [utlptr],Y
    jsr sub_a88f_swap_nib   ;Perform ASL A four times
    sta ml1ptr+1
    ;high byte, low nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [utlptr],Y
    ora ml1ptr+1
    sta ml1ptr+1
    ;low byte, low nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [utlptr],Y
    jsr sub_a88f_swap_nib   ;Perform ASL A four times
    sta ml1ptr
    ;low byte, low nibble
    jsr sub_a894_hexit      ;INCY then hexit value at [utlptr],Y
    ora ml1ptr
    sta ml1ptr
    rts

lab_a88c_syntax:
    jmp syntax              ;?SYNTAX ERROR

;Perform ASL A four times
sub_a88f_swap_nib:
    asl a
    asl a
    asl a
    asl a
    rts

;INCY then hexit value at [utlptr],Y
sub_a894_hexit:
    iny
    lda [utlptr],y
    jmp hexit               ;MONITOR Evaluate char in A to a hex nibble

;STOP key pressed?  Returns Z=1 if so.
sub_a89a_chk_stop:
    lda pia1_portb
    cmp #0b11101111         ;STOP is row 9, col 4 on both bus and gfx keyboards
    rts

;Is the KERNAL's current device number (FA) the current IEC device?
;Returns Z=1 if so.
sub_a8a0_is_fa_iec:
    lda mem_03ff            ;A = copy of current IEC device number
    and #0x7f               ;Mask off bit 7
    cmp fa                  ;Compare to KERNAL current device number
    rts

;Parse int into SA with leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
sub_a8a8_parse_sa_1:
    lda #'#
    jsr isaequ              ;BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A
    ;Fall through

;Parse int into SA without leading # or ?SYNTAX ERROR, set FA=IEC, STATUS=0
sub_a8ad_parse_sa_2:
    jsr sub_a3ad_set_fa_st  ;Set FA = copy of current IEC device num, set KERNAL STATUS = 0
    jsr gtbytc+3            ;BASIC Evaluate integer 0-255, return it in X
    txa                     ;A = secondary address
    ora #0x60               ;OR secondary address with 0x60 (SECOND)
    sta sa                  ;Set SA (KERNAL current secondary address)
    rts
