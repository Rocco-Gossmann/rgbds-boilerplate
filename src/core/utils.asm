SECTION "core.utils", ROM0

_check_BC_zero::
    ld a, c    ; 1 cycle
    cp a, 0    ; 2 cycles
    jr nz, .check_BC_zero_end  ; 3 cycles (true) 2 cycles (false)
    
    ld a, b    ; 1 cycle
    cp a, c    ; 1 cycle
.check_BC_zero_end:
    ret        ; 4 cycles


/*==============================================================================
 ## add_A_to_HL
 adds the value in A to the value in register HL
 ============================================================================*/
add_A_to_HL::
    push bc
        ld b, 0
        ld c, a
        add hl, bc
    pop bc
    ret