    0 constant r/w
    0 constant w/o
    1 constant r/o

    $2000 buffer: #include-stack
    variable include-stack#
    $400 buffer: tmp-path

    : include-stack #include-stack include-stack# @ ;

    : include-stack@
                    include-stack dup$ [char] : find<$ 0= if drop$ s" ." exit then
                    1+ tail$
                    ;

    : >include-stack
                    include-stack [char] : cappend$ dup include-stack# !
                    swap$ append$ include-stack# ! drop
                    ;

    : include-stack>
                    include-stack dup$ [char] : find<$ 0= if drop$ s" ." exit then
                    dup >r 1+ tail$ r> include-stack# !
                    ;

    : dirname       dup$ [char] / find<$ if
                      ?dup if nip else drop$ s" /" then
                    else
                      drop$ s" ."
                    then
                    ;

    : basename      dup$ [char] / find<$ if 1+ dup >r - r> rot + swap exit then ;

    : make-path     ( c-addr-t n-t c-addr-s n-s -- c-addr-t n-t+n-s)
                    over$ 0> swap c@ [char] / <> and if
                      include-stack@ append$
                      [char] / cappend$ swap$ append$
                    else drop$
                    then
                    dup$ dirname >include-stack
                    ;

    : get-dir       over swap pwd ;

Copy the absolute path for a given absolute or relative path to
a string:

    : read-line     swap dup >r 0 do
                      dup getc dup 0< if drop 2drop i false 0 unloop rdrop exit then
                               dup #10 = if drop 2drop i true 0 unloop rdrop exit then
                      rot tuck i + c! swap
                    loop
                    2drop r> true 0
                    ;

    : included      source-id >r
                    tmp-path 0 make-path r/o open-file throw (source-id) !
                    begin
                      tib dup tib# source-id read-line throw while
                      dup$ type cr
                      ['] evaluate catch if ex. space tib >in @ type cr bye then
                    repeat
                    2drop
                    source-id close-file throw
                    r> (source-id) !
                    include-stack> drop$
                    ;

    : include       bl word count included ;

    : arg           pad $100 rot (arg) pad swap ;
    : argc          (argc) pad tuck ! ;

    : emit-file     swap putc ;
    : key-file      getc ;
