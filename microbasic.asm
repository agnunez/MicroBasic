; From the book "Interface 1 and Microdrive Programmin (Spanish)"
; Written August 1983. Book Published 1984 under (c) Anaya Multimedia SA. ISBN 84-7614-038-X
; Author: Agustin Nunez @agnuca https://github.com/agnunez/MicroBasic
; Code: NonoComercial Creative Commons Internationa (CC BY-NC 4.0)

    DEVICE ZXSPECTRUM48
    ORG 0xF73C
var01 EQU 0x5C81
var02 EQU 0x5CB0
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
otrocom:
    NOP
inter:
    NOP

 SAVESNA "microbasic.sna", main

