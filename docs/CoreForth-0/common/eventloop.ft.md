    : (run-action)  ( tick e -- tick' e' )
                    2dup @ = if cell+ dup @ ?dup
                      if execute else nip -1 swap then
                    else cell+
                    then cell+ ;

    : run-loop      ( loop exit'-- )
                    >r 0 begin
                      over begin dup @ -1 <> while (run-action) repeat drop
                      standby 1+
                      r@ execute
                    until 2drop rdrop ;
