-- Host ---------------------------------------------------------------------

    ::host::

[../../../tether.ft](../../../tether.ft.md)

[../janus/compiler.ft](../janus/compiler.ft.md)


    $08000000 to trom
    $20000000 to tram
            4 to tcell

    trom tdp !
    tram tvp !

    tram $00004000 + t, 0 t,
    trom $00000400 + torg

-- Target -------------------------------------------------------------------

    ::target::

[../cpus/cortex-m0/armv6-m-primitives.ft](../cpus/cortex-m0/armv6-m-primitives.ft.md)

    ::stc:: include ../cpus/cortex-m0/threading-stc.ft
    ::dtc:: include ../cpus/cortex-m0/threading-dtc.ft
    ::itc:: include ../cpus/cortex-m0/threading-itc.ft

    ::dtc::   $10 buffer: #docol
    ::dtc::   $10 buffer: #dodoes
              $FC buffer: psp
                 variable s0
              $FC buffer: rsp
                 variable r0

              $40 buffer: rxb
                 variable rx-head
                 variable rx-tail

              $40 buffer: txb
                 variable tx-head
                 variable tx-tail

             $40 constant #init
            $140 constant #vectors

            $380 constant backup-start
            $380 constant backup-cold
            $384 constant backup-latest
            $388 constant backup-dp
            $38C constant backup-vp

       $08020000 constant end-of-flash
            $400 constant #page

[../common/core.ft](../common/core.ft.md)

[../../common/core.ft](../../common/core.ft.md)

[../dictionary/common.ft](../dictionary/common.ft.md)


[../cpus/cortex-m0/nvic.ft](../cpus/cortex-m0/nvic.ft.md)

[../cpus/stm32f0xx/rcc.ft](../cpus/stm32f0xx/rcc.ft.md)

[../cpus/stm32f0xx/flash.ft](../cpus/stm32f0xx/flash.ft.md)

[../cpus/stm32f0xx/gpio.ft](../cpus/stm32f0xx/gpio.ft.md)

[../cpus/stm32f0xx/usart.ft](../cpus/stm32f0xx/usart.ft.md)


    : rbuf-ptr@    @ + c@ ;
    : rbuf-ptr!    @ + c! ;
    : rbuf-ptr++   dup @ 1+ $3F and swap ! ;

    : txb-empty?     tx-head @ tx-tail @ xor not ;
    : rxb-empty?     rx-head @ rx-tail @ xor not ;

    : !txb-empty?    tx-head @ tx-tail @ xor ;
    : !rxb-empty?    rx-head @ rx-tail @ xor ;

    : usart2-tx-handler
                    %10000000 USART2_ISR bit@ !txb-empty? and if
                      txb tx-tail rbuf-ptr@ USART2_TDR !
                      tx-tail rbuf-ptr++
                    else
                     %10000000 USART2_CR1 bic!
                    then
                    ;

    : usart2-rx-handler
                    %00100000 USART2_ISR bit@ if
                      USART2_RDR @ rxb rx-head rbuf-ptr!
                      rx-head rbuf-ptr++
                    then
                    ;

    i: usart2-handler
                    usart2-tx-handler
                    usart2-rx-handler
                    ;i

    : emit          !txb-empty? if begin wfi txb-empty? until then
                    txb tx-head rbuf-ptr!
                    tx-head rbuf-ptr++
                    %10000000 USART2_CR1 bis!
                    ;

    : key?          !rxb-empty? ;
    : key           rxb-empty? if begin wfi !rxb-empty? until then
                    rxb rx-tail rbuf-ptr@
                    rx-tail rbuf-ptr++ ;

[../../common/output.ft](../../common/output.ft.md)

[../../common/input.ft](../../common/input.ft.md)

[../dictionary/full.ft](../dictionary/full.ft.md)

    ::stc:: include ../common/threading-stc.ft
    ::dtc:: include ../common/threading-dtc.ft
    ::itc:: include ../common/threading-itc.ft
[../../common/exception.ft](../../common/exception.ft.md)

[../../common/control-flow.ft](../../common/control-flow.ft.md)

[../common/compiler.ft](../common/compiler.ft.md)

[../../common/interpret.ft](../../common/interpret.ft.md)

[../../common/utils.ft](../../common/utils.ft.md)

[../common/tether.ft](../common/tether.ft.md)


[../janus/init.ft](../janus/init.ft.md)


    : 48mhz         %1 FLASH_ACR bis!
                    %1010000000000000000000 RCC_CFGR bis!
                    %1000000000000000000000000 RCC_CR bis!
                    %10 RCC_CFGR bis!
                    ;

    : usart2-src!   #16 lshift RCC_CFGR3 tuck @ $FFFCFFFF and or swap ! ;

    : setup-uart2   %00100000000000000000 RCC_APB1ENR bis!
                    0 dup dup dup tx-head ! tx-tail ! rx-head ! rx-tail !
                    3 usart2-src!
                    GPIOA_MODER dup @ $FFFFFF0F and $A0 or swap !
                    GPIOA_AFRL dup @ $FFFF00FF and $1100 or swap !
                    #69 USART2_BRR !
                    %00001101 USART2_CR1 bis!
                    ;

    : +usart2-irq   %10100000 USART2_CR1 bis!
                    1 #28 lshift NVIC_SETENA_BASE bis! ;

    : setup-hw      %00100000000000000000 RCC_AHBENR !
                    GPIOA_MODER dup @ $FFFFF3FF and $400 or swap !
                    48mhz
                    setup-uart2
                    +usart2-irq
                    ;

    ::tethered:: : abort ;

    : dict-space    backup-dp @ #page + #page 1- invert and ;
    : cold          s0 sp! r0 rp! setup-vars setup-hw
                    ." CoreForth-0 " .threading ."  ready" cr
                    0 (source-id) ! hex
    ::stc::         init-dp @ backup-dp @ = if dict-space org then
    ::tethered::    4 emit tether-loop
                    abort ;

-- Host ---------------------------------------------------------------------

    ::host::

[../janus/tether.ft](../janus/tether.ft.md)


    tether

    ::dtc:: t' #docol $0C + t@ t' ,enter 8 + t!
    ::dtc:: t' #dodoes $0C + t@ t' ,dodoes 8 + t!

[../janus/save-image.ft](../janus/save-image.ft.md)


    t' usart2-handler 1+ trom $000000b0 + t!

    ::dtc:: s" nucleo-f072rb-dtc.hex" save-hex
    ::itc:: s" nucleo-f072rb-itc.hex" save-hex
    ::stc:: s" nucleo-f072rb-stc.hex" save-hex
