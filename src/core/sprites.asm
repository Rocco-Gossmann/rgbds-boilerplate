include "hardware.inc"
include "memory.inc"
include "utils.inc"

;===============================================================================
SECTION "core_sprite_oam_mirror", WRAM0,ALIGN[8] ;<- needs to be aligend to 8 bit
; means   $0100, $0200, $0300, ... and so on.
;
; This gives us sprites memory, that can be manipulated at any time. 
; (Instead of only during VBlank, like VRAM)
; by using `call sprites_update` during VBLANK, all the date of this memory
; is transfered to the OAMs Memory via direct media access
;-------------------------------------------------------------------------------
sprite_memory:: DS 160   ; (40 sprites * 4byte) = 160 Byte = OAM Size

;===============================================================================
SECTION "sprites_core_code", ROM0
;-------------------------------------------------------------------------------

;===============================================================================
load_sprites_update: LOAD "RAM core_sprite_code", HRAM 
; AFAIK, this --------/\  will reserve a chunk of ram, the size of this blocks
; content. 
; The label given to this block marks its content in ROM0. That way it can be
; Copied to its destination in RAM later
; All labels defined in this block will point to some RAM adress.
;-------------------------------------------------------------------------------

_sprites_update:: ; <- This label marks the contents name in RAM
                  ;    this is also, what we have to call later
    push af
    ld a, HIGH(sprite_memory)
    ld [cDMA], a
    ld a, $28 

:        dec a
        jr nz, :- 

    pop af 
    ret
    .end

;===============================================================================
ENDL ; End the Load block
;-------------------------------------------------------------------------------

_sprites_init::
    copy_mem load_sprites_update, _sprites_update, _sprites_update.end - _sprites_update
    ret

