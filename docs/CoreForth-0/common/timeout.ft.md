    variable tick
    variable timeout

    : set-timeout   tick @ + timeout ! ;
    : timeout?      tick @ timeout @ = $6f74 and throw ;

    : forever       begin dup execute standby again drop ;
    : ticks-do      standby begin ?dup while over execute standby 1- repeat drop ;
    : ticks-delay   begin ?dup while standby 1- repeat ;
