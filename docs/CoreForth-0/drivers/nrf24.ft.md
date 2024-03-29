    $00 constant RF:CONFIG
    $01 constant RF:EN_AA
    $02 constant RF:EN_RXADDR
    $03 constant RF:SETUP_AW
    $04 constant RF:SETUP_RETR
    $05 constant RF:RF_CH
    $06 constant RF:RF_SETUP
    $07 constant RF:STATUS
    $08 constant RF:OBSERVE_TX
    $09 constant RF:RPD
    $0A constant RF:RX_ADDR_P0
    $0B constant RF:RX_ADDR_P1
    $0C constant RF:RX_ADDR_P2
    $0D constant RF:RX_ADDR_P3
    $0E constant RF:RX_ADDR_P4
    $0F constant RF:RX_ADDR_P5
    $10 constant RF:TX_ADDR
    $11 constant RF:RX_PW_P0
    $12 constant RF:RX_PW_P1
    $13 constant RF:RX_PW_P2
    $14 constant RF:RX_PW_P3
    $15 constant RF:RX_PW_P4
    $16 constant RF:RX_PW_P5
    $17 constant RF:FIFO_STATUS
    $1C constant RF:DYNPD

    : rf! ( b reg -- ) $20 or +spi >spi >spi -spi ;
    : rf@ ( reg -- b ) +spi >spi spi> -spi ;

    : rf!!          ( addr n reg -- )
                    +spi >spi
                    begin swap dup c@ >spi 1+ swap 1- dup 0= until
                    drop -spi ;

    : rf-init       ;
    : -rf-pwr       %00001000 RF:CONFIG rf! -rf-ce ;
    : rf-ch!        ( ch -- )     RF:RF_CH rf! ;
    : rf-rx-addr!   ( addr n -- ) RF:RX_ADDR_P1 $20 or rf!! ;
    : rf-tx-addr!   ( addr n -- ) RF:TX_ADDR $20 or rf!! ;

    : rf-tx-mode    -rf-ce %00001010 RF:CONFIG rf! ;
    : rf-rx-mode    %00001011 RF:CONFIG rf! +rf-ce ;

    : rf-tx         ( addr n -- ) 2drop ;
    : rf-rx         ( addr n -- ) 2drop ;
