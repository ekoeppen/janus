          variable hp
      $20 constant bl

    : cr            #13 emit #10 emit ;
    : space         bl emit ;
    : spaces        begin ?dup while space 1- repeat ;
    : type          begin dup while swap dup c@ emit 1+ swap 1- repeat 2drop ;
    : xon           $11 emit ;
    : xoff          $13 emit ;

    : <#            pad $20 + hp ! ;
    : hold          1 hp -! hp @ c! ;
    : >digit        dup 9 > 7 and + #48 + ;
    : #             base @ u/mod swap >digit hold ;
    : #s            begin # dup 0= until ;
    : #>            drop hp @ pad $20 + over - ;
    : sign          0< if $2D hold then ;
    : (u.)          base @ u/mod ?dup if recurse then >digit emit ;
    : u.            (u.) space ;
    : .             dup 0< if [char] - emit abs then u. ;

    : hex. ( n -- ) base @ swap hex <# # # # # # # # # #> type base ! ;
    : h.4  ( n -- ) base @ swap hex <# # # # # #> type base ! ;
    : h.2  ( n -- ) base @ swap hex <# # # #> type base ! ;
    : b.8  ( n -- ) base @ swap binary <# # # # # # # # # #> type base ! ;
    : b.   ( n -- ) base @ swap binary u. base ! ;
