    variable (dp)
    variable vp
    variable ram?
    variable latest

    $0040 constant immediate-flag
    $0080 constant visible-flag

    : dp            ram? @ if vp else (dp) then ;
    : pad           vp @ $10 + aligned ;
    : here          dp @ ;
    : allot         here + dp ! ;
    : org           dp ! ;
    : h,            here h! 2 allot ;
    : c,            here c! 1 allot ;
    : ,             dup h, #16 rshift h, ;

    : align         here aligned org ;
