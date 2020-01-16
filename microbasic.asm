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
CALBAS  EQU 0x10    ; Call a ROM1 routine from ROM2
VECTOR  EQU 0x5CB7  ; Hook address for command extension while syntax error found
grchbuf EQU 0xFF58
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
    DEFW rdel
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
rdel:
rcopy:

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
    LD (grchbuf+0x21),HL
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
    LD A,(0x5C6A)   ; Activate Uppercase to easy new command
    SET 3,A
    LD (0x5C6A),A   ; FLAGS2 00000100 (Set CAPS LOCK)
    LD A,0x00
    LD (0x5C91),A   ; P-FLAGS 01011000 (Paper 9 temp, Ink 9 temp, Inverse permanent)
    JP 0x12A9       ; MAIN-1 tranfer back control to ROM1 main execution loop

; gap
    DS 0xFCA9-$,0
rfnd:               ; .FND Find string in Basic lines command 
    RST 0x10
    DEFW 0x0020     ; Parse a character
    RST 0x10        ; Parse to end of string
    DEFW 0x1C8C
    CALL 0x05B7     ; Exit editor
    RST 0x10
    DEFW sr0        ; call sr0 in ROM1 0xFCE3
    JP 0x05C1       ; command exit
rcha:               ; .CHA Change string command
    RST 0x10        
    DEFW 0x0020     ; Parse next character
    RST 0x10
    DEFW 0x1C8C     ; Parse to end of string in ROM1
    CP 0xCC
    JP NZ,0x01F0    ; Error if  we do not have a 'TO' separator    
    RST 0x10
    DEFW 0x0020     ; Next character
    RST 0x10        ; Parse a character string
    DEFW 0x1C8C
    CALL 0x05B7     ; Exit editor
    RST 0x10        ; call ch0 with ROM1
    DEFW ch0
    JP 0x05C1       ; Command exit
ch0:
    CALL 0x2BF1     ; DE = last string start
    LD A,C          ; BC = last string length
    CP 0            ; length is 0?
    RET Z           ; Resume Basic
    LD HL,0x5B00
    LD (HL),C       ; second string length into 0x5B00
    INC HL
    LD (HL),B
    INC HL
    EX DE, HL       ; Copy in 0x5B02 second string
    LDIR
sr0:
    CALL 0x2BF1
    PUSH DE
    POP IX
    LD A,C
    LD (var01),A
sr1:
    RES 0,(IY+2)
    LD HL,(0x5C53)
sr2:
    LD A,(var01)
    LD E,A
    CP 0x0
    RET Z
    PUSH HL
sr3:
    PUSH IX
    POP BC
    LD D,0x0
    INC HL
    INC HL
    INC HL
sr4:
    INC HL
    PUSH DE
    LD DE,(0x5C4B)
    XOR A
    AND A
    SBC HL,DE
    ADD HL,DE
    POP DE
    JR C,sr5
    POP HL
    RET
sr5:
    LD A,(HL)
    CP 0x0D
    JR NZ,sr6
    INC HL
    POP BC
    PUSH HL
    JR sr3
sr6:
    CALL 0x18B6
    JR NZ,sr8
    DEC HL
sr7:
    LD A,D
    CP 0x0
    JR Z,sr71
    LD B,D
sr70:
    DEC HL
    DJNZ sr70
sr71:
    PUSH IX
    POP BC
    LD D,0
    JR sr4
sr8:
    LD A,(BC)
    CP (HL)
    JR NZ,sr7
    INC BC
    INC D
    LD A,D
    CP E
    JR NZ,sr4
    LD A,(0x5CB0)
    CP 0x0A ; Jump if command is .CHA
    JR NZ,ch1
sr9:
    POP HL
    PUSH HL
    LD B,(HL)
    INC HL
    LD C,(HL)
    LD (0x5C49),BC
    POP HL
    CALL 0x1855
    LD A,0x0D
    RST 0x10
    JR sr2
ch1:
    LD A,E
    CP 0x1
    JR Z,ch3
    DEC A
    LD B,A
ch2:
    DEC HL
    DJNZ ch2
ch3:
    LD A,(0x5B00)
    CP E
    JR Z,ch4
    JR C,ch4
    LD A,E
    LD (0x5B00),A
    JR ch4
ch4:
    EX DE,HL
    LD HL,0x5B02
    LD B,0x0
    LD A,(0x5B00)
    LD C,A
    LDIR
    EX DE,HL
    DEC HL
    PUSH IX
    POP BC
    LD A,(0x5C81)
    LD D,0
    LD E,A
    JP sr4
pomsg:
    DEFB 0xA0
    DEFB "Micro Basic O.S. ANC SPAIN "
    DEFB 0x7F
    DEFB "198"
    DEFB 0xB4
; gap
    DS 0xFDAA-$,0
raof:
    RST 0x10
    DEFW 0x0020
    CALL 0x05B7
    DI
    LD A,0x3E
    LD I,A
    IM 1
    EI
    JP 0x05C1
raon:
    RST 0x10
    DEFW 0x0020
    CALL 0x05B7
    DI
    LD HL,vecin
    LD DE,0xFE69
    LD BC,0x0003
    LDIR
    LD A,0x09
    LD I,A
    IM 2
    EI
    JP 0x05C1
trac0:  
    DEFB 0x0
inter:
    RST 0x038
    DI
    PUSH AF
    LD A,(0x0000)
    CP 0xE1
    JR NZ,rom1
    POP AF
    EI
    RET
rom1:
    PUSH HL
    PUSH DE
    PUSH BC
    LD A,(trac0)
    CP 0x0
    JR NZ,trac4
    LD A,(0x5C82)
    CP 0x20
    JR NZ,trac3
    LD A,(0x5C83)
    CP 0x17
    JR NZ,trac3
    LD HL,0x5C08
    LD A,(HL)
    CP 0x0C
    JR Z,trac3
    LD HL,0x5C04
    LD A,(HL)
    CP 0x0D
    JR Z,twrit
    CP 0xFF
    JR NZ,trac3
twrit:
    LD A,0x04
    LD (trac0),A
trac4:
    LD A,(trac0)
    DEC A
    LD (trac0),A
    LD HL,(0x5C49)
    LD DE,0x000A
    ADD HL,DE
    LD BC,0xFC10
    CALL trac1
    CP 0x03
    JR Z,trac3
    LD BC,0xFF9C
    CALL trac1
    CP 0x02
    JR Z,trac3
    LD BC,0xFFF6
    CALL trac1
    CP 0x01
    JR Z,trac3
    LD BC,0xFFFF
    CALL trac1
    JR trac3
trac1:
    XOR A
trac2:
    ADD HL,BC
    INC A
    JR C,trac2
    SBC HL,BC
    DEC A
    ADD A,0x30
    LD (0x5C08),A
    LD A,(0x5C3B)
    SET 5,A
    LD (0x5C3B),A
    LD A,(trac0)
    RET
trac3:
    POP BC
    POP DE
    POP HL
    POP AF
    EI
    RET
lbjp:
    DEFB 0xFE,0xFE,0xFE,0xFE
; gap
    DS 0xFEF0-$
rsave:
    LD A,0xF8
    JR sacon
rload:
    LD A,0xEF
    JR sacon
rvery:
    LD A,0xD6
    JR sacon
rmerg:
    LD A,0xD5
sacon:
    LD BC,0x0A
    LD DE,texcm
    JR ampli
rmove:
    LD A,0xD1
    JR mocon
reras:
    LD A,0xD2
    JR mocon
rform:
    LD a,0xD0
mocon:
    LD DE, texsa
    LD BC,0x9
    JR ampli
ropen:
    LD A,0xD3
    LD DE,texop
    LD BC, 0x0B
ampli:
    PUSH DE
    PUSH BC
    LD (DE),A
    RST 0x10
    DEFW 0x0020
    POP BC
    PUSH BC
    DEC BC
    RST 0x10
    DEFW 0x1655
    POP BC
    POP DE
    EX DE,HL
    LDIR
    EX DE,HL
    DEC HL
    LD (0x5C5B),HL
    JP 0x01F0
texcm:
    DEFB 0xF8
texmd:
    DEFB "*",0x22,"m",0x22,0x3B,"1",0x3B,0x22,0x22
texsa
    DEFB 0xD1,0x22,"m",0x22,0x3B,"1",0x3B,0x22,0x22
texop:
    DEFB 0xD3,"8",0x3B,0x22,"m",0x22,0x3B,"1",0x3B,0x22,0x22
