------------------------------------------------------------------------
    TESTING <# # #S #> HOLD SIGN BASE >NUMBER HEX DECIMAL

    : S=  ( ADDR1 C1 ADDR2 C2 -- T/F ) COMPARE TWO STRINGS.
       >R SWAP R@ = IF         MAKE SURE STRINGS HAVE SAME LENGTH
          R> ?DUP IF         IF NON-EMPTY STRINGS
        0 DO
           OVER C@ OVER C@ - IF 2DROP <FALSE> UNLOOP EXIT THEN
           SWAP CHAR+ SWAP CHAR+
             LOOP
          THEN
          2DROP <TRUE>         IF WE GET HERE, STRINGS MATCH
       ELSE
          R> DROP 2DROP <FALSE>      LENGTHS MISMATCH
       THEN ;

    : GP1  <# 41 HOLD 42 HOLD 0 #> S" BA" S= ;
    T{ GP1 -> <TRUE> }T

    : GP2  <# -1 SIGN 0 SIGN -1 SIGN 0 #> S" --" S= ;
    T{ GP2 -> <TRUE> }T

    : GP3  <# 1 # # #> S" 01" S= ;
    T{ GP3 -> <TRUE> }T

    : GP4  <# 1 #S #> S" 1" S= ;
    T{ GP4 -> <TRUE> }T

    24 CONSTANT MAX-BASE         BASE 2 .. 36
    : COUNT-BITS
       0 0 INVERT BEGIN DUP WHILE >R 1+ R> 2* REPEAT DROP ;
    COUNT-BITS 2* CONSTANT #BITS-UD      NUMBER OF BITS IN UD

    : GP5
       BASE @ <TRUE>
       MAX-BASE 1+ 2 DO         FOR EACH POSSIBLE BASE
          I BASE !            TBD: ASSUMES BASE WORKS
          I <# #S #> S" 10" S= AND
       LOOP
       SWAP BASE ! ;
    T{ GP5 -> <TRUE> }T

    : GP6
       BASE @ >R  2 BASE !
       MAX-UINT MAX-UINT <# #S #>      MAXIMUM UD TO BINARY
       R> BASE !            S: C-ADDR U
       DUP #BITS-UD = SWAP
       0 DO               S: C-ADDR FLAG
          OVER C@ [CHAR] 1 = AND      ALL ONES
          >R CHAR+ R>
       LOOP SWAP DROP ;
T{ GP6 -> <TRUE> }T

    : GP7
       BASE @ >R    MAX-BASE BASE !
       <TRUE>
       A 0 DO
          I <# #S #>
          1 = SWAP C@ I 30 + = AND AND
       LOOP
       MAX-BASE A DO
          I <# #S #>
          1 = SWAP C@ 41 I A - + = AND AND
       LOOP
       R> BASE ! ;

    T{ GP7 -> <TRUE> }T

>NUMBER TESTS
    CREATE GN-BUF 0 C,
    : GN-STRING   GN-BUF 1 ;
    : GN-CONSUMED   GN-BUF CHAR+ 0 ;
    : GN'      [CHAR] ' WORD CHAR+ C@ GN-BUF C!  GN-STRING ;

    T{ 0 GN' 0' >NUMBER -> 0 GN-CONSUMED }T
    T{ 0 GN' 1' >NUMBER -> 1 GN-CONSUMED }T
    T{ 1 GN' 1' >NUMBER -> BASE @ 1+ GN-CONSUMED }T
    T{ 0 GN' -' >NUMBER -> 0 GN-STRING }T   SHOULD FAIL TO CONVERT THESE
    T{ 0 GN' +' >NUMBER -> 0 GN-STRING }T
    T{ 0 GN' .' >NUMBER -> 0 GN-STRING }T

    : >NUMBER-BASED
       BASE @ >R BASE ! >NUMBER R> BASE ! ;

    T{ 0 GN' 2' 10 >NUMBER-BASED -> 2 GN-CONSUMED }T
    T{ 0 GN' 2'  2 >NUMBER-BASED -> 0 GN-STRING }T
    T{ 0 GN' F' 10 >NUMBER-BASED -> F GN-CONSUMED }T
    T{ 0 GN' G' 10 >NUMBER-BASED -> 0 GN-STRING }T
    T{ 0 GN' G' MAX-BASE >NUMBER-BASED -> 10 GN-CONSUMED }T
    T{ 0 GN' Z' MAX-BASE >NUMBER-BASED -> 23 GN-CONSUMED }T

    : GN1   ( U BASE -- U' LEN ) U SHOULD EQUAL U' AND LEN SHOULD BE ZERO.
       BASE @ >R BASE !
       <# #S #>
       0 -ROT >NUMBER SWAP DROP      RETURN LENGTH ONLY
       R> BASE ! ;
    T{ 0 2 GN1 -> 0 0 }T
    T{ MAX-UINT 2 GN1 -> MAX-UINT 0 }T
    T{ 0 MAX-BASE GN1 -> 0 0 }T
    T{ MAX-UINT MAX-BASE GN1 -> MAX-UINT 0 }T

    : GN2   ( -- 16 10 )
       BASE @ >R  HEX BASE @  DECIMAL BASE @  R> BASE ! ;
    T{ GN2 -> 10 A }T