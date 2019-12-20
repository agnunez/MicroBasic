; From the book "Interface 1 and Microdrive Programmin (Spanish)"
; Written August 1983. Book Published 1984 under (c) Anaya Multimedia SA. ISBN 84-7614-038-X
; Author: Agustin Nunez @agnuca https://github.com/agnunez/MicroBasic
; Code: NonoComercial Creative Commons Internationa (CC BY-NC 4.0)

    DEVICE ZXSPECTRUM48
;    ORG 0xF700
;    JP 0xFA32
    ORG 0xF73C   ; Load binary in 63292
var01 EQU 0x5C81
var02 EQU 0x5CB0
inichad EQU 0x5C5D
main:
exten:
    RST 0x10
    DEFW 0x0018
    LD (var01),HL
    LD C,0
    LD HL, stab
    JP otrocom
vecin:
    JP inter
stab:
    DEFB 0xE3,0xA0              ; CODE "READ"
    DEFB 0xE5,0xA0              ; CODE "RESTORE"
    DEFB 0xBF,0xA0              ; CODE "IN"
    DEFB 0xF3,0xA0              ; CODE "NEXT"
    DEFB ".ONERROR:",0xEC,0xA0  ; + CODE 'GOTO'"
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
    DEFB 0x2D,0xA0 ; CODE "-"    (LOAD)
    DEFB 0x3C,0xA0 ; CODE "<"    (VERIFY)
    DEFB 0x3E,0xA0 ; CODE ">"    (MERGE)
    DEFB 0x26,0xA0 ; CODE "&"    (MOVE)
    DEFB 0x27,0xA0 ; CODE "'"    (ERASE)
    DEFB 0x5F,0xA0 ; CODE "_"    (FORMAT)
    DEFB 0x24,0xA0 ; CODE "$"    (OPEN#)
finstab: 
    DEFB 0xFF      ; End of command table
    DEFB 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 ; Filler
rtab:             ; command code start address table
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
    RST 0x10
    DEFW 0020
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
    RST 0x10
    DEFW 0x0018
    POP HL
    INC C
    JR othcm
taber:
    JP 0x01F0
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

mat1:
comm:
nexts:
roner:
offer:
rren:
rtr:
rfnd:
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
otrocom:
inter:

    ORG 0xFA32
rnew:
    RST 0x10
    DEFW 0x0020     ; Increment CHADD
    CALL 0x05B7       ; Exit edit
    RST 0x010
    DEFW new        ; Call NEW in ROM1
retu:
    JP rtu
retv:
    JP rtv
new:
    LD DE, 0xFF58   ; USR"a" address
    LD HL, 0x11B7   ; NEW ROM1 1st routine block
    LD BC, 0x0047   ; transfer 0x47 bytes 1st segment
    LDIR
    LD HL, 0x1219   ; NEW ROM1 second block
    LD BC, 0x005D   ; transfer 0x5D bytes
    LDIR
    LD HL, retu
    LD BC, 0x03      ; transfer 3 bytes 
    LDIR
    JP 0xFF58       ; execute 1st block
rtu:
    LD DE, 0xFF58
    LD HL ,0x1276
    LD BC, 0x002A
    LDIR
    LD HL, retv
    LD BC, 0x03
    LDIR
    LD HL, pomsg
    LD (0xFF79),HL
    JP 0xFF58
rtv:
    RST 0x08
    DEFB 0x31
    LD HL, exten
    LD (0x5CB7),HL
    LD HL, 0xFFFF
    LD DE, 0x3EAF
    LD BC,0x00A0
    EX DE,HL
    LDDR
    LD A,(0x5C6A)
    SET 3,A
    LD (0x5C6A),A
    LD A,0x58
    LD (0x5CB1),A
    JP 0x12A9

; to be continued

    ORG 0xFD89
pomsg:
    DEFB 0xA0
    DEFB "Micro Basic O.S. ANC SPAIN "
    DEFB 0x7F
    DEFB "198"
    DEFB 0xB4
 SAVESNA "microbasic.sna", main

