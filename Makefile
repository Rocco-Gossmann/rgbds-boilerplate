# Project infos
#---------------------------------------------------------------------
TARGET		:= $(notdir $(CURDIR))
SOURCES     := $(shell ls -R ./src | grep ./ |  sed -e s/://g | sed -e s/\\n/" "/g)

# Export target
#---------------------------------------------------------------------
ASMFILES    := $(foreach dir,$(SOURCES), $(wildcard $(dir)/*.asm))
OBJFILES    := $(addsuffix .obj, $(ASMFILES))
DIRS        := $(addprefix -i, $(SOURCES))

debug: ASMFLAGS = -E
debug: $(OBJFILES) # Debug build gets version with nintendo logo + symbol export
	rgblink -t -o$(TARGET).debug.gb -n$(TARGET).sym $(OBJFILES)
	rgbfix -v $(TARGET).debug.gb 

release: ASMFLAGS = 
release: $(OBJFILES) # release ignores symbols, trashes the logo, fixes global checksum, fix header checksum
	rgblink -t -o$(TARGET).gb $(OBJFILES)
	rgbfix -f Lgh $(TARGET).gb  

run: debug
	bgb $(TARGET).debug.gb 

%.asm.obj: %.asm #\
	 -L = dont optize ld [FFxx] to ldh [FFxx] \
	 -l = dont add NOP after halt 
	rgbasm -h -L $(ASMFLAGS) $(DIRS) -o$@ $<

.phony: clean

clean:
	@rm -f $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.asm.obj))
	@rm -f $(wildcard $(TARGET).*)
