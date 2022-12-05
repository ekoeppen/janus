## Command line argument handling

Set the threading mode, currently only subroutine or direct threading is handled.
Default are `STC` as the threading type, and the first serial port for
tethering, reset the source file name to be read.

    : set-threading STC threading-type !
                    dup arg s" --dtc" str= if DTC
                    else dup arg s" --stc" str= if STC
                    else dup arg s" --itc" str= if ITC
                    else exit then then then
                    threading-type !  ;

Set the tethering parameters.

    : set-tethered  dup arg s" --tethered" str= tethered ! ;

    : set-tether-port
                    0 tether-port c!
                    dup arg s" --port" str= if
                      1+ dup arg tether-port place
                    then ;

    : set-tether-speed
                    s" 115200" tether-speed place
                    dup arg s" --speed" str= if
                      1+ dup arg tether-speed place
                    then ;

Set the main source file to load, this is in many cases the hardware board for
which to build a Forth.

    : set-source-file
                    0 source-file c!
                    dup arg s" -f" str= if
                      1+ dup arg source-file place
                    then ;

Process the command line arguments.

    : parse-args    0 begin dup argc @ < while
                      set-threading
                      set-tethered
                      set-tether-port
                      set-tether-speed
                      set-source-file
                      1+
                    repeat drop ;

Define conditional compliation helpers. Depending on the condition being checked,
ignore the rest of the line by executing the comment word `\`.

    : ::stc::       threading-type @ STC <> if postpone then ;
    : ::dtc::       threading-type @ DTC <> if postpone then ;
    : ::itc::       threading-type @ ITC <> if postpone then ;
    : ::tethered::   tethered @ 0= if postpone then ;
    : ::untethered:: tethered @ if postpone then ;
