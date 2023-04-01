/*==============================================================================
 ## fill_mem(n16 adress, n16 length, n8 fillbyte)
 Fill a number of bytes at address HL with the value stored in A
 ------------------------------------------------------------------------------
 ### Input:
   - adress:  memory adress from which to fill
   - length: number of bytes to fill
   - fillbyte: byte to fill the memory with

 ### Destroys:
   - AF
   - HL
   - BC
 ============================================================================*/
MACRO fill_mem
    ld hl, \1
    ld a, \3 
    ld bc, \2
    call _fill_BC_bytes_at_HL_with_A
ENDM

/*==============================================================================
 ## set_mem_bit(n16 memory adress,  n3 bit)
 sets a bit of a byte in memory to 1 
 Cycles: 7
 ------------------------------------------------------------------------------
 ### Input:
   - memory = adress of the byte to change in memory
   - bit = the bit to change 0 = most right; 7 = most left
 ------------------------------------------------------------------------------
 ### Destroys: 
   - HL  
 ============================================================================*/
MACRO set_mem_bit 
    ld hl, \1
    set \2, [hl]
ENDM

/*==============================================================================
 ## reset_mem_bit(n16 memory adress,  n3 bit)
 sets a bit of a byte in memory to 0 
 Cycles: 7
 ------------------------------------------------------------------------------
 ### Input:
   - memory = adress of the byte to change in memory
   - bit = the bit to change 0 = most right; 7 = most left
 ------------------------------------------------------------------------------
 ### Destroys: 
   - HL  
 ============================================================================*/
MACRO reset_mem_bit 
    ld hl, \1
    res \2, [hl]
ENDM