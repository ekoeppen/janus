    variable dp
    variable vp

    : here          dp @ ;
    : allot         here + dp ! ;
    : org           dp ! ;
    : ,             here ! cell allot ;
    : c,            here c! 1 allot ;
    : alloc         vp +! ;
    : pad           vp @ $10 + aligned ;
