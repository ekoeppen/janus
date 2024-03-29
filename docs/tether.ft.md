    ::host::

    variable tether-fd

    create #target-shadow target# allot

    0 constant black
    1 constant red
    2 constant green
    3 constant yellow
    4 constant blue
    5 constant magenta
    6 constant cyan
    7 constant white

    : -fg-color         #27 emit ." [0m" ;
    : +fg-color         #27 emit [char] [ emit
                        dup 8 < if #48 + [char] 3
                        else #40 + [char] 9
                        then emit emit [char] m emit ;
    : hi                8 + ;

    : open              tether-port count r/w open-file throw tether-fd ! ;
    : close             tether-fd @ close-file throw ;
    : stty              s" stty -f " pad place
                        tether-port count pad +place
                        s"  raw speed " pad +place
                        tether-speed count pad +place
                        pad count system ;

    : >tether-byte      tether-fd @ emit-file throw ;
    : tether-byte>      tether-fd @ key-file ;

    : >tether-word      dup #24 rshift >tether-byte
                        dup #16 rshift >tether-byte
                        dup #8 rshift >tether-byte
                        >tether-byte
                        ;

    : await-done        begin tether-byte> dup 4 <> while emit repeat drop ;

    : cell-mask         1 tcell 8 * lshift 1- ;
    : cell@             tcell * + @ cell-mask and ;

    : send-delta        target# tcell / 0 do
                          #target i cell@
                          #target-shadow i cell@
                          over <> if
                            [char] ! >tether-byte
                            trom i tcell * + >tether-word
                            >tether-word
                            await-done
                          else drop
                          then
                        loop
                        ;

    : reset-delta       #target #target-shadow target# move ;

    : is-meta?          meta-wordlist search-wordlist ;
    : is-target?        target-wordlist search-wordlist ;
    : is-host?          forth-wordlist search-wordlist ;

    : target-execute    [char] X >tether-byte
                        >tether-word
                        await-done
                        ;
    : target-number     ?number invert if
                          2drop [char] ? emit cr exit
                        then
                        drop [char] # >tether-byte
                        >tether-word
                        await-done
                        ;

    : tstat             trom u. tram u. tdp @ u. tvp @ u. there u. cr ;
    : twords            target-wordlist >order words previous ;

    : do-meta           magenta +fg-color execute -fg-color ;
    : do-target         >body @ target-execute ;
    : do-host           blue +fg-color execute -fg-color ;

    : handle-word       2dup is-meta? if do-meta 2drop exit then
                        2dup is-target? if do-target 2drop exit then
                        2dup is-host? if do-host 2drop exit then
                        target-number
                        ;

    : untether          bye ;
    : tether            tether-port c@ 0= if exit then
                        cr ." Tethered." cr
                        open stty
                        ::target::
                        begin
                          reset-delta
                          accept
                          begin bl word dup c@ while
                            count
                            handle-word
                          repeat
                          drop
                          ." ok " .s cr
                          send-delta
                        again
                        ;
