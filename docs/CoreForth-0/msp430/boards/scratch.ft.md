    words
    reset

    +flash-write
    $40 buffer: rx-buffer
    save turnkey
    lock-flash

    : t %10000000 irqflags1 begin 2dup rf@ and until 2drop ;
    t
    timeout?
    : r? ntc u. ;
    ' r? #10 ticks-do
    wdt>timeout
    wdt/250ms
    tick @ u. timeout @ u.



    decimal
    sensor-loop ' btn? run-loop setup-ports
    ntc.  vcc.

    %01110000 dup p1sel bis! p1sel2 bis!

-----------------------------------------------------------------------

    : pwr-down-btn  standby-ports
                    begin +led $40 emit -led standby btn? until
                    setup-ports ;

    create txdata $D8 c, $40 c, $1A c, $00 c, $00 c, $0C c, $E4 c,
    txdata 6 dump
    +rf-reset -rf-reset

    pad 5 rf-tx
    rx-buffer 40 0 fill
    rf.
    -rf-pwr
    rf-init
    rx-buffer 5 rf-rx
    rx-buffer 40 dump

--- Testing -------------------------------------------------------

    code test-data  $12b0 dovar $d807 $1a40 $0000 $e40c end-code
