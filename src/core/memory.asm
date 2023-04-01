SECTION "core.memory", ROM0

include "./utils.inc"

_fill_BC_bytes_at_HL_with_A::
    push hl
    push bc
    push af


_fill_BC_bytes_at_HL_with_A_loop_start:   
    check_BC_zero
    jr z, _fill_BC_bytes_at_HL_with_A_function_end
        pop af
        push af

        ld [hli], a
        dec bc
    jr _fill_BC_bytes_at_HL_with_A_loop_start
    
_fill_BC_bytes_at_HL_with_A_function_end:
    pop af
    pop bc
    pop hl
    ret