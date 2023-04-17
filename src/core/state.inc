; State is a series of words (2byte values) that define different adresses of functions in memory

; this is, what a state definition defining all available function looks like
;    state_name:: DB [function map] 
;        DW .load
;        DW .main
;        DW .unload
;        DW .vblank
;        DW .timer
;        DW .lcd
;        DW .serial
;        
;    .load: /* Code goes here */ ret;
;    .main: /* Code goes here */ ret;
;    .unload: /* Code goes here */ ret;
;    .vblank: /* Code goes here */ ret;
;    .timer: /* Code goes here */ ret;
;    .lcd: /* Code goes here */ ret;
;    .serial: /* Code goes here */ ret;


; the [function map]  defines, which of the functions this defined, 
;                     what follows, is the list of function adresses
;                     that MUST BE IN THE ORDER ABOVE 
;                     You may, hover skip all functions in the list,
;                     that are not activated according to the [function map]s bitmap

;          bits are :   64 ($40)= set to activate the .load function
;                       32 ($20)= set to activate the .main function
;                       16 ($10)= set to activate the .unload function

;                        8 ($08)= set if state proveides a the .vblank - interrupt function
;                        4 ($04)= set if state proveides a the .timer - interrupt function
;                        2 ($02)= set if state proveides a the .state / .timer - interrupt function
;                        1 ($01)= set if state proveides a the .serial - interrupt function
;                     



; A state providing a .main, .vblank and unload function, would lock like thies
;    state_name::  DB %00111000 ; ($38)
;        DW .main
;        DW .unload
;        DW .vblank 
;        
;    .unload: /* Code goes here */ ret;
;    .main: /* Code goes here */ ret;
;    .vblank: /* Code goes here */ ret;


/*==============================================================================
 ## swtich_state(n16 state_definition_adress)
 changes, what state is currently executed
 ------------------------------------------------------------------------------
 ### Input:
   - state_definition_adress: the adress of the State-Structure, that defines the
                              the adresses of the new functions 
 ### Destroys:
   - BC
 ============================================================================*/
MACRO change_state
    ld bc, \1
    call _load_new_state_from_bc
ENDM