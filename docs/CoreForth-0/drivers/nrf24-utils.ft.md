    : rf. ( -- )  print out all the RF69 registers
      cr
      ."      RF:CONFIG " RF:CONFIG      rf@ h.2 cr
      ."       RF:EN_AA " RF:EN_AA       rf@ h.2 cr
      ."   RF:EN_RXADDR " RF:EN_RXADDR   rf@ h.2 cr
      ."    RF:SETUP_AW " RF:SETUP_AW    rf@ h.2 cr
      ."  RF:SETUP_RETR " RF:SETUP_RETR  rf@ h.2 cr
      ."       RF:RF_CH " RF:RF_CH       rf@ h.2 cr
      ."    RF:RF_SETUP " RF:RF_SETUP    rf@ h.2 cr
      ."      RF:STATUS " RF:STATUS      rf@ h.2 cr
      ."  RF:OBSERVE_TX " RF:OBSERVE_TX  rf@ h.2 cr
      ."         RF:RPD " RF:RPD         rf@ h.2 cr
      ."  RF:RX_ADDR_P0 " RF:RX_ADDR_P0  +spi >spi spi> h.2 spi> h.2 spi> h.2 spi> h.2 spi> h.2 -spi cr
      ."  RF:RX_ADDR_P1 " RF:RX_ADDR_P1  +spi >spi spi> h.2 spi> h.2 spi> h.2 spi> h.2 spi> h.2 -spi cr
      ."  RF:RX_ADDR_P2 " RF:RX_ADDR_P2  rf@ h.2 cr
      ."  RF:RX_ADDR_P3 " RF:RX_ADDR_P3  rf@ h.2 cr
      ."  RF:RX_ADDR_P4 " RF:RX_ADDR_P4  rf@ h.2 cr
      ."  RF:RX_ADDR_P5 " RF:RX_ADDR_P5  rf@ h.2 cr
      ."     RF:TX_ADDR " RF:TX_ADDR     +spi >spi spi> h.2 spi> h.2 spi> h.2 spi> h.2 spi> h.2 -spi cr
      ."    RF:RX_PW_P0 " RF:RX_PW_P0    rf@ h.2 cr
      ."    RF:RX_PW_P1 " RF:RX_PW_P1    rf@ h.2 cr
      ."    RF:RX_PW_P2 " RF:RX_PW_P2    rf@ h.2 cr
      ."    RF:RX_PW_P3 " RF:RX_PW_P3    rf@ h.2 cr
      ."    RF:RX_PW_P4 " RF:RX_PW_P4    rf@ h.2 cr
      ."    RF:RX_PW_P5 " RF:RX_PW_P5    rf@ h.2 cr
      ." RF:FIFO_STATUS " RF:FIFO_STATUS rf@ h.2 cr
      ."       RF:DYNPD " RF:DYNPD       rf@ h.2 cr
      ;
