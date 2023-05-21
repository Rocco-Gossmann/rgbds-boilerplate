SECTION "core.memory", ROM0

include "./utils.inc"

/* # Please use the fill_mem macro instead */
_fill_BC_bytes_at_HL_with_A::
    push hl
    push bc
    push af

:        check_BC_zero
        jr z, .end
            pop af
            push af

            ld [hli], a
            dec bc
        jr :-
    
    .end:
        pop af
        pop bc
        pop hl
    ret





/* # Please use the copy_mem macro instead */
_copy_BC_bytes_from_DE_to_HL::

/* # Please use the copy_mem macro instead */
_copy_BC_bytes_from_DE_to_HL_loop_start:
    check_BC_zero
    jr z, _copy_BC_bytes_from_DE_to_HL_function_end

    ld a, [de]
    ld [hli], a
   
    inc de
    dec bc
    jr _copy_BC_bytes_from_DE_to_HL_loop_start

/* # Please use the copy_mem macro instead */
_copy_BC_bytes_from_DE_to_HL_function_end:
    ret
