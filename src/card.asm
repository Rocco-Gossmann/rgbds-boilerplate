;===============================================================================
SECTION "header_cardtitle", ROM0[$0134] ; - $013E (11 bytes)
;-------------------------------------------------------------------------------
DB "BOILERPLATE"
;DS 7 ; use padding to fill the rest of the 11 bytes if needed

;===============================================================================
SECTION "header_manufacturer_code", ROM0[$013f] ; - $0142  (4 bytes)
;-------------------------------------------------------------------------------
DB $00, $00, $00, $00

;===============================================================================
SECTION "header_gb_compatibility", ROM0[$0143] ; (1 byte)
;-------------------------------------------------------------------------------
; 00 =  GBC unsupported
; 80 =  GBC compatible
; C0 =  GBC exclusive
DB 00

; $0144 - $0145: "New" Licensee Code, a two character name.

;===============================================================================
SECTION "header_supergameboy_supported", ROM0[$0146] ; (1 byte)
;-------------------------------------------------------------------------------
; 00 = unsupported
; 03 = supported
DB $00

;===============================================================================
SECTION "header_cardtype", ROM0[$0147] ; (1 byte)
;-------------------------------------------------------------------------------
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

;===============================================================================
SECTION "header_romsize", ROM0[$0148] ; (1 byte)
;-------------------------------------------------------------------------------
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

;===============================================================================
SECTION "header_saveramsize", ROM0[$0149] ; (1 byte) Ram size (SRAM => Save Memory (static RAM)).
;-------------------------------------------------------------------------------
; 00 =     0 Byte
; 01 =     2 KB     =  1 Bank
; 02 =     8 KB     =  1 Bank
; 03 =    32 KB     =  4 Banks
; 04 =   128 KB     = 16 Banks
DB $00

;===============================================================================
SECTION "header_region", ROM0[$014a] ; (1 byte)
;-------------------------------------------------------------------------------
; $014A: Destination code. 
; 00 = Japanese
; 01 = Non-Japanese
DB $01
