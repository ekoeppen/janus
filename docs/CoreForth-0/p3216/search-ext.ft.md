    variable #order
    16 cells buffer: context
    variable compilation-wordlist
    variable forth-wordlist

    : latest        context @ ;

    : get-order     #order @ >r begin
                      r> dup 0<> while
                      1- dup cells context + @ swap >r
                    repeat drop #order @
                    ;

    : set-order     ?dup 0= if exit then
                    dup -1 = if drop forth-wordlist 1 then 
                    #order ! 
                    0 >r begin
                      r> dup #order @ <> while
                      tuck cells context + !
                      1+ >r
                    repeat drop
                    ;

    : >order        >r get-order 1+ r> swap set-order ;

    : order         #order @ ?dup 0= if exit then
                    >r 0 begin
                      dup r@ < while
                      dup cells context + @ . 1+
                    repeat drop rdrop
                    ;

    : only          1 #order ! forth-wordlist context ! ;
    : previous      get-order nip 1- set-order ;

    : forth         get-order nip forth-wordlist swap set-order ;

    : also          get-order over swap 1+ set-order ;

    : set-current   compilation-wordlist ! ;
    : get-current   compilation-wordlist @ ;

    : definitions   context @ set-current ;

    : wordlist      0 here tuck ! cell allot ;
