;===============================================================================
SECTION "state_main", rom0
;-------------------------------------------------------------------------------
include "core/hardware.inc"
include "core/sprites.inc"
include "core/state.inc"

;===============================================================================
STATE_MAIN:: DB %01101000  ; $68  ==  load + main + vblank
; See state.inc, on how to define and change states
;-------------------------------------------------------------------------------
    DW .start
    DW .update
    DW .vblank

;===============================================================================
; Consts
;-------------------------------------------------------------------------------
.palettes: DB $E4, $1B

          ; x,  y,  tile, flags
.sprite: DB 76, 84, 1,    %00000000 


;===============================================================================
.start:
;-------------------------------------------------------------------------------
    di ; Stop all enventually running interrupts
    reset_mem_bit cLCDC, 7 ; Disable screen

    ; Init memory
    set_byte cBGPALETT, [.palettes] ; set background Palette
    set_byte cOBJPALETT0, [.palettes]
    
    copy_mem asset_gfx_tiles, cTILEDATA0, 6144 ; copy TileSet 
    fill_mem cBGMAP0, $0400, 5 ; fill map 0 (32*32 Byte) with tile $05

    sprites_clear
    sprite_load 1, .sprite

    ; Activate VBlank interrupt
    set_byte cINTERRUPTS, INT_VBLANK ; VBlank interrupt 
    
    set_mem_bit cLCDC, 7 ; Enable screen
    set_mem_bit cLCDC, 1 ; Enable Sprites
    ei
    ret


;===============================================================================
.update:
;-------------------------------------------------------------------------------

    call buttons_update

    ; check if START was pressed 
    .press_check:
        ldh a, [buttons_pressed] ; load the pressed buttons
        and %10000000            ; filter the start button
        jp z, .release_check ; if not pressed, check for release
            ; else change palette
            set_byte cBGPALETT,  [.palettes+1]; set background Palette
            jp .end  ; Skip check for release


    ; else check if START was released
    .release_check:
        ldh a, [buttons_released]   ; load the relase buttons
        and %10000000      ; filter start button
        jp z, .end ; if not releassed, continue loop

            ; else reset palatte
            set_byte cBGPALETT,  [.palettes]; set background Palette

    .end:
    ret

;===============================================================================
.vblank:
;-------------------------------------------------------------------------------
    sprites_update
ret
