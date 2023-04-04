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
 ## copy_mem(n16 srcadress, n16 destadress, n16 numbytes)
 Copy a number of bytes from source to des
 ------------------------------------------------------------------------------
 ### Input:
   - srcadress: memory adress from which to read the data
   - destadress: memory adress to which to write the data
   - numbytes: number of bytes to be written

 ### Destroys:
   - AF
   - HL
   - BC
   - DE
 ============================================================================*/
MACRO copy_mem
    ld de, \1
    ld hl, \2
    ld bc, \3
    call _copy_BC_bytes_from_DE_to_HL
ENDM

/*==============================================================================
 ## set_byte(n16 adress, n8|r8 byte)
 Set a byte in memory
 ------------------------------------------------------------------------------
 ### Input:
   - adress: the adress of the byte to set in memory
   - byte: The value to write to memory

 ### Destroys:
   - AF
 ============================================================================*/
MACRO set_byte
    ld a, \2 
    ld [\1], a
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