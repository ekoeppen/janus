%.hex : %.ft
	gforth $<

%.bin : %.hex
	arm-eabi-objcopy -I ihex -O binary $< $@

all: hybris.bin hybris.hex
	hexdump -Cv hybris.bin | tail -15

.PHONY: clean
clean:
	rm -f *.hex *.bin
