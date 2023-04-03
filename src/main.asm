SECTION "main", ROM0[$150]

;===============================================================================
include "core/hardware.inc"
include "core/memory.inc"

main::
    ; Disable screen
    reset_mem_bit cLCDC, 7

    ; set background Palette
    set_mem cBGPALETT, $E4

    ; copy TileSet 
    copy_mem asset_gfx_tiles, cTILEDATA0, 6144 

    ; fill map 0 (32*32 Byte) with tile $02
    fill_mem cBGMAP0, $0400, 2

    ; Enable screen
    set_mem_bit cLCDC, 7

; main-loop
_main_loop_start:
    halt
    nop
    jr _main_loop_start


