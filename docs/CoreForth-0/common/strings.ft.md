    : dup$          2dup ;
    : drop$         2drop ;
    : swap$         2swap ;
    : over$         2over ;
    : r@$           2r@ ;
    : nip$          2nip ;
    : c@$           + c@ ;
    : count$        nip ;

    : append$       ( c-addr n c-addr1 n1 -- c-addr n+n1 )
                    swap$ dup$ 2>r +
                    swap dup >r
                    cmove
                    2r> + r> swap ;

    : cappend$      ( c-addr n c -- c-addr n+1 )
                    >r dup$ + r> swap c! 1+ ;

    : find<$        ( c-addr n c -- n -1 | 0 )
                    over 0= if drop nip exit then
                    >r begin
                      dup 0> while
                      1- dup$ c@$ r@ <> while
                    repeat then
                    2dup + c@ r> = if nip true else 2drop 0 then
                    ;

    : tail$         ( c-addr n t -- c-addr+t n-t )
                    rot over + -rot - ;
