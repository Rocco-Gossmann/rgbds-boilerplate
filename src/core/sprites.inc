include "core/memory.inc"

SPRITE_X equ 1
SPRITE_Y equ 0
SPRITE_TILE equ 2 

SPRITE_FLAGS equ 3

SPRITE_FLAG_PRIO equ 7 
SPRITE_FLAG_YFLIP equ 6 
SPRITE_FLAG_XFLIP equ 5 
SPRITE_FLAG_PAL equ 4 

SPRITE_FLAG_PRIO_TOP equ 0
SPRITE_FLAG_PRIO_BOTTOM equ 1

SPRITE_FLAG_NONE_FLIPPED equ 0
SPRITE_FLAG_FLIPPED equ 1

SPRITE_FLAG_PAL_0 equ 0
SPRITE_FLAG_PAL_1 equ 1

SPRITE_FLAG_BIN_PRIO equ 128 
SPRITE_FLAG_BIN_YFLIP equ 64 
SPRITE_FLAG_BIN_XFLIP equ 32 
SPRITE_FLAG_BIN_PAL equ 16 

MACRO sprites_clear
    fill_mem sprite_memory, $009F, 0 
ENDM

MACRO sprites_update
    call _sprites_update 
ENDM

MACRO sprite_load
    copy_mem \2, sprite_memory + (\1*4), 4
ENDM

