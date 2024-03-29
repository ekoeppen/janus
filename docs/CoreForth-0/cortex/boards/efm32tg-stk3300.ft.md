vim:ft=forth:ts=2:sw=2:expandtab:foldmethod=marker:foldmarker=\\ --\ ,\\\ ---:

    $00000080 constant init-cold
    $00000084 constant init-latest
    $00000088 constant init-dp
    $0000008C constant init-vp

    $7C buffer: rsp variable s0_
    $7C buffer: psp variable r0_
    $80 buffer: tib

    variable dp
    variable vp
    variable latest
    variable state
    variable (source)
    variable source#
    variable >in
    variable current
    variable base
    variable hp

    $00000080 constant tib#
    $20000C00 constant s0
    $20000D00 constant r0
    $20001000 constant ram-top

[../cpus/cortex-m0/core.ft](../cpus/cortex-m0/core.ft.md)


[../cpus/efm32tg/cmu.ft](../cpus/efm32tg/cmu.ft.md)

[../cpus/efm32tg/gpio.ft](../cpus/efm32tg/gpio.ft.md)

[../cpus/efm32tg/usart.ft](../cpus/efm32tg/usart.ft.md)


    code reset-handler $4668 $3820 $0006 $4801 $6800 $4687 $0080 $0000 end-code

    : emit          USART1_TXDATA c!
                    begin USART1_STATUS @ %100000 and until ;
    : key?          USART1_STATUS @ %10000000 and ;
    : key           begin key? until USART1_RXDATA c@ ;

[../../common/io.ft](../../common/io.ft.md)

[../../common/utils.ft](../../common/utils.ft.md)

[../cpus/cortex-m0/compiler.ft](../cpus/cortex-m0/compiler.ft.md)


    : init-cmu      %0000000100000000 CMU_HFPERCLKDIV bis!
                    %0000000001001000 CMU_HFPERCLKEN0 bis!
                    %0000000000010000 CMU_OSCENCMD bis! ;
    : init-gpio     %0000000000010100 GPIO_PD_MODEL ! ;
    : init-usart    7424 USART1_CLKDIV !
                    %01100000 USART1_CTRL bis!
                    %000100000011 USART1_ROUTE !
                    %0101 USART1_CMD ! ;

    : init-hw init-cmu init-gpio init-usart ;

    : cold          init-hw 10000 delay abort ;
