SECTION "core.utils", ROM0

_check_BC_zero::
    ld a, c    ; 1 cycle
    cp a, 0    ; 2 cycles
    jr nz, :+  ; 3 cycles (true) 2 cycles (false)
    
    ld a, b    ; 1 cycle
    cp a, c    ; 1 cycle
:   ret        ; 4 cycles
