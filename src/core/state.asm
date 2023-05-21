
include "./utils.inc"
include "./state.inc"

MACRO state_call  
    ld hl, current_state + \1   ; 3 bytes
    call_HL
ENDM

;===============================================================================
SECTION "rom", ROM0[$0000]
;-------------------------------------------------------------------------------
; $0000 - $003F: Reset handlers.
rept 63
    nop
endr
ret

;===============================================================================
SECTION "interrupt_vblank", ROM0[$0040]
;-------------------------------------------------------------------------------
    state_call state_fnc_vblank ; 6 Bytes
reti ; 1 byte

; $0048 stats
;===============================================================================
SECTION "interrupt_stats", ROM0[$0048]
;-------------------------------------------------------------------------------
    state_call state_fnc_lcd ; 6 Bytes
reti ; 1 byte

;===============================================================================
SECTION "interrupt_timer", ROM0[$0050]
;-------------------------------------------------------------------------------
    state_call state_fnc_timer ; 6 Bytes
reti ; 1 byte

;===============================================================================
SECTION "interrupt_linkcable", ROM0[$0058]
;-------------------------------------------------------------------------------
    state_call state_fnc_serial ; 6 Bytes
reti ; 1 byte

; $0060  Joypad
;===============================================================================
SECTION "interrupt_joypad", ROM0[$0060]
;-------------------------------------------------------------------------------
reti

; $0068 - $00FF: Space.

;===============================================================================
SECTION "junp_to_main", ROM0[$0100] ; - $0103 = startup
;-------------------------------------------------------------------------------
nop
jp main


;===============================================================================
SECTION "main", ROM0[$150]
;-------------------------------------------------------------------------------
main:
    call _sprites_init                ; initialize sprites first
    ;---------------------------------------------------------------------------

    ld hl, nop_call                  ;
    ld a, h                          ;
    ldh [current_state.unload], a    ;
    ld a, l                          ;
    ldh [current_state.unload+1], a  ; Setup the Initial State
                                     ;
    ld bc, STATE_MAIN                ;
    call _load_new_state_from_bc     ; 
    ;---------------------------------------------------------------------------

; main-loop
    .loop:
        state_call state_fnc_main

        halt ; wait for next vblank
        nop
        jr .loop


;===============================================================================
SECTION "statehandler_memory", hram ; highram 
;-------------------------------------------------------------------------------
current_state_function_mask:: DB
current_state:: 
.load:      DW
.main:      DW
.unload:    DW
.vblank:    DW
.timer:     DW
.lcd:       DW
.serial:    DW


;===============================================================================
SECTION "statehandler_code", rom0
;-------------------------------------------------------------------------------

state_fnc_load   equ 0
state_fnc_main   equ 2 
state_fnc_unload equ 4 
state_fnc_vblank equ 6
state_fnc_timer  equ 8 
state_fnc_lcd    equ 10 
state_fnc_serial equ 12 

/*==============================================================================
 ## subroutine, that can be used, of a function of a state has node to execute
 ============================================================================*/
nop_call: ret;

_load_new_state_from_bc::
    push_all

    push bc   ; <-- backing up BC again, because it is unclear if state_fuc_onload destroys it
    state_call state_fnc_unload
    pop bc    ; <-- restore BC backup

    ld hl, current_state+1

    ld a, [bc] ; get function map
    inc bc
    ldh [current_state_function_mask], a

    ld d, a   ;<-- d now holds the function mask
    rl d      ; prime d for reading the mask

    ld e, 7 ; <-- there are 7 functions in a state
            ;     so the loop needs to run 7 times
   
    .loopstart:

        ld [hl], LOW(nop_call)
        dec hl
        ld [hl], HIGH(nop_call)     ; set default value
        inc hl

        rl d  ; check what should happen with the next function
        jr nc, .loopcontinue 
        ; if state defines function

            ld a, [bc]    ; Copy BC to current_state
            ld [hld], a
            inc bc

            ld a, [bc]      ; Copy BC to current_state
            ld [hli], a
            inc bc

        .loopcontinue:
        inc hl
        inc hl

        dec e
        jr z, .loopend
        jr .loopstart

    .loopend:
    pop_all

    push_all

    state_call state_fnc_load

    pop_all
    ret

;===============================================================================
SECTION "fixed_dont_change_1", ROM0[$0144] ; - $0145 "New" Licensee Code, a two character name.
;-------------------------------------------------------------------------------
DB "NO"

SECTION "fixed_dont_change_2", ROM0[$014b]
; $014B: License (must stay $33 to allow for SBG Support)
; tells the System to look at $0144 for the license code
DB $33

; $014C: ROM version (usually 0)
DB $00

; $014D: Header checksum.
; Filled by RGBFIX 
DB $00

; $014E- $014F: Global checksum.
; Filled by RGBFIX
DW $0000

;===============================================================================
SECTION "header_logo", ROM0[$0104] ; - $0133
;-------------------------------------------------------------------------------
DS $2f 
