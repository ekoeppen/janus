    : key           source-id getc ;

    : accept        ( c-addr +n -- +n'   get line from terminal )
                    over + 1- over
                    begin key
                    dup $0A <> over -1 <> and while
                    over c!  1+ over umin
                    repeat
                    drop nip swap -
                    ;
