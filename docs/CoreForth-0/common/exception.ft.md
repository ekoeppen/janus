    variable handler

    : catch         sp@ >r handler @ >r rp@ handler !
                    execute
                    r> handler !  r> drop 0 ;

    : throw         ?dup 0= if exit then
                    handler @ rp!
                    r> handler !
                    r> swap >r
                    sp! drop r> ;
