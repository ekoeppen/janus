    ::host::

    : vars-to-image     [t'] reset-handler 1+ trom $00000004 + t!
                        [t'] cold             trom $00000380 + t!
                        tlast @             trom $00000384 + t!
                        tdp @               trom $00000388 + t!
                        tvp @               trom $0000038C + t!
                        [t'] cold           trom $000003C0 + t!
                        tlast @             trom $000003C4 + t!
                        tdp @               trom $000003C8 + t!
                        tvp @               trom $000003CC + t!
                        ;

    : save-bin         ( filename name-len -- )
                        vars-to-image
                        w/o create-file throw >r
                        #target there trom - r@ write-file throw
                        r> close-file throw
                        ;

    : save-hex          ( filename name-len -- )
                        vars-to-image
                        w/o create-file throw >r
                        trom #target there trom - r@ type-hex
                        [t'] reset-handler 1+ r@ hex-end
                        r> close-file throw ;
