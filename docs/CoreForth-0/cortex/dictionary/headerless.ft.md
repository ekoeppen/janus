    : link>flags    ;
    : link>name     ;
    : >body         ;
    : link>         ;
    : ,link         drop ;
    : visible?      false ;
    : immediate?    false ;

    : latest-flags  0 0 ;
    : immediate     ;
    : hide          ;
    : reveal        ;

    : <builds       align here latest ! ;
