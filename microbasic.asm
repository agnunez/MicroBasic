    DEVICE ZXSPECTRUM48
    ORG 0xF736

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

otrocom:
    NOP
inter:
    NOP
stab:
    DEFB 0xE3,0xA0  ; CODE "READ"
    DEFB 0xE5,0xA0  ; CODE "RESTORE"
    DEFB 0xBF,0xA0  ; CODE "IN"
    DEFB 0xF3,0xA0  ; CODE "NEXT"
    DEFB 0x2E,0x4F,0x4E,0x45,0x52,0x52,0x4F,0x52,0x3A,0xEC,0xA0   ; ".ONERROR: + CODE 'GOTO'"
 
 SAVESNA "microbasic.sna", main

