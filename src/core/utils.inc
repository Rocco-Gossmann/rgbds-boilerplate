
/*==============================================================================
 ## check_BC_zero()
 Checks if BC contains $0000
 Cycles: 10 (11 if BC > $00ff )
 ------------------------------------------------------------------------------
 ### Destroys:
   - AF
 ------------------------------------------------------------------------------
 ### Output:
   - Flags
     * NZ = BC is not $0000
     *  Z = BC is $0000
 ============================================================================*/
MACRO check_BC_zero
    call _check_BC_zero
ENDM

MACRO call_HL
    call _call_HL   ;3 bytes
ENDM


MACRO push_all 
    push af
    push bc
    push de
    push hl
ENDM


MACRO pop_all 
    pop hl
    pop de
    pop bc
    pop af
ENDM