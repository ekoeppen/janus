    : >tether-word  dup #24 rshift emit
                    dup #16 rshift emit
                    dup #8 rshift emit
                    emit ;

    : tether-word>  key
                    #8 lshift key +
                    #8 lshift key +
                    #8 lshift key + ;

    : tether-store  tether-word> tether-word> swap ! ;
    : tether-fetch  tether-word> @ >tether-word ;
    : tether-number tether-word> ;
    : tether-exec   tether-word> execute ;

    : tether-cmd    dup [char] ! = if drop tether-store exit then
                    dup [char] @ = if drop tether-fetch exit then
                    dup [char] # = if drop tether-number exit then
                    [char] X = if tether-exec then
                    ;

    : tether-loop   begin key tether-cmd 4 emit again ;
