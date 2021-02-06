BOARD ?= CoreForth-0/cortex-stc/boards/thumbulator-m3.ft

%.hex : %.ft
	gforth $< $(BOARD)

%.bin : %.hex
	arm-eabi-objcopy -I ihex -O binary $< $@

all: janus.bin janus.hex
	# hexdump -Cv janus.bin | tail -15

.PHONY: clean
clean:
	rm -f *.hex *.bin
