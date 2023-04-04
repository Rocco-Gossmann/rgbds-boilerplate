; Flags
; =============================================
;  Z        =  Zero Flag
;  C        =  Carry Flag

; Registers
; 16 bit    =       High           Low
; =============================================
; AF        =         A            Flags   => Data transfer from and to RAM/VRAM
; BC        =         B            C
; DE        =         D            E 
; HL        =         H            L  
; SP        =       Stack Pointer
; PC        =       Program counter


; Interupts (bits for $FFFF)
; bits      = Interupts
; =============================================
INT_VBLANK equ $01  ; draw
INT_LCD    equ $02  ; stat
INT_TIMA   equ $04  ; timer
INT_SERIAL equ $08  ; serial
; INT_INPUT  equ $F0   ; input (not relayable DONT USE !!!)
INT_ALL    equ $0F



; JoyPad Bits
; =============================================
; type   bit
; ------------
bBTN_READ_DPAD    equ %00100000 ;(D-Pad  Input Scanline)
bBTN_READ_BUTTONS equ %00010000 ;(Button Input Scanline)
bBTN_R_A          equ %0001
bBTN_L_B          equ %0010
bBTN_U_START      equ %0100
bBTN_D_SELECT     equ %1000

; LCDC Bits
;==============================================
; 7 = LCD On/Off
; 6 = Window TileMap select ( 0 = 9800 [cBGMAP0], 1 = 9c00 [cBGMAP1])
; 5 = Window On/Off
; 4 = BG,Window TileData (0 = 8800-97ff [cTILEDATA0], 1 = 8000-87ff [cTILEDATA1] ) 
; 3 = BG Tilemap ( 0 = 9800-9bff [cBGMAP0], 1 = 9c00-9fff [cBGMAP1]
; 2 = Sprite size (0 = 8x8, 1 = 8x16)
; 1 = Sprites On / Off
; 0 = BG On / Off

; LCD_STAT_Bits
;==============================================
; 7 = unused
; 6 = W => trigger only, when cLCD_LY == cLCD_LYC
; 5 = W => trigger when oam is accessed 
; 4 = W => trigger on v-blank               
; 3 = W => trigger on h-blank               
; 2 = R => shows if cLCD_LY == cLCD_LYC
; 1-0 = R => mode flags
;            00 = H-Blank
;            01 = V-Blank
;            10 = OAM is accessed
;            11 = OAM and VRAM are used

; OAM-Bytes
;==============================================
; [addr] + 0 = x-Position on screen 
; [addr] + 1 = y-Position on screen
; [addr] + 2 = tile index (inside of cTILEDATA1)
; [addr] + 3 = Proppertys
;              bit 7 hide behind background (only bg-colors 01, 10 and 11. 
;                    sprite still shows obove color 00)
;              bit 6 y-flip
;              bit 5 x-flip
;              bit 4 palett (0 = cOBJPALETT0, 1 = cOBJPALETT1)
;              bit 3, 2, 1, 0 are unused

; FF07 : Timer-Interrupt-Controller (TAC) Bits
;==============================================
; 7-3 - unused
;   2 - Timer On/Off
; 1-0 - Frequency
;       00 -   4096 Hz (inc counts per sec)
;       01 - 262144 Hz 
;       10 -  65536 Hz 
;       11 -  16384 Hz 


; highram use ldh 
; IO-Registers
; =============================================
cINTERRUPTS       equ  $FFFF
cHRAM             equ  $FF80 ; Highram 128 KB (shared with SP) 
cWINX             equ  $FF4B
cWINY             equ  $FF4A

; Pallets   =  bit 7 - 6 = 1st color
;              bit 5 - 4 = 2nd color
;              bit 3 - 2 = 3rd color
;              bit 1 - 0 = 4th color
;
;    Color  = 11 = white
;             10 = light gray
;             01 = dark gray
;             00 = black
;
;    Recommended Default: $E4   (white, lightgray, darkgray, black)
cOBJPALETT1       equ  $FF49
cOBJPALETT0       equ  $FF48
cBGPALETT         equ  $FF47

cDMA              equ  $FF46  ; dma transfer from $xx00 to $xx9f to cOAM
                              ; (where xx is the content of this register)

cLCD_LYC          equ  $FF45 ; (this == cLCD_Y) = coincidence bit in cLCD_STAT
cLCD_LY           equ  $FF44 ; current scanline
cSCX              equ  $FF43 ; Backgrounds horizontal shift from 0-255
cSCY              equ  $FF42 ; Backgrounds vertical   shift from 0-255 
cLCD_STAT         equ  $FF41
cLCDC             equ  $FF40
cTAC              equ  $FF07 ; Timer-Controller
cTMA              equ  $FF06 ; Timer - Reset-Value
                             ; Used by the timer-counter as start value, after the
                             ; interrupt has been triggered

cJOYPAD           equ  $FF00

; Low Ram (use ld)
cOAM              equ  $FE00 ; - FE9F
cRAM              equ  $C000
cRAMBANK          equ  $A000

cBGMAP1           equ  $9C00 ; - 9fff   used when LCDC s bit $10 is turned on
cBGMAP0           equ  $9800 ; - 9bff   used when LCDC s bit $10 is turned off

cTILEDATA1        equ  $8800 ; - 97ff    (4 KB)
cTILEDATA0        equ  $8000 ; - 8fff    (4 KB) contains also sprite-tiles

cVIDEORAM         equ  $8000
