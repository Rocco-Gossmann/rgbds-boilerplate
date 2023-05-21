# Project
#-------------------------------------------------------------------------------
TARGET		:= $(notdir $(CURDIR))
SOURCES     := $(shell ls -R ./src | grep ./ |  sed -e s/://g | sed -e s/\\n/" "/g)

# Source Files 
#-------------------------------------------------------------------------------
ASMFILES    := $(foreach dir,$(SOURCES), $(wildcard $(dir)/*.asm))
OBJFILES    := $(addsuffix .obj, $(ASMFILES))
DIRS        := $(addprefix -i, $(SOURCES))

# Debug Build
#-------------------------------------------------------------------------------
debug: ASMFLAGS =
debug: $(OBJFILES) # Debug build gets version with nintendo logo + symbol export
	rgblink -t -o$(TARGET).debug.gb -n$(TARGET).debug.sym $(OBJFILES)
	rgbfix -v $(TARGET).debug.gb 


# Release Build
#-------------------------------------------------------------------------------
release: ASMFLAGS =  
release: $(OBJFILES) # release ignores symbols, trashes the logo, fixes global checksum, fix header checksum
	rgblink -t -o$(TARGET).gb $(OBJFILES)
	rgbfix -f Lgh $(TARGET).gb  


# Misc
#-------------------------------------------------------------------------------
%.asm.obj: %.asm #\
	 -L = dont optize ld [FFxx] to ldh [FFxx] \
	 -l = dont add NOP after halt 
	rgbasm -h -L $(ASMFLAGS) $(DIRS) -o$@ $<


# Phonys
#-------------------------------------------------------------------------------
.phony: clean,run

run: debug
	bgb $(TARGET).debug.gb 

clean:
	@rm -f $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.asm.obj))
	@rm -f $(wildcard $(TARGET).*)
