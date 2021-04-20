TARGET ?= cortex
BOARD ?= thumbulator-m3
THREADING ?= stc

SRC = CoreForth-0/$(TARGET)/boards/$(BOARD).ft
HEX = $(BOARD)-$(THREADING).hex

$(HEX) : $(SRC) janus.ft
	gforth janus.ft -f $(SRC) --$(THREADING)

all: $(HEX)

.PHONY: clean
clean:
	rm -f *.hex *.bin
