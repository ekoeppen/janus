    : parse-code    begin  bl word  dup c@ while
                      find ?dup if
                        1+ if execute else , then
                      else
                        ?number if
                          h,
                        else count type [char] ? emit cr then
                      then
                    repeat drop ;

    : read-code     ] begin
                      parse-code
                      state @ 0= if exit then
                      refill
                    0= until ;

    : code <builds  read-code ; immediate

    : end-code      [ ; immediate
