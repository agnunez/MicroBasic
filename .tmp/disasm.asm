             org 004Dh ; 004Dh


; Subroutine: Size=6, CC=1.
; Called by: -
; Calls: -
004D L004D:
004D D1           POP  DE     
004E C1           POP  BC     
004F E1           POP  HL     
0050 F1           POP  AF     
0051 FB           EI          
0052 C9           RET         


0053 E1           defb E1h    	; 225,  -31
0054 6E           defb 6Eh    	; 110, 'n'
0055 FD           defb FDh    	; 253,   -3
0056 75           defb 75h    	; 117, 'u'
0057 00           defb 00h    	; 0
0058 ED           defb EDh    	; 237,  -19
0059 7B           defb 7Bh    	; 123, '{'
005A 3D           defb 3Dh    	; 61, '='
005B 5C           defb 5Ch    	; 92, '\'
005C C3           defb C3h    	; 195,  -61
005D C5           defb C5h    	; 197,  -59
005E 16           defb 16h    	; 22
005F FF           defb FFh    	; 255,   -1
0060 FF           defb FFh    	; 255,   -1
0061 FF           defb FFh    	; 255,   -1
0062 FF           defb FFh    	; 255,   -1
0063 FF           defb FFh    	; 255,   -1
0064 FF           defb FFh    	; 255,   -1
0065 FF           defb FFh    	; 255,   -1
0066 F5           defb F5h    	; 245,  -11
0067 E5           defb E5h    	; 229,  -27
0068 2A           defb 2Ah    	; 42, '*'
0069 B0           defb B0h    	; 176,  -80
006A 5C           defb 5Ch    	; 92, '\'
006B 7C           defb 7Ch    	; 124, '|'
006C B5           defb B5h    	; 181,  -75
006D 20           defb 20h    	; 32, ' '
006E 01           defb 01h    	; 1
006F E9           defb E9h    	; 233,  -23
0070 E1           defb E1h    	; 225,  -31
0071 F1           defb F1h    	; 241,  -15
0072 ED           defb EDh    	; 237,  -19
0073 45           defb 45h    	; 69, 'E'
0074 2A           defb 2Ah    	; 42, '*'
0075 5D           defb 5Dh    	; 93, ']'
0076 5C           defb 5Ch    	; 92, '\'
0077 23           defb 23h    	; 35, '#'
0078 22           defb 22h    	; 34, '"'
0079 5D           defb 5Dh    	; 93, ']'
007A 5C           defb 5Ch    	; 92, '\'
007B 7E           defb 7Eh    	; 126, '~'
007C C9           defb C9h    	; 201,  -55
007D FE           defb FEh    	; 254,   -2
007E 21           defb 21h    	; 33, '!'
007F D0           defb D0h    	; 208,  -48
0080 FE           defb FEh    	; 254,   -2
0081 0D           defb 0Dh    	; 13
0082 C8           defb C8h    	; 200,  -56
0083 FE           defb FEh    	; 254,   -2
0084 10           defb 10h    	; 16
0085 D8           defb D8h    	; 216,  -40
0086 FE           defb FEh    	; 254,   -2
0087 18           defb 18h    	; 24
0088 3F           defb 3Fh    	; 63, '?'
0089 D8           defb D8h    	; 216,  -40
008A 23           defb 23h    	; 35, '#'
008B FE           defb FEh    	; 254,   -2
008C 16           defb 16h    	; 22
008D 38           defb 38h    	; 56, '8'
008E 01           defb 01h    	; 1
008F 23           defb 23h    	; 35, '#'
0090 37           defb 37h    	; 55, '7'
0091 22           defb 22h    	; 34, '"'
0092 5D           defb 5Dh    	; 93, ']'
0093 5C           defb 5Ch    	; 92, '\'
0094 C9           defb C9h    	; 201,  -55
0095 BF           defb BFh    	; 191,  -65
0096 52           defb 52h    	; 82, 'R'
0097 4E           defb 4Eh    	; 78, 'N'
0098 C4           defb C4h    	; 196,  -60
0099 49           defb 49h    	; 73, 'I'
009A 4E           defb 4Eh    	; 78, 'N'
009B 4B           defb 4Bh    	; 75, 'K'
009C 45           defb 45h    	; 69, 'E'
009D 59           defb 59h    	; 89, 'Y'
009E A4           defb A4h    	; 164,  -92
009F 50           defb 50h    	; 80, 'P'
00A0 C9           defb C9h    	; 201,  -55
00A1 46           defb 46h    	; 70, 'F'
00A2 CE           defb CEh    	; 206,  -50
00A3 50           defb 50h    	; 80, 'P'
00A4 4F           defb 4Fh    	; 79, 'O'
00A5 49           defb 49h    	; 73, 'I'
00A6 4E           defb 4Eh    	; 78, 'N'
00A7 D4           defb D4h    	; 212,  -44
00A8 53           defb 53h    	; 83, 'S'
00A9 43           defb 43h    	; 67, 'C'
00AA 52           defb 52h    	; 82, 'R'
00AB 45           defb 45h    	; 69, 'E'
00AC 45           defb 45h    	; 69, 'E'
00AD 4E           defb 4Eh    	; 78, 'N'
00AE A4           defb A4h    	; 164,  -92
00AF 41           defb 41h    	; 65, 'A'
00B0 54           defb 54h    	; 84, 'T'
; ...
; ...
; ...


             org 33B1h ; 33B1h


; Subroutine: Size=3, CC=1.
; Called by: -
; Calls: -
33B1 L33B1:
33B1 E1           POP  HL     
33B2 D1           POP  DE     
33B3 C9           RET         


33B4 ED           defb EDh    	; 237,  -19
33B5 5B           defb 5Bh    	; 91, '['
33B6 65           defb 65h    	; 101, 'e'
33B7 5C           defb 5Ch    	; 92, '\'
33B8 CD           defb CDh    	; 205,  -51
33B9 C0           defb C0h    	; 192,  -64
33BA 33           defb 33h    	; 51, '3'
33BB ED           defb EDh    	; 237,  -19
33BC 53           defb 53h    	; 83, 'S'
33BD 65           defb 65h    	; 101, 'e'
33BE 5C           defb 5Ch    	; 92, '\'
33BF C9           defb C9h    	; 201,  -55
33C0 CD           defb CDh    	; 205,  -51
33C1 A9           defb A9h    	; 169,  -87
33C2 33           defb 33h    	; 51, '3'
33C3 ED           defb EDh    	; 237,  -19
33C4 B0           defb B0h    	; 176,  -80
33C5 C9           defb C9h    	; 201,  -55
33C6 62           defb 62h    	; 98, 'b'
33C7 6B           defb 6Bh    	; 107, 'k'
33C8 CD           defb CDh    	; 205,  -51
33C9 A9           defb A9h    	; 169,  -87
33CA 33           defb 33h    	; 51, '3'
33CB D9           defb D9h    	; 217,  -39
33CC E5           defb E5h    	; 229,  -27
33CD D9           defb D9h    	; 217,  -39
33CE E3           defb E3h    	; 227,  -29
33CF C5           defb C5h    	; 197,  -59
33D0 7E           defb 7Eh    	; 126, '~'
33D1 E6           defb E6h    	; 230,  -26
33D2 C0           defb C0h    	; 192,  -64
33D3 07           defb 07h    	; 7
33D4 07           defb 07h    	; 7
33D5 4F           defb 4Fh    	; 79, 'O'
33D6 0C           defb 0Ch    	; 12
33D7 7E           defb 7Eh    	; 126, '~'
33D8 E6           defb E6h    	; 230,  -26
33D9 3F           defb 3Fh    	; 63, '?'
33DA 20           defb 20h    	; 32, ' '
33DB 02           defb 02h    	; 2
33DC 23           defb 23h    	; 35, '#'
33DD 7E           defb 7Eh    	; 126, '~'
33DE C6           defb C6h    	; 198,  -58
33DF 50           defb 50h    	; 80, 'P'
33E0 12           defb 12h    	; 18
33E1 3E           defb 3Eh    	; 62, '>'
33E2 05           defb 05h    	; 5
33E3 91           defb 91h    	; 145, -111
33E4 23           defb 23h    	; 35, '#'
33E5 13           defb 13h    	; 19
33E6 06           defb 06h    	; 6
33E7 00           defb 00h    	; 0
33E8 ED           defb EDh    	; 237,  -19
33E9 B0           defb B0h    	; 176,  -80
33EA C1           defb C1h    	; 193,  -63
33EB E3           defb E3h    	; 227,  -29
33EC D9           defb D9h    	; 217,  -39
33ED E1           defb E1h    	; 225,  -31
33EE D9           defb D9h    	; 217,  -39
33EF 47           defb 47h    	; 71, 'G'
33F0 AF           defb AFh    	; 175,  -81
33F1 05           defb 05h    	; 5
33F2 C8           defb C8h    	; 200,  -56
33F3 12           defb 12h    	; 18
33F4 13           defb 13h    	; 19
33F5 18           defb 18h    	; 24
33F6 FA           defb FAh    	; 250,   -6
33F7 A7           defb A7h    	; 167,  -89
33F8 C8           defb C8h    	; 200,  -56
33F9 F5           defb F5h    	; 245,  -11
33FA D5           defb D5h    	; 213,  -43
33FB 11           defb 11h    	; 17
33FC 00           defb 00h    	; 0
33FD 00           defb 00h    	; 0
33FE CD           defb CDh    	; 205,  -51
33FF C8           defb C8h    	; 200,  -56
3400 33           defb 33h    	; 51, '3'
3401 D1           defb D1h    	; 209,  -47
3402 F1           defb F1h    	; 241,  -15
3403 3D           defb 3Dh    	; 61, '='
3404 18           defb 18h    	; 24
3405 F2           defb F2h    	; 242,  -14
3406 4F           defb 4Fh    	; 79, 'O'
3407 07           defb 07h    	; 7
3408 07           defb 07h    	; 7
3409 81           defb 81h    	; 129, -127
340A 4F           defb 4Fh    	; 79, 'O'
340B 06           defb 06h    	; 6
340C 00           defb 00h    	; 0
340D 09           defb 09h    	; 9
340E C9           defb C9h    	; 201,  -55
340F D5           defb D5h    	; 213,  -43
3410 2A           defb 2Ah    	; 42, '*'
3411 68           defb 68h    	; 104, 'h'
3412 5C           defb 5Ch    	; 92, '\'
3413 CD           defb CDh    	; 205,  -51
3414 06           defb 06h    	; 6
; ...
; ...
; ...