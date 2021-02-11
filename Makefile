BOARD ?= CoreForth-0/cortex/boards/thumbulator-m3.ft
THREADING ?= stc

%.hex : %.ft
	gforth $< $(BOARD) $(THREADING)

%.bin : %.hex
	arm-eabi-objcopy -I ihex -O binary $< $@

all: janus.bin janus.hex
	# hexdump -Cv janus.bin | tail -15

.PHONY: clean
clean:
	rm -f *.hex *.bin
