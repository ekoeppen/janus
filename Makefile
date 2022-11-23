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

.PHONY: docs
docs:
	rm -rf docs
	find * -type d | xargs -I % mkdir -p docs/%
	find * -name '*.f[ts]' | \
		xargs -I % sh -c "sed 's/^\([^\]\)/    \1/;s/\\\ //;s/\\\//;s/    include \(.*\)/[\1](\1.md)\\n/' % >docs/%.md"
