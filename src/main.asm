;===============================================================================
; Workshop Day 3
;-------------------------------------------------------------------------------
; Press the Start - Button to change the screens palette 
;   As long as it is held, the screen will change its palette
;   If it is released, the Palette changes back
; Condition
;   Don't set the palette each frame
;   Palette can only change if a initial press or a release occures

;===============================================================================
SECTION "DATA0", rom0
;-------------------------------------------------------------------------------
palettes: 
    DB $E4, $1B

;===============================================================================
SECTION "main", ROM0[$150]
;-------------------------------------------------------------------------------
include "core/hardware.inc"
include "core/memory.inc"

main::

    
    di ; Stop all enventually running interrupts
    reset_mem_bit cLCDC, 7 ; Disable screen

    ; Init memory
    set_byte cBGPALETT, [palettes] ; set background Palette
    
    copy_mem asset_gfx_tiles, cTILEDATA0, 6144 ; copy TileSet 
    fill_mem cBGMAP0, $0400, 2 ; fill map 0 (32*32 Byte) with tile $02

    ; Activate VBlank interrupt
    set_byte cINTERRUPTS, INT_VBLANK ; enable LCD and VBlank interrupt 
    
    set_mem_bit cLCDC, 7 ; Enable screen
    ei ; enable interrupts

; main-loop
_main_loop_start:

    call buttons_update

    ; check if START was pressed 
    .main_loop_press_check:
        ldh a, [buttons_pressed] ; load the pressed buttons
        and %10000000            ; filter the start button
        jp z, .main_loop_release_check ; if not pressed, check for release
            ; else change palette
            set_byte cBGPALETT,  [palettes+1]; set background Palette
            jp .main_loop_continue  ; Skip check for release


    ; else check if START was released
    .main_loop_release_check:
        ldh a, [buttons_released]   ; load the relase buttons
        and %10000000      ; filter start button
        jp z, .main_loop_continue ; if not releassed, continue loop

            ; else reset palatte
            set_byte cBGPALETT,  [palettes]; set background Palette


    .main_loop_continue:
        halt ; wait for next vblank
        nop
        jr _main_loop_start