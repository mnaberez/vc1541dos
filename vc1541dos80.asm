    .area CODE1 (ABS)
    .org 0xa000

    mem_0003 = 0x03
    mem_0004 = 0x04
    valtyp = 0x07           ;Data type of value: 0=numeric, $ff=string
    intflag = 0x08          ;Type of number: 0=floating point, $80=integer
    mem_000a = 0x0a
    mem_000b = 0x0b
    mem_0010 = 0x10
    mem_0013 = 0x13
    mem_001f = 0x1f
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
    status = 0x96           ;KERNAL Status Byte, from which ST is computed
    verchk = 0x9d           ;KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    mem_00a0_c3p0 = 0xa0
    bsour = 0xa5            ;IEEE byte buffer for output (FF means no character)
    tapend = 0xab           ;End of tape input flag ***
    ealptr = 0xb7           ;Pointer: end address for SAVE ***
    tapwct = 0xba           ;Tape write countdown ***
    salptr = 0xc9           ;Pointer: start address for LOAD or SAVE ***
    fnlen = 0xd1            ;Length of file name: 0=no name
    sa = 0xd3               ;Current secondary address OR'd e.g. with #60
    fa = 0xd4               ;Current device number
    datax = 0xd9            ;Current Character to Print
    fnadr = 0xda            ;Pointer: Start of filename
    prscr = 0xeb            ;Print to screen vector
    ml1ptr = 0xfb           ;Pointer: start of tape address for .S ***
    mem_00fd_r2d2 = 0xfd
    mem_00fe = 0xfe
    mem_00ff_count = 0xff
    mem_0102 = 0x102
    mem_0103 = 0x103
    mem_01ff = 0x1ff
    mem_0200 = 0x200
    mem_03fe = 0x3fe        ;Current device number on IEC bus (default 8)
    mem_03ff = 0x3ff        ;Copy of current IEC device number
    mem_87d0 = 0x87d0

    rsgetc = 0xb622         ;BASIC Reset GETCHR to start of program
    error = 0xb3cf          ;BASIC Print error message offset by X in msgs table and return to prompt
    lab_b4ad = 0xb4ad
    sub_b965 = 0xb965
    prstr = 0xbb1d          ;BASIC Print null-terminated string at A=addr low, Y=addr hi
    defdev = 0xbb44         ;BASIC Restore default devices
    restor = 0xb7b7         ;BASIC Perform RESTORE
    frmevl = 0xbd98         ;BASIC Input and evaluate any expression
    syntax = 0xbf00         ;BASIC ?SYNTAX ERROR
    sub_b94d = 0xb94d
    lab_bb4c = 0xbb4c
    sub_bcda = 0xbcda
    iscoma = 0xbef5         ;BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    isaequ = 0xbef7         ;BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A
    ptrget = 0xc12b         ;BASIC Find a variable
    sub_c5b0 = 0xc5b0
    list = 0xc5b5           ;BASIC Perform list; full check of parameters, incl. -
    freestr = 0xc7b5        ;BASIC Discard temporary string
    gtbytc = 0xc8d1         ;BASIC Evaluate an expr for 1-byte param (0-255), return in X
    wtxtptr = 0xc918        ;BASIC Copy FBUFPT (0x006E) to TXTPTR (0x0077)
    fin = 0xce29            ;BASIC Convert an ASCII string into a numeral in FPAcc #1
    linprt = 0xcf83         ;BASIC Print 256*A + X in decimal
    sub_cf93 = 0xcf93
    sub_d52e = 0xd52e
    sub_d717 = 0xd717
    prcrlf = 0xd534         ;BASIC Print carriage return and linefeed
    hexit = 0xd78d          ;MONITOR Evaluate char in A to a hex nibble
    lab_e787 = 0xe787       ;EDITOR Default routine for PRSCR vector

    pia1_portb = 0xe812     ;PIA 1 Port B
    via_portb = 0xe840      ;VIA Port B
    via_port_a = 0xe841     ;VIA Port A
    via_ddrb = 0xe843       ;VIA DDR B
    via_timer_2_lo = 0xe848 ;VIA Timer 2 Low
    via_timer_2_hi = 0xe849 ;VIA Timer 2 High
    via_acr = 0xe84b        ;VIA ACR
    via_ifr = 0xe84d        ;VIA IFR

    talk = 0xf0d2           ;KERNAL Send TALK to IEEE
    listen = 0xf0d5         ;KERNAL Send LISTEN to IEEE
    untorl = 0xf0d7         ;KERNAL Send UNTALK or UNLISTEN to IEEE
    isour = 0xf109          ;KERNAL Send last byte to IEEE
    second = 0xf143         ;KERNAL Send Secondary Address to IEEE
    scatn = 0xf148          ;KERNAL Release ATN on IEEE
    ciout = 0xf19e          ;KERNAL Send a byte to file on IEEE
    untlk = 0xf1ae          ;KERNAL Send UNTALK to IEEE
    unlsn = 0xf1b9          ;KERNAL Send UNLISTEN to IEEE
    acptr = 0xf1c0          ;KERNAL Read a byte from IEEE
    lodmsg = 0xf46d         ;KERNAL Print LOADING or VERIFYING if in direct mode
    notfnd = 0xf5ad         ;KERNAL ?FILE NOT FOUND ERROR
    prmsg = 0xf349          ;KERNAL Print a message from 0xF000 table at offset Y
    is7802 = 0xf351         ;KERNAL Compare TXTPTR+1: LDA $78; CMP #$02; RTS
    srchng = 0xf449         ;KERNAL Print SEARCHING if in direct mode
    open = 0xf4a5           ;KERNAL Send OPEN to IEEE
    nprsnt = 0xf4bb         ;KERNAL ?DEVICE NOT PRESENT ERROR
    krnerr = 0xf5b7         ;KERNAL ?<message> ERROR from KERNAL error in Y
    close = 0xf72f          ;KERNAL Send CLOSE to IEEE
    stop = 0xf92b           ;KERNAL Test STOP key and act if pressed
    chrout = 0xffd2         ;KERNAL Send a char to the current output device

    ;Entry points at the beginning of the ROM

    jmp ep_a036_install         ;a000  4c 36 a0   Install the wedge with CHRGET patch
    jmp ep_a09c_wedge_cmd       ;a003  4c 9c a0   Perform wedge command at txtptr+0
    jmp ep_a377_isour           ;a006  4c 77 a3   Send a byte to IEC or IEEE
    jmp ep_a382_untorl          ;a009  4c 82 a3   Send UNTALK or UNLISTEN to IEC or IEEE (XXX really?)
    jmp ep_a128_open            ;a00c  4c 28 a1   Send OPEN to IEC or IEEE
    jmp ep_a128_close           ;a00f  4c 36 a1   Send CLOSE to IEC or IEEE
    jmp sub_a141_acptr          ;a012  4c 41 a1   Read a byte from IEC or IEEE
    jmp sub_a306_ciout          ;a015  4c 06 a3   Send a byte to IEC or IEEE
    jmp sub_a314_listen         ;a018  4c 14 a3   Send LISTEN to IEC or IEEE
    jmp sub_a32a_unlsn          ;a01b  4c 2a a3   Send UNLISTEN to IEC or IEEE
    jmp sub_a31f_talk           ;a01e  4c 1f a3   Send TALK to IEC or IEEE
    jmp sub_a335_untlk          ;a021  4c 35 a3   Send UNTALK to IEC or IEEE
    jmp lab_a345_second         ;a024  4c 45 a3   Send secondary address to IEC or IEC for LISTEN
    jmp lab_a353_tksa           ;a027  4c 53 a3   Send secondary address to IEC or IEEE for TALK
    jmp sub_a340_lstksa         ;a02a  4c 40 a3   Send secondary address to IEC or IEEE for TALK or LISTEN
    jmp lab_a361_atnon          ;a02d  4c 61 a3   Assert ATN on IEC or IEEE
    jmp lab_a36c_scatn          ;a030  4c 6c a3   Release ATN on IEC or IEEE
    jmp lab_a119_jmp_lstksa     ;a033  4c 19 a1   Jumps directly to sub_a340_lstksa

ep_a036_install:
    lda #0x4c               ;a036  a9 4c
    sta chrget              ;a038  85 70
    lda #<lab_a061_wedge    ;a03a  a9 61
    sta chrget+1            ;a03c  85 71
    lda #>lab_a061_wedge    ;a03e  a9 a0
    sta chrget+2            ;a040  85 72
    lda #0x08               ;a042  a9 08
    sta mem_03fe            ;a044  8d fe 03   Current unit number on IEC bus = 8
    jsr sub_a390_setup      ;a047  20 90 a3   Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    lda #<banner            ;a04a  a9 51
    ldy #>banner            ;a04c  a0 a0
    jmp prstr               ;a04e  4c 1d bb   BASIC Print null-terminated string at A=addr low, Y=addr hi

banner:
    .ascii "VC-1541-DOS/80"
    .byte 0x0d, 0x00

lab_a061_wedge:
    inc txtptr              ;a061  e6 77
    bne lab_a067            ;a063  d0 02
    inc txtptr+1            ;a065  e6 78

lab_a067:
    jsr chrgot              ;a067  20 76 00   Subroutine: Get the Same Byte of BASIC Text again
    php                     ;a06a  08
    cmp #'!                 ;a06b  c9 21
    bne lab_a090_wedge_done ;a06d  d0 21
    stx tapend              ;a06f  86 ab      End of tape input flag
    tsx                     ;a071  ba
    lda mem_0103,x          ;a072  bd 03 01
    cmp #0xbf               ;a075  c9 bf
    beq lab_a07d            ;a077  f0 04
    cmp #0xb8               ;a079  c9 b8
    bne lab_a08c            ;a07b  d0 0f

lab_a07d:
    lda mem_0102,x          ;a07d  bd 02 01
    cmp #0x23               ;a080  c9 23
    beq lab_a092            ;a082  f0 0e
    cmp #0xc1               ;a084  c9 c1
    bne lab_a08c            ;a086  d0 04
    lda facexp              ;a088  a5 5e
    bne lab_a092            ;a08a  d0 06

lab_a08c:
    ldx tapend              ;a08c  a6 ab
    lda #0x21               ;a08e  a9 21

lab_a090_wedge_done:
    plp                     ;a090  28
    rts                     ;a091  60

lab_a092:
    plp                     ;a092  28
    jsr chrget              ;a093  20 70 00
    lda mem_03fe            ;a096  ad fe 03     A = current device number on IEC bus
    sta mem_03ff            ;a099  8d ff 03     Save as copy of current IEC device number

ep_a09c_wedge_cmd:
    jsr sub_a85a_cmp_comma  ;a09c  20 5a a8     Gets byte at txtptr+0 into A, compares it to a comma
    pha                     ;a09f  48
    jsr chrget              ;a0a0  20 70 00
    pla                     ;a0a3  68
    cmp #0x93               ;a0a4  c9 93        Is byte at txtptr+0 = 0x93 = LOAD token
    beq lab_a10f_cmd_load   ;a0a6  f0 67
    cmp #0x94               ;a0a8  c9 94        Is byte at txtptr+0 = 0x94 = SAVE token
    bne lab_a0af            ;a0aa  d0 03
    jmp lab_a5e5_cmd_save   ;a0ac  4c e5 a5

lab_a0af:
    cmp #0x95               ;a0af  c9 95        Is byte at txtptr+0 = 0x95 = VERIFY token
    beq lab_a112_cmd_verify ;a0b1  f0 5f
    cmp #0xd7               ;a0b3  c9 d7        Is byte at txtptr+0 = 0xD7 = CATALOG token
    bne lab_a0ba            ;a0b5  d0 03
    jmp lab_a7c7_cmd_catalog ;a0b7  4c c7 a7

lab_a0ba:
    cmp #0x9f               ;a0ba  c9 9f        Is byte at txtptr+0 = 0x9F = OPEN token
    bne lab_a0c1            ;a0bc  d0 03
    jmp lab_a11c_cmd_open   ;a0be  4c 1c a1

lab_a0c1:
    cmp #0x98               ;a0c1  c9 98        Is byte at txtptr+0 = 0x98 = PRINT# token
    bne lab_a0c8            ;a0c3  d0 03
    jmp lab_a175_cmd_print  ;a0c5  4c 75 a1

lab_a0c8:
    cmp #0xa1               ;a0c8  c9 a1        Is byte at txtptr+0 = 0xA1 = GET token
    bne lab_a0cf            ;a0ca  d0 03
    jmp lab_a1e0_cmd_get    ;a0cc  4c e0 a1

lab_a0cf:
    cmp #0xa0               ;a0cf  c9 a0        Is byte at txtptr+0 = 0xA0 = CLOSE token
    bne lab_a0d6            ;a0d1  d0 03
    jmp lab_a133_cmd_close  ;a0d3  4c 33 a1

lab_a0d6:
    cmp #0x84               ;a0d6  c9 84        Is byte at txtptr+0 = 0x84 = INPUT# token
    bne lab_a0dd            ;a0d8  d0 03
    jmp lab_a226_cmd_input  ;a0da  4c 26 a2

lab_a0dd:
    cmp #0x9d               ;a0dd  c9 9d        Is byte at txtptr+0 = 0x9D = CMD token
    bne lab_a0e4            ;a0df  d0 03
    jmp lab_a14c_cmd_cmd    ;a0e1  4c 4c a1

lab_a0e4:
    cmp #'Q                 ;a0e4  c9 51        Is byte at txtptr+0 = Q char?
    bne lab_a0f5            ;a0e6  d0 0d
    ;Wedge command is Quit
    ;Restore normal CHRGET processing
    lda #0xe6               ;a0e8  a9 e6
    sta chrget              ;a0ea  85 70        0070 E6 77 INC $77
    lda #0x77               ;a0ec  a9 77
    sta chrget+1            ;a0ee  85 71
    lda #0xd0               ;a0f0  a9 d0        0072 D0 xx BNE xx
    sta chrget+2            ;a0f2  85 72
    rts                     ;a0f4  60

lab_a0f5:
    cmp #'@                 ;a0f5  c9 40        Is byte at txtptr+0 = @ char?
    bne lab_a0fc            ;a0f7  d0 03
    jmp lab_a586_cmd_dos    ;a0f9  4c 86 a5

lab_a0fc:
    dec txtptr              ;a0fc  c6 77
    lda txtptr              ;a0fe  a5 77
    cmp #0xff               ;a100  c9 ff
    bne lab_a106            ;a102  d0 02
    dec txtptr+1            ;a104  c6 78

lab_a106:
    jsr gtbytc+3            ;a106  20 d4 c8     BASIC Evaluate integer 0-255, return it in X
    stx mem_03ff            ;a109  8e ff 03     Save as copy of current IEC device number
    jmp ep_a09c_wedge_cmd             ;a10c  4c 9c a0


;Wedge command !LOAD
;
;  !LOAD"filename"         Load into BASIC program area
;  !LOAD"filename",start   Load into start address
;
lab_a10f_cmd_load:
    lda #0                  ;a10f  a9 00        A = 0 (LOAD)
    bit 0xffa9              ;a111  2c a9 ff     VERIFY jumps here mid-instruction = LDA #0xff

;Wedge command !VERIFY
;
;  !VERIFY"filename"         Verify against BASIC program area
;  !VERIFY"filename",start   Verify against start address
;
lab_a112_cmd_verify = (. - 2)
   ;lda #0xff              ;a111  __ a9 ff     A = FF (VERIFY)

    sta verchk             ;a114  85 9d        Store in KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    jmp lab_a6b7_load_or_verify ;a116  4c b7 a6

;Jump to Send secondary address to IEC or IEEE for TALK or LISTEN
lab_a119_jmp_lstksa:
    jmp sub_a340_lstksa     ;a119  4c 40 a3     Send secondary address to IEC or IEEE for TALK or LISTEN

;Wedge command !OPEN
;
;  OPEN#SA,"FILENAME"     Open file on IEC or IEEE device with secondary address SA
;  OPEN#SA,""             Open the channel without sending a filename
;
lab_a11c_cmd_open:
    jsr sub_a390_setup      ;a11c  20 90 a3     Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    jsr sub_a8a8_parse_sa_1 ;a11f  20 a8 a8     Parse integer into SA with leading # sign, or Syntax Error
    jsr iscoma              ;a122  20 f5 be     BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a7b6_eval_fname ;a125  20 b6 a7     Evaluate expression as filename; set up FNLEN and FNADR
    ;Fall through


;Send OPEN to IEC or IEEE
ep_a128_open:
    jsr sub_a8a0_cmp_fa     ;a128  20 a0 a8     Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a130_not_iec    ;a12b  d0 03
    jmp sub_a689_open       ;a12d  4c 89 a6     Send OPEN to IEC

lab_a130_not_iec:
    jmp open                ;a130  4c a5 f4     Send filename to IEEE


;Wedge command !CLOSE
;
;  !CLOSE#SA               Close file on IEC or IEEE device with secondary address SA
;
lab_a133_cmd_close:
    jsr sub_a8a8_parse_sa_1 ;a133  20 a8 a8   Parse integer into SA with leading # sign, or Syntax Error
    ;Fall through


;Send CLOSE to IEC or IEEE
ep_a128_close:
    jsr sub_a8a0_cmp_fa     ;a136  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a13e_not_iec    ;a139  d0 03
    jmp sub_a65e_close      ;a13b  4c 5e a6   Send CLOSE to IEC

lab_a13e_not_iec:
    jmp close               ;a13e  4c 2f f7   Send CLOSE to IEC


;Read a byte from IEC or IEEE
sub_a141_acptr:
    jsr sub_a8a0_cmp_fa     ;a141  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a149_not_iec    ;a144  d0 03
    jmp sub_a507_acptrs     ;a146  4c 07 a5   Read a byte from IEC with initial status check

lab_a149_not_iec:
    jmp acptr              ;a149  4c c0 f1   XXX seems not correct


;Wedge command !CMD
;
;  !CMD#SA    Redirect output to the given secondary address on the
;             current device, which is specified by location $D4 / 212.
;             The device may be IEC or IEEE.
;
lab_a14c_cmd_cmd:
    jsr sub_a8a8_parse_sa_1 ;a14c  20 a8 a8   Parse integer into SA with leading # sign, or Syntax Error
    lda #<lab_a15f_prscr    ;a14f  a9 5f
    sta prscr               ;a151  85 eb
    lda #>lab_a15f_prscr    ;a153  a9 a1
    sta prscr+1             ;a155  85 ec
    jsr sub_a314_listen     ;a157  20 14 a3   Send LISTEN to IEC or IEEE
    lda sa                  ;a15a  a5 d3      A = KERNAL current secondary address
    jmp sub_a340_lstksa     ;a15c  4c 40 a3   Send secondary address to IEC or IEEE for TALK or LISTEN


;Routine installed in prscr vector
lab_a15f_prscr:
    lda datax               ;a15f  a5 d9      A = Current character to print
    cmp #0x0d               ;a161  c9 0d      Is it a carriage return?
    bne lab_a16f_not_cr     ;a163  d0 0a
    ;It's a carriage return
    bit mem_03ff            ;a165  2c ff 03   Bit with copy of current IEC device number
    bpl lab_a16f_not_cr     ;a168  10 05
    jsr sub_a306_ciout      ;a16a  20 06 a3   Send a byte to IEC or IEEE
    lda #0x0a               ;a16d  a9 0a

lab_a16f_not_cr:
    jsr sub_a306_ciout      ;a16f  20 06 a3   Send a byte to IEC or IEEE
    jmp lab_e787            ;a172  4c 87 e7   EDITOR Default routine for PRSCR vector


;Wedge command !PRINT#
;
;
lab_a175_cmd_print:
    ;Are we in CMD# mode?  If so, the PRSCR vector points to our routine.
    lda prscr               ;a175  a5 eb
    cmp #<lab_a15f_prscr    ;a177  c9 5f
    bne lab_a18c_not_in_cmd ;a179  d0 11
    lda prscr+1             ;a17b  a5 ec
    cmp #>lab_a15f_prscr    ;a17d  c9 a1
    bne lab_a18c_not_in_cmd ;a17f  d0 0b

    ;We're in CMD# mode.  Restore the default PRSCR routine and UNLISTEN
    ;to get out of CMD# mode.

    lda #<lab_e787          ;a181  a9 87      EDITOR Default routine for PRSCR vector
    sta prscr               ;a183  85 eb
    lda #>lab_e787          ;a185  a9 e7      EDITOR Default routine for PRSCR vector
    sta prscr+1             ;a187  85 ec

    jsr sub_a32a_unlsn      ;a189  20 2a a3   Send UNLISTEN to IEC or IEEE

lab_a18c_not_in_cmd:
    jsr sub_a8ad_parse_sa_2 ;a18c  20 ad a8   Parse integer into SA without leading #, or Syntax Error
    jsr sub_a314_listen     ;a18f  20 14 a3   Send LISTEN to IEC or IEEE
    lda sa                  ;a192  a5 d3      A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;a194  20 40 a3   Send secondary address to IEC or IEEE for TALK or LISTEN
    jsr sub_a85a_cmp_comma  ;a197  20 5a a8   Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a1ce_not        ;a19a  d0 32
    jsr chrget              ;a19c  20 70 00

lab_a19f_semi:
    jsr frmevl              ;a19f  20 98 bd   BASIC Input and evaluate any expression
    bit valtyp              ;a1a2  24 07
    bmi lab_a1ac            ;a1a4  30 06
    jsr sub_cf93            ;a1a6  20 93 cf
    jsr sub_c5b0            ;a1a9  20 b0 c5

lab_a1ac:
    jsr freestr             ;a1ac  20 b5 c7   BASIC Discard temporary string
    sta fnlen               ;a1af  85 d1
    ldy #0x00               ;a1b1  a0 00

lab_a1b3:
    cpy fnlen               ;a1b3  c4 d1
    beq lab_a1bf            ;a1b5  f0 08
    lda [mem_001f],y        ;a1b7  b1 1f
    jsr sub_a306_ciout      ;a1b9  20 06 a3     Send a byte to IEC or IEEE
    iny                     ;a1bc  c8
    bne lab_a1b3            ;a1bd  d0 f4

lab_a1bf:
    jsr sub_a85a_cmp_comma  ;a1bf  20 5a a8     Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;a1c2  c9 3b        Is byte at txtptr+0 a semicolon?
    bne lab_a1ce_not        ;a1c4  d0 08
    ;Got a semicolon
    jsr chrget              ;a1c6  20 70 00
    beq lab_a1dd_done       ;a1c9  f0 12
    jmp lab_a19f_semi       ;a1cb  4c 9f a1

;Not a semicolon or comma
lab_a1ce_not:
    lda #0x0d               ;a1ce  a9 0d
    jsr sub_a306_ciout      ;a1d0  20 06 a3   Send a byte to IEC or IEEE
    bit mem_03ff            ;a1d3  2c ff 03   Bit with copy of current IEC device number
    bpl lab_a1dd_done       ;a1d6  10 05
    lda #0x0a               ;a1d8  a9 0a
    jsr sub_a306_ciout      ;a1da  20 06 a3   Send a byte to IEC or IEEE

lab_a1dd_done:
    jmp sub_a32a_unlsn      ;a1dd  4c 2a a3   Send UNLISTEN to IEC or IEEE

lab_a1e0_cmd_get:
    jsr sub_a8a8_parse_sa_1 ;a1e0  20 a8 a8   Parse integer into SA with leading # sign, or Syntax Error
    jsr iscoma              ;a1e3  20 f5 be   BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    lda mem_03ff            ;a1e6  ad ff 03   A = copy of current IEC device number
    and #0x7f               ;a1e9  29 7f
    sta mem_0010            ;a1eb  85 10
    jsr sub_a31f_talk       ;a1ed  20 1f a3   Send TALK to IEC or IEEE
    lda sa                  ;a1f0  a5 d3      A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;a1f2  20 40 a3   Send secondary address to IEC or IEEE for TALK or LISTEN
    ldx #0x01               ;a1f5  a2 01
    ldy #0x02               ;a1f7  a0 02
    lda #0x00               ;a1f9  a9 00
    sta mem_0200+1          ;a1fb  8d 01 02
    lda #0x40               ;a1fe  a9 40
    jmp lab_a245            ;a200  4c 45 a2

sub_a203:
    ldx #0x00               ;a203  a2 00

lab_a205_loop:
    jsr sub_a141_acptr      ;a205  20 41 a1
    cmp #0x0d               ;a208  c9 0d
    beq lab_a21c            ;a20a  f0 10
    sta mem_0200,x          ;a20c  9d 00 02
    inx                     ;a20f  e8
    cpx #0x51               ;a210  e0 51
    bne lab_a205_loop       ;a212  d0 f1
    jsr sub_a335_untlk      ;a214  20 35 a3     Send UNTALK to IEC or IEEE
    ldx #0xb0               ;a217  a2 b0        0xB0 = ?string too long error
    jmp error               ;a219  4c cf b3

lab_a21c:
    lda #0x00               ;a21c  a9 00
    sta mem_0200,x          ;a21e  9d 00 02
    ldx #0xff               ;a221  a2 ff
    ldy #0x01               ;a223  a0 01
    rts                     ;a225  60

lab_a226_cmd_input:
    jsr sub_a8ad_parse_sa_2 ;a226  20 ad a8   Parse integer into SA without leading #, or Syntax Error
    jsr iscoma              ;a229  20 f5 be   BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a31f_talk       ;a22c  20 1f a3   Send TALK to IEC or IEEE
    lda sa                  ;a22f  a5 d3      A = KERNAL current secondary address
    jsr sub_a340_lstksa     ;a231  20 40 a3   Send secondary address to IEC or IEEE for TALK or LISTEN
    lda mem_03ff            ;a234  ad ff 03   A = copy of current IEC device number
    and #0x7f               ;a237  29 7f
    sta mem_0010            ;a239  85 10
    lda #0x2c               ;a23b  a9 2c
    sta mem_01ff            ;a23d  8d ff 01
    jsr sub_a203            ;a240  20 03 a2
    lda #0x00               ;a243  a9 00

lab_a245:
    sta mem_000b            ;a245  85 0b
    stx inpptr              ;a247  86 40      INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1            ;a249  84 41

lab_a24b_input_loop:
    jsr ptrget              ;a24b  20 2b c1
    sta forptr              ;a24e  85 46      Pointer: Index Variable for FOR/NEXT
    sty forptr+1            ;a250  84 47
    lda txtptr              ;a252  a5 77
    ldy txtptr+1            ;a254  a4 78
    sta tmpptr              ;a256  85 48      Pointer: Various temporary storage uses
    sty tmpptr+1            ;a258  84 49
    ldx inpptr              ;a25a  a6 40      INPUT, READ, and GET vector to save CHRGET
    ldy inpptr+1            ;a25c  a4 41
    stx txtptr              ;a25e  86 77
    sty txtptr+1            ;a260  84 78
    jsr chrgot              ;a262  20 76 00   Subroutine: Get the Same Byte of BASIC Text again
    bne lab_a285            ;a265  d0 1e
    bit mem_000b            ;a267  24 0b
    bvc lab_a277            ;a269  50 0c
    jsr sub_a141_acptr      ;a26b  20 41 a1
    sta mem_0200            ;a26e  8d 00 02
    ldx #0xff               ;a271  a2 ff
    ldy #0x01               ;a273  a0 01
    bne lab_a281            ;a275  d0 0a      Branch always

lab_a277:
    lda mem_0010            ;a277  a5 10
    bne lab_a27e            ;a279  d0 03
    jsr defdev              ;a27b  20 44 bb

lab_a27e:
    jsr sub_a203            ;a27e  20 03 a2

lab_a281:
    stx txtptr              ;a281  86 77
    sty txtptr+1            ;a283  84 78

lab_a285:
    jsr chrget              ;a285  20 70 00
    bit valtyp              ;a288  24 07
    bpl lab_a2bd            ;a28a  10 31
    bit mem_000b            ;a28c  24 0b
    bvc lab_a299            ;a28e  50 09
    inx                     ;a290  e8
    stx txtptr              ;a291  86 77
    lda #0x00               ;a293  a9 00
    sta mem_0003            ;a295  85 03
    beq lab_a2a5            ;a297  f0 0c

lab_a299:
    sta mem_0003            ;a299  85 03
    cmp #'"                 ;a29b  c9 22
    beq lab_a2a6            ;a29d  f0 07
    lda #0x3a               ;a29f  a9 3a
    sta mem_0003            ;a2a1  85 03
    lda #',                 ;a2a3  a9 2c

lab_a2a5:
    clc                     ;a2a5  18

lab_a2a6:
    sta mem_0004            ;a2a6  85 04
    lda txtptr              ;a2a8  a5 77
    ldy txtptr+1            ;a2aa  a4 78
    adc #0x00               ;a2ac  69 00
    bcc lab_a2b1            ;a2ae  90 01
    iny                     ;a2b0  c8

lab_a2b1:
    jsr list+1              ;a2b1  20 b6 c5   Jump into BASIC Perform LIST mid-instruction
    jsr wtxtptr             ;a2b4  20 18 c9   BASIC Copy FBUFPT (0x006E) to TXTPTR (0x0077)
    jsr sub_b965            ;a2b7  20 65 b9
    jmp lab_a2c5            ;a2ba  4c c5 a2

lab_a2bd:
    jsr fin                 ;a2bd  20 29 ce   BASIC Convert an ASCII string into a numeral in FPAcc #1
    lda intflag             ;a2c0  a5 08
    jsr sub_b94d            ;a2c2  20 4d b9

lab_a2c5:
    jsr chrgot              ;a2c5  20 76 00   Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2d1            ;a2c8  f0 07
    cmp #',                 ;a2ca  c9 2c
    beq lab_a2d1            ;a2cc  f0 03
    jmp lab_bb4c            ;a2ce  4c 4c bb

lab_a2d1:
    lda txtptr              ;a2d1  a5 77
    ldy txtptr+1            ;a2d3  a4 78
    sta inpptr              ;a2d5  85 40      INPUT, READ, and GET vector to save CHRGET
    sty inpptr+1            ;a2d7  84 41
    lda tmpptr              ;a2d9  a5 48      Pointer: Various temporary storage uses
    ldy tmpptr+1            ;a2db  a4 49
    sta txtptr              ;a2dd  85 77
    sty txtptr+1            ;a2df  84 78
    jsr chrgot              ;a2e1  20 76 00   Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a2ec            ;a2e4  f0 06
    jsr iscoma              ;a2e6  20 f5 be   BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jmp lab_a24b_input_loop ;a2e9  4c 4b a2

lab_a2ec:
    jsr sub_bcda            ;a2ec  20 da bc
    jsr sub_a335_untlk      ;a2ef  20 35 a3   Send UNTALK to IEC or IEEE
    lda #0x00               ;a2f2  a9 00
    sta mem_0010            ;a2f4  85 10
    rts                     ;a2f6  60

copyright:                  ;a2f7
    .ascii "(C) G MUTZ (84)"


;Send a byte to IEC or IEEE
sub_a306_ciout:
    pha                     ;a306  48
    jsr sub_a8a0_cmp_fa     ;a307  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a310_not_iec    ;a30a  d0 04
    pla                     ;a30c  68
    jmp sub_a4d2_ciout      ;a30d  4c d2 a4   Send a byte to IEC

lab_a310_not_iec:
    pla                     ;a310  68
    jmp ciout               ;a311  4c 9e f1   Send a byte on IEEE


;Send LISTEN to IEC or IEEE
sub_a314_listen:
    jsr sub_a8a0_cmp_fa     ;a314  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a31c_not_iec    ;a317  d0 03
    jmp sub_a3f2_listen     ;a319  4c f2 a3   Send LISTEN to IEC

lab_a31c_not_iec:
    jmp listen              ;a31c  4c d5 f0   KERNAL Send LISTEN to IEEE


sub_a31f_talk:
    jsr sub_a8a0_cmp_fa     ;a31f  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a327_not_iec    ;a322  d0 03
    jmp sub_a3ef_talk       ;a324  4c ef a3   Send TALK to IEC

lab_a327_not_iec:
    jmp talk                ;a327  4c d2 f0   KERNAL Send TALK to IEEE


;Send UNLISTEN to IEC or IEEE
sub_a32a_unlsn:
    jsr sub_a8a0_cmp_fa     ;a32a  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a332_not_iec    ;a32d  d0 03
    jmp sub_a4ef_unlsn      ;a32f  4c ee a4   Send UNLISTEN to IEC

lab_a332_not_iec:
    jmp unlsn               ;a332  4c b9 f1   KERNAL Send UNLISTEN to IEEE


;Send UNTALK to IEC or IEEE
sub_a335_untlk:
    jsr sub_a8a0_cmp_fa     ;a335  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a33d_not_iec    ;a338  d0 03
    jmp sub_a4e4_untlk      ;a33a  4c e4 a4   Send UNTALK to IEC

lab_a33d_not_iec:
    jmp untlk               ;a33d  4c ae f1   KERNAL Send UNTALK to IEEE


;Send secondary address to IEC or IEEE for TALK or LISTEN
sub_a340_lstksa:
    bit mem_87d0            ;a340  2c d0 87
    bvs lab_a353_tksa       ;a343  70 0e      Send secondary address to IEC or IEEE for TALK


;Send secondary address to IEC or IEC for LISTEN
lab_a345_second:
    pha                     ;a345  48
    jsr sub_a8a0_cmp_fa     ;a346  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a34f_not_iec    ;a349  d0 04
    pla                     ;a34b  68
    jmp sub_a49c_secnd     ;a34c  4c 9c a4   Send secondary address to IEC for LISTEN

lab_a34f_not_iec:
    pla                     ;a34f  68
    jmp second              ;a350  4c 43 f1   KERNAL Send Secondary Address to IEEE


;Send secondary address to IEC or IEEE for TALK
lab_a353_tksa:
    pha                     ;a353  48
    jsr sub_a8a0_cmp_fa     ;a354  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a35d_not_iec    ;a357  d0 04
    pla                     ;a359  68
    jmp sub_a4bc_tksa       ;a35a  4c bc a4   Send secondary address to an IEC device commanded to talk

lab_a35d_not_iec:
    pla                     ;a35d  68
    jmp second              ;a35e  4c 43 f1   KERNAL Send Secondary Address to IEEE


;Assert ATN on IEC or IEEE
lab_a361_atnon:
    jsr sub_a8a0_cmp_fa     ;a361  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a369_not_iec    ;a364  d0 03
    jmp sub_a4aa_atnon      ;a366  4c aa a4   Assert ATN (turns bit 3 of VIA PORT A on)

lab_a369_not_iec:
    jmp sub_a4b3_ieee_aton  ;a369  4c b3 a4   Assert ATN on IEEE (turns bit 2 of VIA PORT B off)


;Release ATN on IEC or IEEE
lab_a36c_scatn:
    jsr sub_a8a0_cmp_fa     ;a36c  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a374_not_iec    ;a36f  d0 03
    jmp sub_a4a1_scatn      ;a371  4c a1 a4   Release ATN on IEC

lab_a374_not_iec:
    jmp scatn               ;a374  4c 48 f1   Release ATN on IEEE


ep_a377_isour:
    jsr sub_a8a0_cmp_fa     ;a377  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a37f_not_iec    ;a37a  d0 03
    jmp sub_a423_isour      ;a37c  4c 23 a4   Send last byte to IEC

lab_a37f_not_iec:
    jmp isour               ;a37f  4c 09 f1   KERNAL Send last byte to IEEE


ep_a382_untorl:
    pha                     ;a382  48
    jsr sub_a8a0_cmp_fa     ;a383  20 a0 a8   Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
    bne lab_a38c_not_iec    ;a386  d0 04
    pla                     ;a388  68
    jmp lab_a3f4            ;a389  4c f4 a3

lab_a38c_not_iec:
    pla                     ;a38c  68
    jmp untorl              ;a38d  4c d7 f0   KERNAL Send UNTALK or UNLISTEN to IEEE


;Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
sub_a390_setup:
    lda #0x3f               ;a390  a9 3f
    sta via_ddrb            ;a392  8d 43 e8
    lda #0x00               ;a395  a9 00
    sta via_timer_2_lo      ;a397  8d 48 e8
    sta via_timer_2_hi      ;a39a  8d 49 e8
    sta via_acr             ;a39d  8d 4b e8
    lda #0x2c               ;a3a0  a9 2c
    sta tapwct              ;a3a2  85 ba
    lda #0x17               ;a3a4  a9 17
    sta via_port_a          ;a3a6  8d 41 e8
    lda #0x80               ;a3a9  a9 80
    sta mem_00fd_r2d2            ;a3ab  85 fd

;Set FA = copy of current IEC device num, set KERNAL STATUS = 0
sub_a3ad_set_fa_st:
    lda mem_03ff            ;a3ad  ad ff 03     A = copy of current IEC device number
    and #0x7f               ;a3b0  29 7f
    sta fa                  ;a3b2  85 d4        Set KERNAL current device number
    lda #0x00               ;a3b4  a9 00
    sta status              ;a3b6  85 96        KERNAL STATUS = 0 (no error)
    rts                     ;a3b8  60

;Set clock line low (inverted)
sub_a3b9_clklo:
    lda via_port_a          ;a3b9  ad 41 e8
    ora #0b00010000         ;a3bc  09 10
    sta via_port_a          ;a3be  8d 41 e8
    rts                     ;a3c1  60

;Set clock line high (inverted)
sub_a3c2_clkhi:
    lda via_port_a          ;a3c2  ad 41 e8
    and #0b11101111         ;a3c5  29 ef
    sta via_port_a          ;a3c7  8d 41 e8
    rts                     ;a3ca  60

;Set data line high (inverted)
sub_a3cb_datahi:
    lda via_port_a          ;a3cb  ad 41 e8
    and #0b11011111         ;a3ce  29 df
    sta via_port_a          ;a3d0  8d 41 e8
    rts                     ;a3d3  60

;Set data line low (inverted)
sub_a3d4_datalo:
    lda via_port_a          ;a3d4  ad 41 e8
    ora #0b00100000         ;a3d7  09 20
    sta via_port_a          ;a3d9  8d 41 e8
    rts                     ;a3dc  60

;Debounce VIA PA then ASL A
sub_a3dd_debvia:
    lda via_port_a          ;a3dd  ad 41 e8
    cmp via_port_a          ;a3e0  cd 41 e8
    bne sub_a3dd_debvia     ;a3e3  d0 f8      Debounce VIA PA then ASL A
    asl a                   ;a3e5  0a
    rts                     ;a3e6  60

;Delay loop
sub_a3e7_delay:
    txa                     ;a3e7  8a
    ldx #0xc0               ;a3e8  a2 c0
lab_a3ea_loop:
    dex                     ;a3ea  ca
    bne lab_a3ea_loop       ;a3eb  d0 fd
    tax                     ;a3ed  aa
    rts                     ;a3ee  60

;Send TALK to IEC
sub_a3ef_talk:
    lda #0x40               ;a3ef  a9 40      A = 0x40 (TALK)
    bit 0x20a9              ;a3f1  2c a9 20   sub_a3f2_listen jumps here mid-instruction

;Send LISTEN to IEC
sub_a3f2_listen = (. - 2)
   ;lda #0x20               ;a3f1  __ a9 20   A = 0x20 (LISTEN)

lab_a3f4:
    sta mem_87d0            ;a3f4  8d d0 87

sub_a3f7_list1:
    ora fa                  ;a3f7  05 d4
    pha                     ;a3f9  48
    bit mem_00a0_c3p0       ;a3fa  24 a0
    bpl lab_a408_list2      ;a3fc  10 0a
    sec                     ;a3fe  38
    ror mem_00fd_r2d2       ;a3ff  66 fd
    jsr sub_a423_isour      ;a401  20 23 a4
    lsr mem_00a0_c3p0       ;a404  46 a0
    lsr mem_00fd_r2d2       ;a406  46 fd

lab_a408_list2:
    pla                     ;a408  68
    sta bsour               ;a409  85 a5      IEEE byte buffer for output (FF means no character)
    sei                     ;a40b  78
    jsr sub_a3cb_datahi     ;a40c  20 cb a3   Set data line high (inverted)
    cmp #0x3f               ;a40f  c9 3f
    bne lab_a416            ;a411  d0 03
    jsr sub_a3c2_clkhi      ;a413  20 c2 a3   Set clock line high (inverted)

lab_a416:
    jsr sub_a4aa_atnon      ;a416  20 aa a4   Assert ATN (turns bit 3 of VIA PORT A on)

sub_a419_isoura:
    sei                     ;a419  78
    jsr sub_a3b9_clklo      ;a41a  20 b9 a3   Set clock line low (inverted)
    jsr sub_a3cb_datahi     ;a41d  20 cb a3   Set data line high (inverted)
    jsr sub_a3e7_delay      ;a420  20 e7 a3   Delay loop

sub_a423_isour:
    sei                     ;a423  78
    jsr sub_a3cb_datahi     ;a424  20 cb a3   Set data line high (inverted)
    jsr sub_a3dd_debvia     ;a427  20 dd a3   Debounce VIA PA then ASL A
    bcs lab_a490_nodev      ;a42a  b0 64      Branch to device not present error
    jsr sub_a3c2_clkhi      ;a42c  20 c2 a3   Set clock line high (inverted)
    bit mem_00fd_r2d2       ;a42f  24 fd
    bpl lab_a43d_noeoi      ;a431  10 0a

lab_a433_isr02:
    jsr sub_a3dd_debvia     ;a433  20 dd a3   Debounce VIA PA then ASL A
    bcc lab_a433_isr02      ;a436  90 fb

lab_a438_isr03:
    jsr sub_a3dd_debvia     ;a438  20 dd a3   Debounce VIA PA then ASL A
    bcs lab_a438_isr03      ;a43b  b0 fb

lab_a43d_noeoi:
    jsr sub_a3dd_debvia     ;a43d  20 dd a3   Debounce VIA PA then ASL A
    bcc lab_a43d_noeoi      ;a440  90 fb
    jsr sub_a3b9_clklo      ;a442  20 b9 a3   Set clock line low (inverted)
    lda #0x08               ;a445  a9 08
    sta mem_00ff_count            ;a447  85 ff

lab_a449_isr01:
    lda via_port_a          ;a449  ad 41 e8
    cmp via_port_a          ;a44c  cd 41 e8
    bne lab_a449_isr01      ;a44f  d0 f8
    asl a                   ;a451  0a
    bcc lab_a493_frmerr     ;a452  90 3f    XXX C64 KERNAL says frame error
    ror bsour               ;a454  66 a5      IEEE byte buffer for output (FF means no character)
    bcs lab_a45d_isrhi      ;a456  b0 05
    jsr sub_a3d4_datalo     ;a458  20 d4 a3   Set data line low (inverted)
    bne lab_a460            ;a45b  d0 03

lab_a45d_isrhi:
    jsr sub_a3cb_datahi     ;a45d  20 cb a3   Set data line high (inverted)

lab_a460:
    jsr sub_a3c2_clkhi      ;a460  20 c2 a3   Set clock line high (inverted)
    nop                     ;a463  ea
    nop                     ;a464  ea
    nop                     ;a465  ea
    nop                     ;a466  ea
    lda via_port_a          ;a467  ad 41 e8
    and #0xdf               ;a46a  29 df
    ora #0x10               ;a46c  09 10
    sta via_port_a          ;a46e  8d 41 e8
    dec mem_00ff_count      ;a471  c6 ff
    bne lab_a449_isr01      ;a473  d0 d4
    lda #0x00               ;a475  a9 00
    sta via_timer_2_lo      ;a477  8d 48 e8
    lda #0x04               ;a47a  a9 04
    sta via_timer_2_hi      ;a47c  8d 49 e8
    lda via_ifr             ;a47f  ad 4d e8

lab_a482_isr04:
    lda via_ifr             ;a482  ad 4d e8
    and #0x20               ;a485  29 20      XXX does not match C64 KERNAL
    bne lab_a493_frmerr     ;a487  d0 0a      Branch to write timeout error
    jsr sub_a3dd_debvia     ;a489  20 dd a3   Debounce VIA PA then ASL A
    bcs lab_a482_isr04      ;a48c  b0 f4
    cli                     ;a48e  58
    rts                     ;a48f  60

lab_a490_nodev:
    lda #0b10000000         ;a490  a9 80      A = status bit for device not present error
    bit 0x03a9              ;a492  2c a9 03   lab_a449_isr01, lab_a482_isr04 jump here mid-instruction
lab_a493_frmerr = (. - 2)
   ;lda #0b00000011         ;a492  __ a9 03   A = status bits for timeout while writing XXX

lab_a495_csberr:
    jsr sub_a580_st_or_a    ;a495  20 80 a5   KERNAL STATUS = STATUS | A
    cli                     ;a498  58
    clc                     ;a499  18
    bcc lab_a4f3_dlabye            ;a49a  90 57      Branch always

;Send secondary address to IEC for LISTEN
sub_a49c_secnd:
    sta bsour               ;a49c  85 a5
    jsr sub_a419_isoura     ;a49e  20 19 a4

;Release ATN
sub_a4a1_scatn:
    lda via_port_a          ;a4a1  ad 41 e8
    and #0b11110111         ;a4a4  29 f7
    sta via_port_a          ;a4a6  8d 41 e8
    rts                     ;a4a9  60

;Assert ATN
;Note: this routine does not exist in the C64 KERNAL
;Turn bit 3 of VIA PORT A on (ATN out)
sub_a4aa_atnon:
    lda via_port_a          ;a4aa  ad 41 e8
    ora #0b00001000         ;a4ad  09 08
    sta via_port_a          ;a4af  8d 41 e8
    rts                     ;a4b2  60

;Assert ATN on IEEE (turns bit 2 of VIA PORT B off)
sub_a4b3_ieee_aton:
    lda via_portb           ;a4b3  ad 40 e8   Note: IEEE-488, not IEC!
    and #0b11111011         ;a4b6  29 fb
    sta via_portb           ;a4b8  8d 40 e8
    rts                     ;a4bb  60

;Send secondary address to an IEC device commanded to talk
sub_a4bc_tksa:
    sta bsour               ;a4bc  85 a5
    jsr sub_a419_isoura     ;a4be  20 19 a4
    sei                     ;a4c1  78
    jsr sub_a3d4_datalo     ;a4c2  20 d4 a3   Set data line low (inverted)
    jsr sub_a4a1_scatn      ;a4c5  20 a1 a4   Release ATN
    jsr sub_a3c2_clkhi      ;a4c8  20 c2 a3   Set clock line high (inverted)

lab_a4cb_tkatn1:
    jsr sub_a3dd_debvia     ;a4cb  20 dd a3   Debounce VIA PA then ASL A
    bmi lab_a4cb_tkatn1     ;a4ce  30 fb
    cli                     ;a4d0  58
    rts                     ;a4d1  60

;Send a byte to IEC
;Buffered output to IEC
sub_a4d2_ciout:
    bit mem_00a0_c3p0       ;a4d2  24 a0
    bmi lab_a4db_ci2        ;a4d4  30 05
    sec                     ;a4d6  38
    ror mem_00a0_c3p0       ;a4d7  66 a0
    bne lab_a4e0_ci4        ;a4d9  d0 05

lab_a4db_ci2:
    pha                     ;a4db  48
    jsr sub_a423_isour      ;a4dc  20 23 a4
    pla                     ;a4df  68

lab_a4e0_ci4:
    sta bsour               ;a4e0  85 a5
    clc                     ;a4e2  18
    rts                     ;a4e3  60

;Send UNTALK to IEC
sub_a4e4_untlk:
    sei                     ;a4e4  78
    jsr sub_a3b9_clklo      ;a4e5  20 b9 a3   Set clock line low (inverted)
    jsr sub_a4aa_atnon      ;a4e8  20 aa a4   Assert ATN (turns bit 3 of VIA PORT A on)
    lda #0x5f               ;a4eb  a9 5f      A = 0x5F (UNTALK)
    bit 0x3fa9              ;a4ed  2c a9 3f   some routines jump here mid-instruction

;Send UNLISTEN to IEC
sub_a4ef_unlsn = (. - 2)
   ;lda #0x3f               ;a4ed  __ a9 ef   A = 0x3F (UNLISTEN)
    jsr sub_a3f7_list1      ;a4f0  20 f7 a3

lab_a4f3_dlabye:
    jsr sub_a4a1_scatn      ;a4f3  20 a1 a4   Release ATN

sub_a4f6_dladlh:
    txa                     ;a4f6  8a
    ldx #0x0a               ;a4f7  a2 0a

lab_a4f9_dlad00:
    dex                     ;a4f9  ca
    bne lab_a4f9_dlad00     ;a4fa  d0 fd
    tax                     ;a4fc  aa
    jsr sub_a3c2_clkhi      ;a4fd  20 c2 a3   Set clock line high (inverted)
    lda #0x00               ;a500  a9 00
    sta mem_00a0_c3p0       ;a502  85 a0
    jmp sub_a3cb_datahi     ;a504  4c cb a3   Set data line high (inverted)

;Read a byte from IEC with initial status check
;This is different from the C64 KERNAL
sub_a507_acptrs:
    lda status              ;a507  a5 96
    beq sub_a50e_acptr      ;a509  f0 03
    lda #0x0d               ;a50b  a9 0d
    rts                     ;a50d  60

;Read a byte from IEC
;This is from the C64 KERNAL
sub_a50e_acptr:
    sei                     ;a50e  78
    lda #0x00               ;a50f  a9 00
    sta mem_00ff_count      ;a511  85 ff
    jsr sub_a3c2_clkhi      ;a513  20 c2 a3   Set clock line high (inverted)

lab_a516:
    jsr sub_a3dd_debvia     ;a516  20 dd a3   Debounce VIA PA then ASL A
    bpl lab_a516            ;a519  10 fb

lab_a51b:
    lda #0x00               ;a51b  a9 00
    sta via_timer_2_lo      ;a51d  8d 48 e8
    lda #0x01               ;a520  a9 01
    sta via_timer_2_hi      ;a522  8d 49 e8
    jsr sub_a3cb_datahi     ;a525  20 cb a3   Set data line high (inverted)
    lda via_ifr             ;a528  ad 4d e8

lab_a52b:
    lda via_ifr             ;a52b  ad 4d e8
    and #0x20               ;a52e  29 20
    bne lab_a539            ;a530  d0 07
    jsr sub_a3dd_debvia     ;a532  20 dd a3   Debounce VIA PA then ASL A
    bmi lab_a52b            ;a535  30 f4
    bpl lab_a551            ;a537  10 18

lab_a539:
    lda mem_00ff_count            ;a539  a5 ff
    beq lab_a542            ;a53b  f0 05
    lda #0b00000010         ;a53d  a9 02      A = status bit for timeout error
    jmp lab_a495_csberr      ;a53f  4c 95 a4

lab_a542:
    jsr sub_a3d4_datalo     ;a542  20 d4 a3   Set data line low (inverted)
    jsr sub_a3c2_clkhi      ;a545  20 c2 a3   Set clock line high (inverted)
    lda #0b01000000         ;a548  a9 40      A = status bit for End of File (EOF)
    jsr sub_a580_st_or_a    ;a54a  20 80 a5   KERNAL STATUS = STATUS | A
    inc mem_00ff_count            ;a54d  e6 ff
    bne lab_a51b            ;a54f  d0 ca

lab_a551:
    lda #0x08               ;a551  a9 08
    sta mem_00ff_count            ;a553  85 ff

lab_a555:
    lda via_port_a          ;a555  ad 41 e8
    cmp via_port_a          ;a558  cd 41 e8
    bne lab_a555            ;a55b  d0 f8
    asl a                   ;a55d  0a
    bpl lab_a555            ;a55e  10 f5
    ror mem_00fe            ;a560  66 fe

lab_a562:
    lda via_port_a          ;a562  ad 41 e8
    cmp via_port_a          ;a565  cd 41 e8
    bne lab_a562            ;a568  d0 f8
    asl a                   ;a56a  0a
    bmi lab_a562            ;a56b  30 f5
    dec mem_00ff_count            ;a56d  c6 ff
    bne lab_a555            ;a56f  d0 e4
    jsr sub_a3d4_datalo     ;a571  20 d4 a3   Set data line low (inverted)
    bit status              ;a574  24 96
    bvc lab_a57b            ;a576  50 03
    jsr sub_a4f6_dladlh            ;a578  20 f6 a4

lab_a57b:
    lda mem_00fe            ;a57b  a5 fe
    cli                     ;a57d  58
    clc                     ;a57e  18
    rts                     ;a57f  60

;KERNAL STATUS = STATUS or A
sub_a580_st_or_a:
    ora status              ;a580  05 96
    sta status              ;a582  85 96
    rts                     ;a584  60

lab_a585:
    rts                     ;a585  60

;!@ DOS Wedge Command
lab_a586_cmd_dos:
    jsr sub_a390_setup      ;a586  20 90 a3     Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    jsr chrgot              ;a589  20 76 00     Subroutine: Get the Same Byte of BASIC Text again
    bne lab_a591_more       ;a58c  d0 03

    ;Nothing after @ so jump to print device status
    jmp sub_a83c_status     ;a58e  4c 3c a8     Query the device's status and print it

    ;Something after the @
lab_a591_more:
    cmp #'U                 ;a591  c9 55
    bne lab_a5c2_not_u      ;a593  d0 2d
    ;Character = "U"
    jsr chrget              ;a595  20 70 00
    jsr gtbytc+3            ;a598  20 d4 c8     BASIC Evaluate integer 0-255, return it in X
    txa                     ;a59b  8a           A = evaluated integer after the "U"

    ldx #0x53               ;a59c  a2 53
    ldy #0x03               ;a59e  a0 03
    stx mem_001f            ;a5a0  86 1f
    sty mem_001f+1          ;a5a2  84 20

    ldy #mem_a834_m_w_len   ;a5a4  a0 08        Y = 8 (length of command to change drive's device number)
    sty fnlen               ;a5a6  84 d1

    dey                     ;a5a8  88           Now Y = 7
    and #0x0f               ;a5a9  29 0f        A = Force device number in range 0-15
    sta mem_03ff            ;a5ab  8d ff 03     Store as copy of current IEC device number

    ;A = new device number and is in range 0-15

    ;Write TALK byte into M-W command in buffer mem_001f
    ora #0x40               ;a5ae  09 40        Turn on bit 6
    sta [mem_001f],y        ;a5b0  91 1f        Store A in mem_001f+7
                            ;                     0x0078: IEC bus TALK command to accept. (Device number OR $40)

    ;Write LISTEN byte into M-W command in buffer mem_001f
    eor #0x60               ;a5b2  49 60        Turn on bits 7 and 6
    dey                     ;a5b4  88           Now Y = 6
    sta [mem_001f],y        ;a5b5  91 1f        Store A in mem_001f+6
                            ;                     0x0077: IEC bus LISTEN command to accept. (Device number OR $20))

    dey                     ;a5b7  88           Now Y = 5

    ;Write the rest of the M_W command into buffer mem_001f
lab_a5b8_loop:
    lda mem_a834_m_w,y      ;a5b8  b9 34 a8     A = command to change drive's device number
    sta [mem_001f],y        ;a5bb  91 1f
    dey                     ;a5bd  88
    bpl lab_a5b8_loop       ;a5be  10 f8

    ;Buffer at mem_001f now contains command to change the drive's
    ;current device number; branch to send it
    bmi lab_a5ca_send_dos_cmd ;a5c0  30 08        Branch always

lab_a5c2_not_u:
    jsr frmevl              ;a5c2  20 98 bd     BASIC Input and evaluate any expression
    jsr freestr             ;a5c5  20 b5 c7     BASIC Discard temporary string
    sta fnlen               ;a5c8  85 d1

;Send DOS command in buffer mem_001f
lab_a5ca_send_dos_cmd:
    lda #0x00               ;a5ca  a9 00
    sta status              ;a5cc  85 96        KERNAL STATUS = 0 (no error)
    jsr sub_a3f2_listen     ;a5ce  20 f2 a3     Send LISTEN to IEC
    lda #0x6f               ;a5d1  a9 6f
    jsr sub_a49c_secnd     ;a5d3  20 9c a4     Send secondary address to IEC for LISTEN
    ldy #0x00               ;a5d6  a0 00

lab_a5d8:
    lda [mem_001f],y        ;a5d8  b1 1f
    jsr sub_a4d2_ciout      ;a5da  20 d2 a4     Send a byte to IEC
    iny                     ;a5dd  c8
    cpy fnlen               ;a5de  c4 d1
    bne lab_a5d8            ;a5e0  d0 f6
    jmp sub_a4ef_unlsn      ;a5e2  4c ee a4     Send UNLISTEN to IEC

lab_a5e5_cmd_save:
    jsr sub_a5eb_save       ;a5e5  20 eb a5
    jmp sub_a83c_status     ;a5e8  4c 3c a8     Query the device's status and print it

sub_a5eb_save:
    jsr sub_a390_setup      ;a5eb  20 90 a3     Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    jsr sub_a7b6_eval_fname ;a5ee  20 b6 a7     Evaluate expression as filename; set up FNLEN and FNADR
    lda #(1 | 0x60)         ;a5f1  a9 61        A = secondary address 1 (SAVE) | 0x60
    sta sa                  ;a5f3  85 d3        Set SA (KERNAL current secondary address)
    ldy fnlen               ;a5f5  a4 d1
    bne lab_a5fc            ;a5f7  d0 03
    jmp syntax              ;a5f9  4c 00 bf     BASIC ?SYNTAX ERROR

lab_a5fc:
    jsr sub_a689_open       ;a5fc  20 89 a6     Send OPEN to IEC
    jsr sub_a85a_cmp_comma  ;a5ff  20 5a a8     Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a623_no_addr    ;a602  d0 1f        Branch if it's not a command
    ;Found comma
    jsr chrget              ;a604  20 70 00     Consume comma
    ;Parse start address for SAVE into salptr
    jsr sub_a861            ;a607  20 61 a8     Evals expression, calls hexit 4 times, sets ml1ptr
    lda ml1ptr              ;a60a  a5 fb
    sta salptr              ;a60c  85 c9
    lda ml1ptr+1            ;a60e  a5 fc
    sta salptr+1            ;a610  85 ca
    ;Parse end address for SAVE into ealptr
    jsr iscoma              ;a612  20 f5 be     BASIC ?SYNTAX ERROR if CHRGET does not equal a comma
    jsr sub_a861            ;a615  20 61 a8     Evals expression, calls hexit 4 times, sets ml1ptr
    lda ml1ptr              ;a618  a5 fb
    sta ealptr              ;a61a  85 b7
    lda ml1ptr+1            ;a61c  a5 fc
    sta ealptr+1            ;a61e  85 b8
    jmp lab_a633_with_addr  ;a620  4c 33 a6

;No start/end address supplied with !SAVE command, so use BASIC program area
lab_a623_no_addr:
    ;Set start address for SAVE in salptr
    lda txttab              ;a623  a5 28
    sta salptr              ;a625  85 c9
    lda txttab+1            ;a627  a5 29
    sta salptr+1            ;a629  85 ca
    ;Set end address for SAVE in ealptr
    lda vartab              ;a62b  a5 2a
    sta ealptr              ;a62d  85 b7
    lda vartab+1            ;a62f  a5 2b
    sta ealptr+1            ;a631  85 b8
    ;Fall through

;Perform SAVE.  Start address in salptr, end address in ealptr
lab_a633_with_addr:
    jsr sub_a3f2_listen     ;a633  20 f2 a3     Send LISTEN to IEC
    lda sa                  ;a636  a5 d3        A = KERNAL current secondary address
    jsr sub_a49c_secnd      ;a638  20 9c a4     Send secondary address to IEC for LISTEN
    ldy #0x00               ;a63b  a0 00
    lda salptr              ;a63d  a5 c9
    jsr sub_a4d2_ciout      ;a63f  20 d2 a4     Send a byte to IEC
    lda salptr+1            ;a642  a5 ca
    jsr sub_a4d2_ciout      ;a644  20 d2 a4     Send a byte to IEC

lab_a647_loop:
    jsr sub_a672            ;a647  20 72 a6
    bcs lab_a65b_done       ;a64a  b0 0f
    lda [salptr],y          ;a64c  b1 c9
    jsr sub_a4d2_ciout      ;a64e  20 d2 a4     Send a byte to IEC

    jsr sub_a89a_chk_stop   ;a651  20 9a a8     STOP key pressed?  (Returns Z=1 if so.)
    beq lab_a65b_done       ;a654  f0 05          Yes: branch to done

    ;STOP key not pressed

    jsr sub_a682_inc_salptr ;a656  20 82 a6   Increment SALPTR
    bne lab_a647_loop       ;a659  d0 ec

lab_a65b_done:
    jsr sub_a4ef_unlsn      ;a65b  20 ee a4     Send UNLISTEN to IEC

;Send CLOSE to IEC
sub_a65e_close:
    bit sa                  ;a65e  24 d3
    bmi lab_a671_done       ;a660  30 0f
    jsr sub_a3f2_listen     ;a662  20 f2 a3     Send LISTEN to IEC
    lda sa                  ;a665  a5 d3        A = KERNAL current secondary address
    and #0xef               ;a667  29 ef
    ora #0xe0               ;a669  09 e0        OR with 0xE0 = CLOSE
    jsr sub_a49c_secnd     ;a66b  20 9c a4     Send secondary address to IEC for LISTEN
    jsr sub_a4ef_unlsn      ;a66e  20 ee a4     Send UNLISTEN to IEC

lab_a671_done:
    rts                     ;a671  60

sub_a672:
    lda salptr              ;a672  a5 c9
    cmp ealptr              ;a674  c5 b7
    bne lab_a680            ;a676  d0 08
    lda salptr+1            ;a678  a5 ca
    cmp ealptr+1            ;a67a  c5 b8
    bne lab_a680            ;a67c  d0 02
    sec                     ;a67e  38
    rts                     ;a67f  60

lab_a680:
    clc                     ;a680  18
    rts                     ;a681  60

;Increment SALPTR
sub_a682_inc_salptr:
    inc salptr              ;a682  e6 c9
    bne lab_a688            ;a684  d0 02
    inc salptr+1            ;a686  e6 ca

lab_a688:
    rts                     ;a688  60

;Send filename to IEC
sub_a689_open:
    lda sa                  ;a689  a5 d3      A = KERNAL current secondary address
    bpl lab_a68f            ;a68b  10 02

lab_a68d_error:
    clc                     ;a68d  18
    rts                     ;a68e  60

lab_a68f:
    ldy fnlen               ;a68f  a4 d1
    beq lab_a68d_error      ;a691  f0 fa
    lda #0x00               ;a693  a9 00
    sta status              ;a695  85 96      KERNAL STATUS = 0 (no error)
    jsr sub_a3f2_listen     ;a697  20 f2 a3   Send LISTEN to IEC
    lda sa                  ;a69a  a5 d3      A = KERNAL current secondary address
    ora #0xf0               ;a69c  09 f0      OR it with 0xF0 = OPEN
    jsr sub_a49c_secnd      ;a69e  20 9c a4   Send secondary address to IEC for LISTEN
    lda status              ;a6a1  a5 96      A = KERNAL status
    bpl lab_a6a8_present    ;a6a3  10 03      Branch if device not present error bit = 0
    ;device not present
    jmp nprsnt              ;a6a5  4c bb f4   KERNAL ?DEVICE NOT PRESENT ERROR

;device is present
lab_a6a8_present:
    ldy #0x00               ;a6a8  a0 00

lab_a6aa:
    lda [fnadr],y           ;a6aa  b1 da
    jsr sub_a4d2_ciout      ;a6ac  20 d2 a4   Send a byte to IEC
    iny                     ;a6af  c8
    cpy fnlen               ;a6b0  c4 d1
    bne lab_a6aa            ;a6b2  d0 f6
    jmp sub_a4ef_unlsn      ;a6b4  4c ee a4   Send UNLISTEN to IEC

;Called with A=0 for LOAD, A=0xFF for VERIFY
lab_a6b7_load_or_verify:
    jsr sub_a390_setup      ;a6b7  20 90 a3   Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    jsr sub_a85a_cmp_comma  ;a6ba  20 5a a8   Gets byte at txtptr+0 into A, compares it to a comma
    cmp #';                 ;a6bd  c9 3b      Is the byte at txtptr+0 a semicolon?
    bne lab_a6c6            ;a6bf  d0 05
    sta tapwct              ;a6c1  85 ba
    jsr chrget              ;a6c3  20 70 00

lab_a6c6:
    jsr sub_a6f6            ;a6c6  20 f6 a6
    jsr is7802              ;a6c9  20 51 f3   KERNAL Compare TXTPTR+1: LDA $78; CMP #$02; RTS
    bne lab_a6d1            ;a6cc  d0 03
    jsr sub_a83c_status     ;a6ce  20 3c a8   Query the device's status and print it

lab_a6d1:
    bit verchk              ;a6d1  24 9d      Bit KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bmi lab_a6f5_done       ;a6d3  30 20      Branch if to finish if perfoming VERIFY
                            ;                   (BMI works because we actually set verchk to 0xFF)
    ;Peforming LOAD
    jsr stop                ;a6d5  20 2b f9   KERNAL test STOP key and act if pressed
    ldy #0xae               ;a6d8  a0 ae      A = index to message "READY."
    jsr prmsg               ;a6da  20 49 f3   KERNAL Print a message from 0xF000 table at offset Y
    jsr is7802              ;a6dd  20 51 f3   KERNAL Compare TXTPTR+1: LDA $78; CMP #$02; RTS
    bne lab_a6e5            ;a6e0  d0 03
    jmp lab_b4ad            ;a6e2  4c ad b4

lab_a6e5:
    jsr rsgetc              ;a6e5  20 22 b6   BASIC Reset GETCHR to start of program
    jsr restor              ;a6e8  20 b7 b7   BASIC Perform RESTORE
    ldx #0x16               ;a6eb  a2 16
    stx mem_0013            ;a6ed  86 13
    lda #0x00               ;a6ef  a9 00
    sta mem_003b            ;a6f1  85 3b
    sta mem_000a            ;a6f3  85 0a

lab_a6f5_done:
    rts                     ;a6f5  60

sub_a6f6:
    jsr sub_a7b6_eval_fname ;a6f6  20 b6 a7   Evaluate expression as filename; set up FNLEN and FNADR
    ldy fnlen               ;a6f9  a4 d1
    bne lab_a6ff            ;a6fb  d0 02
    clc                     ;a6fd  18
    rts                     ;a6fe  60

lab_a6ff:
    jsr srchng              ;a6ff  20 49 f4   KERNAL Print SEARCHING if in direct mode
    lda #(0 | 0x60)         ;a702  a9 60      A = secondary address 0 (LOAD) | 0x60
    sta sa                  ;a704  85 d3      Set SA (KERNAL current secondary address)
    jsr sub_a689_open       ;a706  20 89 a6   Send OPEN to IEC
    jsr sub_a3ef_talk       ;a709  20 ef a3   Send TALK to IEC
    lda sa                  ;a70c  a5 d3      A = KERNAL current secondary address
    jsr sub_a4bc_tksa       ;a70e  20 bc a4   Send secondary address to an IEC device commanded to talk
    jsr sub_a507_acptrs     ;a711  20 07 a5   Read a byte from IEC with initial status check
    sta salptr              ;a714  85 c9
    lda status              ;a716  a5 96
    lsr a                   ;a718  4a
    lsr a                   ;a719  4a
    bcc lab_a71f            ;a71a  90 03
    jmp notfnd              ;a71c  4c ad f5   KERNAL ?FILE NOT FOUND ERROR

lab_a71f:
    jsr lodmsg              ;a71f  20 6d f4   KERNAL Print LOADING or VERIFYING if in direct mode
    jsr sub_a507_acptrs     ;a722  20 07 a5   Read a byte from IEC with initial status check
    sta salptr+1            ;a725  85 ca
    jsr sub_a85a_cmp_comma  ;a727  20 5a a8   Gets byte at txtptr+0 into A, compares it to a comma
    bne lab_a73e_not_comma  ;a72a  d0 12
    ;Got a comma
    jsr chrget              ;a72c  20 70 00
    jsr sub_a861            ;a72f  20 61 a8   Evals expression, calls hexit 4 times, sets ml1ptr
    lda ml1ptr              ;a732  a5 fb
    sta salptr              ;a734  85 c9
    lda ml1ptr+1            ;a736  a5 fc
    sta salptr+1            ;a738  85 ca
    lda #0x3b               ;a73a  a9 3b
    sta tapwct              ;a73c  85 ba

lab_a73e_not_comma:
    lda tapwct              ;a73e  a5 ba
    cmp #',                 ;a740  c9 2c
    bne lab_a750            ;a742  d0 0c
    lda verchk              ;a744  a5 9d      A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a750            ;a746  d0 08      Branch if perfoming VERIFY
    lda salptr              ;a748  a5 c9
    sta txttab              ;a74a  85 28
    lda salptr+1            ;a74c  a5 ca
    sta txttab+1            ;a74e  85 29

lab_a750:
    lda #0b11111101         ;a750  a9 fd      A = mask off status bit 1 (timeout error)
    and status              ;a752  25 96
    sta status              ;a754  85 96      Store STATUS with timeout error cleared

    jsr sub_a89a_chk_stop   ;a756  20 9a a8   STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a75e_more       ;a759  d0 03        No: branch to keep going

    ;STOP key pressed
    jmp sub_a65e_close      ;a75b  4c 5e a6   Send CLOSE to IEC

;STOP key not pressed
lab_a75e_more:
    jsr sub_a507_acptrs     ;a75e  20 07 a5   Read a byte from IEC with initial status check
    tax                     ;a761  aa
    lda status              ;a762  a5 96
    lsr a                   ;a764  4a
    lsr a                   ;a765  4a
    bcs lab_a750            ;a766  b0 e8
    txa                     ;a768  8a
    ldy verchk              ;a769  a4 9d      Y = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    beq lab_a794            ;a76b  f0 27      Branch if performing LOAD
    ;Performing VERIFY
    ldy #0x00               ;a76d  a0 00
    cmp [salptr],y          ;a76f  d1 c9
    beq lab_a796            ;a771  f0 23
    lda #0b00010000         ;a773  a9 10      A = status bit for VERIFY error
    jsr sub_a580_st_or_a    ;a775  20 80 a5   KERNAL STATUS = STATUS | A
    jsr sub_a4e4_untlk      ;a778  20 e4 a4   Send UNTALK to IEC
    jsr sub_a65e_close      ;a77b  20 5e a6   Send CLOSE to IEC
    jsr prcrlf              ;a77e  20 34 d5   BASIC Print carriage return and linefeed
    lda salptr              ;a781  a5 c9
    sta ml1ptr              ;a783  85 fb
    lda salptr+1            ;a785  a5 ca
    sta ml1ptr+1            ;a787  85 fc
    jsr sub_d717            ;a789  20 17 d7
    jsr sub_d52e            ;a78c  20 2e d5
    ldy #0x6e               ;a78f  a0 6e      Y = 0x6E (?VERIFY ERROR)
    jmp krnerr              ;a791  4c b7 f5   KERNAL ?<message> ERROR from KERNAL error in Y

lab_a794:
    sta [salptr],y          ;a794  91 c9

lab_a796:
    jsr sub_a682_inc_salptr ;a796  20 82 a6   Increment SALPTR
    bit status              ;a799  24 96
    bvc lab_a750            ;a79b  50 b3
    jsr sub_a4e4_untlk      ;a79d  20 e4 a4   Send UNTALK to IEC
    jsr sub_a65e_close      ;a7a0  20 5e a6   Send CLOSE to IEC
    lda tapwct              ;a7a3  a5 ba
    cmp #',                 ;a7a5  c9 2c
    bne lab_a7b5_done       ;a7a7  d0 0c
    lda verchk              ;a7a9  a5 9d      A = KERNAL Flag for LOAD or VERIFY: 0=LOAD, 1=VERIFY
    bne lab_a7b5_done       ;a7ab  d0 08      Branch if performing VERIFY
    ;Performing LOAD
    lda salptr              ;a7ad  a5 c9
    sta vartab              ;a7af  85 2a
    lda salptr+1            ;a7b1  a5 ca
    sta vartab+1            ;a7b3  85 2b

lab_a7b5_done:
    rts                     ;a7b5  60

;Evaluate expression as filename; set up FNLEN and FNADR
sub_a7b6_eval_fname:
    jsr frmevl              ;a7b6  20 98 bd   BASIC Input and evaluate any expression
    jsr freestr             ;a7b9  20 b5 c7   BASIC Discard temporary string
    sta fnlen               ;a7bc  85 d1
    lda mem_001f            ;a7be  a5 1f
    sta fnadr               ;a7c0  85 da
    lda mem_001f+1          ;a7c2  a5 20
    sta fnadr+1             ;a7c4  85 db
    rts                     ;a7c6  60

;Wedge command !CATALOG
;
;  !CATALOG             List directory without filename; equivalent to CATALOG"$"
;  !CATALOG"filename"   List directory with filename
;
lab_a7c7_cmd_catalog:
    jsr sub_a390_setup      ;a7c7  20 90 a3   Sets up VIA, sets FA = IEC device, sets KERNAL STATUS = 0
    jsr chrgot              ;a7ca  20 76 00   Subroutine: Get the Same Byte of BASIC Text again
    beq lab_a7d5_no_fname   ;a7cd  f0 06      No filename, so branch to set the default of "$"

    ;A filename was given; evaluate it
    jsr sub_a7b6_eval_fname ;a7cf  20 b6 a7   Evaluate expression as filename; set up FNLEN and FNADR
    jmp lab_a7e1_fname      ;a7d2  4c e1 a7   Jump to perform !CATALOG with the set filename

;No filename given for !CATALOG so set the filename to "$"
lab_a7d5_no_fname:
    lda #<mem_a83a_dollr    ;a7d5  a9 3a
    sta fnadr               ;a7d7  85 da
    lda #>mem_a83a_dollr    ;a7d9  a9 a8
    sta fnadr+1             ;a7db  85 db
    lda #mem_a83a_dollr_len ;a7dd  a9 01
    sta fnlen               ;a7df  85 d1
    ;Fall through

;Perform !CATALOG with the set filename
lab_a7e1_fname:
    lda #(0 | 0x60)         ;a7e1  a9 60      A = secondary address 0 (LOAD) | 0x60
    sta sa                  ;a7e3  85 d3      Set SA (KERNAL current secondary address)
    jsr sub_a689_open       ;a7e5  20 89 a6   Send OPEN to IEC
    jsr sub_a3ef_talk       ;a7e8  20 ef a3   Send TALK to IEC
    jsr sub_a4bc_tksa       ;a7eb  20 bc a4   Send secondary address to an IEC device commanded to talk
    lda #0x00               ;a7ee  a9 00
    sta status              ;a7f0  85 96      KERNAL STATUS = 0 (no error)
    ldy #0x03               ;a7f2  a0 03

lab_a7f4_cat_loop:
    sty salptr              ;a7f4  84 c9

    jsr sub_a507_acptrs     ;a7f6  20 07 a5   Read a byte from IEC with initial status check
    sta salptr+1            ;a7f9  85 ca
    ldy status              ;a7fb  a4 96
    bne lab_a831_error      ;a7fd  d0 32

    jsr sub_a507_acptrs     ;a7ff  20 07 a5   Read a byte from IEC with initial status check
    ldy status              ;a802  a4 96
    bne lab_a831_error      ;a804  d0 2b

    ldy salptr              ;a806  a4 c9
    dey                     ;a808  88
    bne lab_a7f4_cat_loop   ;a809  d0 e9

    ldx salptr+1            ;a80b  a6 ca
    jsr linprt              ;a80d  20 83 cf   BASIC Print 256*A + X in decimal

    lda #0x20               ;a810  a9 20      A = SPACE character
    jsr chrout              ;a812  20 d2 ff   KERNAL Send a char to the current output device

lab_a815:
    jsr sub_a507_acptrs     ;a815  20 07 a5   Read a byte from IEC with initial status check
    ldx status              ;a818  a6 96
    bne lab_a831_error      ;a81a  d0 15
    tax                     ;a81c  aa
    beq lab_a825            ;a81d  f0 06
    jsr chrout              ;a81f  20 d2 ff   KERNAL Send a char to the current output device
    jmp lab_a815            ;a822  4c 15 a8

lab_a825:
    lda #0x0d               ;a825  a9 0d      A = carriage return
    jsr chrout              ;a827  20 d2 ff   KERNAL Send a char to the current output device

    ldy #0x02               ;a82a  a0 02

    jsr sub_a89a_chk_stop   ;a82c  20 9a a8   STOP key pressed?  (Returns Z=1 if so.)
    bne lab_a7f4_cat_loop   ;a82f  d0 c3        Branch if not pressed
    ;STOP key pressed

lab_a831_error:
    jmp sub_a65e_close      ;a831  4c 5e a6   Send CLOSE to IEC

;Command to change the drive's device number
mem_a834_m_w:
    .ascii "M-W"            ;CBM DOS Memory-Write command
    .word 0x0077            ;Start address = 0x0077 in drive RAM
    .byte 2                 ;Number of data bytes to write = 2
    .ascii "$"              ;0x0077: IEC bus LISTEN command to accept. (Device number OR $20)
    .byte 0                 ;0x0078: IEC bus TALK command to accept. (Device number OR $40)
mem_a834_m_w_len = ( . - mem_a834_m_w)  ;Length of "M-W" command above

;Dollar sign used with CATALOG command (one byte from above is reused for this)
mem_a83a_dollr = mem_a834_m_w + 6
mem_a83a_dollr_len = 1

;Query the device's status and print it
;Prints like: "00, OK,00,00"
sub_a83c_status:
    jsr sub_a65e_close      ;a83c  20 5e a6   Send CLOSE to IEC
    jsr sub_a3ad_set_fa_st  ;a83f  20 ad a3   Set FA = copy of current IEC device num, set KERNAL STATUS = 0
    jsr sub_a3ef_talk       ;a842  20 ef a3   Send TALK to IEC
    lda #0x6f               ;a845  a9 6f
    jsr sub_a4bc_tksa       ;a847  20 bc a4   Send secondary address to an IEC device commanded to talk

lab_a84a:
    jsr sub_a507_acptrs     ;a84a  20 07 a5   Read a byte from IEC with initial status check
    jsr chrout              ;a84d  20 d2 ff   KERNAL Send a char to the current output device
    cmp #0x0d               ;a850  c9 0d
    bne lab_a84a            ;a852  d0 f6
    jsr sub_a4e4_untlk      ;a854  20 e4 a4   Send UNTALK to IEC
    jmp sub_a65e_close      ;a857  4c 5e a6   Send CLOSE to IEC

;Compares byte at txtptr with a comma
sub_a85a_cmp_comma:
    ldy #0x00               ;a85a  a0 00
    lda [txtptr],y          ;a85c  b1 77
    cmp #',                 ;a85e  c9 2c
    rts                     ;a860  60

;Evals expression, calls hexit 4 times, sets ml1ptr
;Called only during LOAD, SAVE, or VERIFY
sub_a861:
    jsr frmevl              ;a861  20 98 bd   BASIC Input and evaluate any expression
    jsr freestr             ;a864  20 b5 c7   BASIC Discard temporary string
    cmp #0x04               ;a867  c9 04
    bne lab_a88c_syntax     ;a869  d0 21
    ldy #0xff               ;a86b  a0 ff
    jsr sub_a894_hexit      ;a86d  20 94 a8   INCY then hexit value at [mem_001],Y
    jsr sub_a88f_asl_a_4x   ;a870  20 8f a8   Perform ASL A four times
    sta ml1ptr+1            ;a873  85 fc
    jsr sub_a894_hexit      ;a875  20 94 a8   INCY then hexit value at [mem_001],Y
    ora ml1ptr+1            ;a878  05 fc
    sta ml1ptr+1            ;a87a  85 fc
    jsr sub_a894_hexit      ;a87c  20 94 a8   INCY then hexit value at [mem_001],Y
    jsr sub_a88f_asl_a_4x   ;a87f  20 8f a8   Perform ASL A four times
    sta ml1ptr              ;a882  85 fb
    jsr sub_a894_hexit      ;a884  20 94 a8   INCY then hexit value at [mem_001],Y
    ora ml1ptr              ;a887  05 fb
    sta ml1ptr              ;a889  85 fb
    rts                     ;a88b  60

lab_a88c_syntax:
    jmp syntax              ;a88c  4c 00 bf    ?SYNTAX ERROR unconditionally

;Perform ASL A four times
sub_a88f_asl_a_4x:
    asl a                   ;a88f  0a
    asl a                   ;a890  0a
    asl a                   ;a891  0a
    asl a                   ;a892  0a
    rts                     ;a893  60

;INCY then hexit value at [mem_001],Y
sub_a894_hexit:
    iny                     ;a894  c8
    lda [mem_001f],y        ;a895  b1 1f
    jmp hexit               ;a897  4c 8d d7   MONITOR Evaluate char in A to a hex nibble

;STOP key pressed?  Returns Z=1 if so.
sub_a89a_chk_stop:
    lda pia1_portb          ;a89a  ad 12 e8
    cmp #0b11101111         ;a89d  c9 ef      STOP is row 9, col 4 on both bus and gfx keyboards
    rts                     ;a89f  60

;Compare (copy of current IEC dev num & 0x7F) to KERNAL current dev num FA
sub_a8a0_cmp_fa:
    lda mem_03ff            ;a8a0  ad ff 03   A = copy of current IEC device number
    and #0x7f               ;a8a3  29 7f      Mask off bit 7
    cmp fa                  ;a8a5  c5 d4      Compare to KERNAL current device number
    rts                     ;a8a7  60

;Parse integer into SA with leading # sign, or ?SYNTAX ERROR
sub_a8a8_parse_sa_1:
    lda #'#                 ;a8a8  a9 23
    jsr isaequ              ;a8aa  20 f7 be   BASIC ?SYNTAX ERROR if CHRGET does not equal byte in A

;Parse integer into SA without leading #, or ?SYNTAX ERROR
sub_a8ad_parse_sa_2:
    jsr sub_a3ad_set_fa_st  ;a8ad  20 ad a3   Set FA = copy of current IEC device num, set KERNAL STATUS = 0
    jsr gtbytc+3            ;a8b0  20 d4 c8   BASIC Evaluate integer 0-255, return it in X
    txa                     ;a8b3  8a
    ora #0x60               ;a8b4  09 60
    sta sa                  ;a8b6  85 d3      Set SA (KERNAL current secondary address)
    rts                     ;a8b8  60

;Unused space
    .rept 1863
    .byte 0xff
    .endm
