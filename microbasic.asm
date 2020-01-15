; From the book "Interface 1 and Microdrive Programmin (Spanish)"
; Written August 1983. Book Published 1984 under (c) Anaya Multimedia SA. ISBN 84-7614-038-X
; Author: Agustin Nunez @agnuca https://github.com/agnunez/MicroBasic
; Code: NonoComercial Creative Commons Internationa (CC BY-NC 4.0)

    DEVICE ZXSPECTRUM48
    ORG 0xF733  ; Load binary in 63283
rtop EQU $-1
    LD HL,rtop      ; Load RAMTOP  with our firmware start address
    LD (0x5CB2),HL  ; RAMTOP System Variable address
    JP rtv          ; jump to initialization routine
var01 EQU 0x5C81
var02 EQU 0x5CB0
inichad EQU 0x5C5D
grchbuf EQU 0xFF58
CALBAS  EQU 0x10
VECTOR  EQU 0x5CB7
main:
exten:              ; Entry point with ROM2 active
    RST CALBAS      ; ROM2 call ROM1 at def word below
    DEFW 0x0018     ; GET-CHAR from ROM1 into A
    LD (var01),HL
    LD C,0
    LD HL, stab
    JP othcm
vecin:
    JP inter
stab:
    DEFB 0xE3,0xA0		; CODE "READ"
    DEFB 0xE5,0xA0		; CODE "RESTORE"
    DEFB 0xBF,0xA0		; CODE "IN"
    DEFB 0xF3,0xA0		; CODE "NEXT"
    DEFB ".ONERROR:",0xEC,0xA0	; + CODE 'GOTO'"
    DEFB ".OFFERROR",0xA0
    DEFB ".REN",0xA0
    DEFB ".NEW",0xA0
    DEFB ".TRF",0xA0
    DEFB ".DEL",0xA0
    DEFB ".FND",0xA0
    DEFB ".CHA",0xA0
    DEFB ".AOF",0xA0
    DEFB ".AON",0xA0
    DEFB 0xAA,0xA0 ; CODE "SCREEN$"    
    DEFB 0xC3,0xA0 ; CODE "NOT"  (SAVE)
    DEFB 0x2D,0xA0 ; CODE "-"	 (LOAD)
    DEFB 0x3C,0xA0 ; CODE "<"	 (VERIFY)
    DEFB 0x3E,0xA0 ; CODE ">"	 (MERGE)
    DEFB 0x26,0xA0 ; CODE "&"	 (MOVE)
    DEFB 0x27,0xA0 ; CODE "'"	 (ERASE)
    DEFB 0x5F,0xA0 ; CODE "_"	 (FORMAT)
    DEFB 0x24,0xA0 ; CODE "$"	 (OPEN#)
finstab: 
    DEFB 0xFF	   ; End of command table
    DEFB 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 ; Filler
rtab:		  ; command code start address table
    DEFW comm
    DEFW comm
    DEFW comm
    DEFW nexts
    DEFW roner
    DEFW offer
    DEFW rren
    DEFW rnew
    DEFW rtr
    DEFW rren
    DEFW rfnd
    DEFW rcha
    DEFW raof
    DEFW raon
    DEFW rcopy
    DEFW rsave
    DEFW rload
    DEFW rvery
    DEFW rmerg
    DEFW rmove
    DEFW reras
    DEFW rform
finrtab
    DEFW ropen
rlibre: 
    DEFB 0x0,0x0,0x0,0x0
other:
    PUSH BC
    PUSH HL
    RST CALBAS // Call 0x0020 of ROM1 from ROM2
    DEFW 0x0020  // NEXT-CHAR from ROM1 incrementing CH-ADD
    POP HL
    POP BC
othcm:
    LD B,(HL)
    CP B
    JR Z, mat1
    LD B,A
nmat1:
    INC HL
    LD A,(HL)
    CP 0xFF
    JR Z, taber
    CP 0xA0
    JR NZ, nmat1
    INC HL
    LD A,B
    PUSH HL
    LD HL,(var01)
    LD (inichad),HL
    RST CALBAS
    DEFW 0x0018 // GET-CHAR at ROM1
    POP HL
    INC C
    JR othcm
taber:
    JP 0x01F0
mat1:
    LD B,A
    INC HL
    LD A, (HL)
    CP 0xA0
    JR Z, found
    JR other
found: 
    LD A,C
    LD HL, rtab
    SLA C
    LD E,C
    LD D,0x0
    ADD HL, DE
    LD E, (HL)
    INC HL
    LD D,(HL)
    EX DE,HL
    LD (var02),A
    JP (HL)

comm:
nexts:
roner:
offer:
rren:
rtr:

rcha:
raof:
raon:
rcopy:
rsave:
rload:
rvery:
rmerg:
rmove:
reras:
rform:
ropen:
inter:

    DS 0xFA32-$,0  // 64050
rnew:
    RST CALBAS
    DEFW 0x0020     ; Call NEXT-CHAR at ROM1. Test for keypress, incrementing CH-ADD
    CALL 0x05B7     ; ST-END Confirm end of statement and exit from ROM2 into ROM1 editor
    RST CALBAS
    DEFW new        ; copy NEW from ROM1 into Graphic character buffer
retu:
    JP rtu          ; Jump over NEW copy code and resume
retv:
    JP rtv
new:                ; Copy 1st part of fake NEW into grchbuf
    LD DE, grchbuf  ; Graphic character USR"a" buffer address
    LD HL, 0x11B7   ; NEW ROM1 1st routine block
    LD BC, 0x0047   ; transfer 0x47 bytes 1st segment
    LDIR
    LD HL, 0x1219   ; NEW ROM1 second block
    LD BC, 0x005D   ; transfer 0x5D bytes
    LDIR
    LD HL, retu     ; add rtu return address at the end of fake NEW copy 1st part
    LD BC, 0x03     ; transfer 3 bytes 
    LDIR
    JP grchbuf      ; execute 1st part of fake NEW
rtu:
    LD DE, grchbuf
    LD HL ,0x1276
    LD BC, 0x002A
    LDIR
    LD HL, retv     ; add rtv return address at the end of fake NEW copy 2nd part
    LD BC, 0x03
    LDIR
    LD HL, pomsg
    LD (0xFF79),HL
    JP grchbuf      ; execute 2nd part of fake NEW with pomsg welcome message and resume at rtv
rtv:
    RST 0x08        ; Call Hook at ROM2
    DEFB 0x31       ; Creates the new system variables used by the Interface 1
    LD HL, exten
    LD (VECTOR),HL  ; Load our "exten" new command service routine into VECTOR System Variable
    LD HL, 0xFFFF   ; Copy Graphic Characters from ROM1 into used grchbuf top-down
    LD DE, 0x3EAF
    LD BC,0x00A0
    EX DE,HL
    LDDR
    LD A,(0x5C6A)   ; Activate Uppercase to easy new commands
    SET 3,A
    LD (0x5C6A),A   ; FLAGS2 00000100 (Set CAPS LOCK)
    LD A,0x00
    LD (0x5C91),A   ; P-FLAGS 01011000 (Paper 9 temp, Ink 9 temp, Inverse permanent)
    JP 0x12A9       ; MAIN-1 tranfer back control to ROM1 main execution loop

; gap
    DS 0xFCA9-$,0
rfnd:
    RST 0x10
    DEFW 0x0020
    RST 0x10
    DEFW 0x1C8C
    CALL 0x05B7
    RST 0x10
    DEFW 0xFCE3
    JP 0x05C1
; to be continued

    DS 0xFD89-$,0  // 64905
pomsg:
    DEFB 0xA0
    DEFB "Micro Basic O.S. ANC SPAIN "
    DEFB 0x7F
    DEFB "198"
    DEFB 0xB4

 SAVESNA "microbasic.sna", main