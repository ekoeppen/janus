------------------------------------------------------------------------
    TESTING HERE , @ ! CELL+ CELLS C, C@ C! CHARS 2@ 2! ALIGN ALIGNED +! ALLOT

    HERE 1 ALLOT
    HERE
    CONSTANT 2NDA
    CONSTANT 1STA
    T{ 1STA 2NDA U< -> <TRUE> }T      HERE MUST GROW WITH ALLOT
    T{ 1STA 1+ -> 2NDA }T         ... BY ONE ADDRESS UNIT
    ( MISSING TEST: NEGATIVE ALLOT )

Added by GWJ so that ALIGN can be used before , (comma) is tested
    1 ALIGNED CONSTANT ALMNT   -- 1|2|4|8 for 8|16|32|64 bit alignment
    ALIGN
    T{ HERE 1 ALLOT ALIGN HERE SWAP - ALMNT = -> <TRUE> }T
End of extra test

    HERE 1 ,
    HERE 2 ,
    CONSTANT 2ND
    CONSTANT 1ST
    T{ 1ST 2ND U< -> <TRUE> }T         HERE MUST GROW WITH ALLOT
    T{ 1ST CELL+ -> 2ND }T         ... BY ONE CELL
    T{ 1ST 1 CELLS + -> 2ND }T
    T{ 1ST @ 2ND @ -> 1 2 }T
    T{ 5 1ST ! -> }T
    T{ 1ST @ 2ND @ -> 5 2 }T
    T{ 6 2ND ! -> }T
    T{ 1ST @ 2ND @ -> 5 6 }T
    T{ 1ST 2@ -> 6 5 }T
    T{ 2 1 1ST 2! -> }T
    T{ 1ST 2@ -> 2 1 }T
    T{ 1S 1ST !  1ST @ -> 1S }T      CAN STORE CELL-WIDE VALUE

    HERE 1 C,
    HERE 2 C,
    CONSTANT 2NDC
    CONSTANT 1STC
    T{ 1STC 2NDC U< -> <TRUE> }T      HERE MUST GROW WITH ALLOT
    T{ 1STC CHAR+ -> 2NDC }T         ... BY ONE CHAR
    T{ 1STC 1 CHARS + -> 2NDC }T
    T{ 1STC C@ 2NDC C@ -> 1 2 }T
    T{ 3 1STC C! -> }T
    T{ 1STC C@ 2NDC C@ -> 3 2 }T
    T{ 4 2NDC C! -> }T
    T{ 1STC C@ 2NDC C@ -> 3 4 }T

    ALIGN 1 ALLOT HERE ALIGN HERE 3 CELLS ALLOT
    CONSTANT A-ADDR  CONSTANT UA-ADDR
    T{ UA-ADDR ALIGNED -> A-ADDR }T
    T{    1 A-ADDR C!  A-ADDR C@ ->    1 }T
    T{ 1234 A-ADDR  !  A-ADDR  @ -> 1234 }T
    T{ 123 456 A-ADDR 2!  A-ADDR 2@ -> 123 456 }T
    T{ 2 A-ADDR CHAR+ C!  A-ADDR CHAR+ C@ -> 2 }T
    T{ 3 A-ADDR CELL+ C!  A-ADDR CELL+ C@ -> 3 }T
    T{ 1234 A-ADDR CELL+ !  A-ADDR CELL+ @ -> 1234 }T
    T{ 123 456 A-ADDR CELL+ 2!  A-ADDR CELL+ 2@ -> 123 456 }T

    : BITS ( X -- U )
       0 SWAP BEGIN DUP WHILE DUP MSB AND IF >R 1+ R> THEN 2* REPEAT DROP ;
    ( CHARACTERS >= 1 AU, <= SIZE OF CELL, >= 8 BITS )
    T{ 1 CHARS 1 < -> <FALSE> }T
    T{ 1 CHARS 1 CELLS > -> <FALSE> }T
    ( TBD: HOW TO FIND NUMBER OF BITS? )

    ( CELLS >= 1 AU, INTEGRAL MULTIPLE OF CHAR SIZE, >= 16 BITS )
    T{ 1 CELLS 1 < -> <FALSE> }T
    T{ 1 CELLS 1 CHARS MOD -> 0 }T
    T{ 1S BITS 10 < -> <FALSE> }T

    T{ 0 1ST ! -> }T
    T{ 1 1ST +! -> }T
    T{ 1ST @ -> 1 }T
    T{ -1 1ST +! 1ST @ -> 0 }T