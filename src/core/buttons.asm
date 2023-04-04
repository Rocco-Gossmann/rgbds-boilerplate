;===============================================================================
SECTION "buttons_vars", hram
;-------------------------------------------------------------------------------
buttons_pressed::  DS 1
buttons_held::     DS 1
buttons_released:: DS 1


;===============================================================================
SECTION "buttons_code", rom0
;-------------------------------------------------------------------------------
include "./hardware.inc"
include "./memory.inc"

buttons_update::
    push HL 
    push DE
    push BC
    push AF

        ld c, $10 
        call .button_segment
        swap a  ; move read bits to the lower nibble to the higher nibble
        ld b, a ; save the output

        ld c, $20
        call .button_segment
        or b  ; combine buttons and d-pad into one byte (in register A)
            ; each button pressed equals 1 bit with value of 1 (START, SELECT, B, A, Down, Up, Left, Right)

        ld b, a ; b = current button state

        ; buttons, that have been pressed last cycle are added to held 
        ldh a, [buttons_pressed]
        ld d, a ; d = new held buttons
        ldh a, [buttons_held]
        or d 
        ld d, a  ; d = held + last cycles pressed buttons

        ld a, b ; restore backup of button_state
        xor d ; find buttons that changed

        ld c, a ; c = buttons that changed
        and d   ; compare a to old state to find buttons that have been released

        ldh [buttons_released], a
        cpl ; remove released buttons from held list
        and d
        ldh [buttons_held], a

        ld a, c  ; reset a back to changed buttons
        and b ; compare to new state to find buttons, that have been pressed
        ldh [buttons_pressed], a

    pop AF
    pop BC
    pop DE
    pop HL
    ret

.button_segment:
    set_byte cJOYPAD, c  ;aktivate JOYPAD Adress bit 5 to read the buttons
    ld a, [cJOYPAD]
    ld a, [cJOYPAD] ; <-- keep unoptimized on purpous to give the hardware time to catch up
    cpl
    and $0f ; filter the answer bits
    ret