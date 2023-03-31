SECTION "rom", ROM0[$0000]
; $0000 - $003F: Reset handlers.
rept 63
    nop
endr
ret

; $0040 - $0067: Interrupts.
; $0040  VBlank
rept 7
    nop
endr
reti

; $0048 stats
rept 7
    nop
endr
reti

; $0050  timer
rept 7
    nop
endr
reti

; $0058 link-cable (serial)
rept 7
    nop
endr
reti

; $0060  Joypad
rept 7
    nop
endr
reti

DS $98 ;$0068 - $00FF: Space. DON'T change: 


;===============================================================================
; Main function
;===============================================================================
; $0100 - $0103: Startup.
nop
jp main



;===============================================================================
; ROM Info
;===============================================================================
DS 48 ; $0104 - $0133 48 Byte. (Filled by rgbfix with logo)


; $0134 - $013E: (11 byte) The title, in upper-case letters, followed by zeroes.
DB "RGWSDAY0001" 


; $013F - $0142: The manufacturer code.
DB $00, $00, $00, $00

; $0143: Gameboy Color compatibility flag.    
; 00 =  GBC unsupported
; 80 =  GBC compatible
; C0 =  GBC exclusive
DB 00

; $0144 - $0145: "New" Licensee Code, a two character name.
DB "OK"

; $0146: SGB compatibility (Super Gameboy).
; 00 = unsupported
; 03 = supported
DB $00

; $0147: Card-Type:
; 00 = Rom Only (32 KB max size)                    
; 01 = MBC1
; 02 = MBC1 with RAM
; 03 = MBC1 with RAM and Battery
; 05 = MBC2
; 06 = MBC2 With Battery
; 08 = Rom with RAM
; 09 = Rom with RAM and Battery
; 0B = MMM01
; 0C = MMM01 With RAM
; 0D = MMM01 With RAM and Battery
; 0F = MBC3 With Battery and Timer
; 10 = MBC3 With RAM, Battery and Timer
; 11 = MBC3
; 12 = MBC3 With RAM
; 13 = MBC3 With RAM and Battery
; 15 = MBC4
; 16 = MBC4 With RAM
; 17 = MBC4 With RAM and Battery
; 19 = MBC5 
; 1A = MBC5 With RAM
; 1B = MBC5 With RAM and Battery
; 1C = MBC5 With Rumble
; 1D = MBC5 With RAM and Rumble
; 1E = MBC5 With RAM, Battery and Rumble
; FC = Camera
; FD = Bandai Tamagochi 5 (BANDAI TAMA5)
; FE = Hudson HuC-3
; FF = Hudson HUC-1 With Battery
DB $00

; $0148: Rom size.
; 00 =    32 KB =   2 Banks
; 01 =    64 KB =   4 Banks
; 02 =   128 KB =   8 Banks
; 03 =   256 KB =  16 Banks
; 04 =   512 KB =  32 Banks
; 05 =  1024 KB =  64 Banks
; 06 =  2048 KB = 128 Banks
; 52 =  1152 KB =  72 Banks
; 53 =  1280 KB =  80 Banks
; 54 =  1536 KB =  96 Banks
DB $00

; $0149: Ram size (SRAM => Save Memory (static RAM)).
; 00 =     0 Byte
; 01 =     2 KB     =  1 Bank
; 02 =     8 KB     =  1 Bank
; 03 =    32 KB     =  4 Banks
; 04 =   128 KB     = 16 Banks
DB $00



;===============================================================================
; Don't change anything from here
;===============================================================================
DB $01 ; $014A: Destination code. (00 = Japan, 01 = None Japan)
DB $33 ; $014B: License (must stay $33 to allow for SBG Support)
DB $00 ; $014C: ROM version (usually 0)
DB $00 ; $014D: Header checksum.
DW $0000 ; $014E- $014F: Global checksum.

