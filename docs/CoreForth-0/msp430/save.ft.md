vim:ft=forth:ts=2:sw=2:expandtab:foldmethod=marker:foldmarker=\\ --\ ,\\\ ---:

    : (clear-info)  info dup pad #12 cells move   erase-segment ;
    : (restore-info)   unlock-flash   +flash-write pad info #12 cells move ;

    : save          bl word find if
                      (clear-info) pad !
                      latest @ pad 2+ !   dp @ pad 4 + !   vp @ pad 6 + !
                      (restore-info)
                    else drop s" not found, not saving." type then ;

    : restore       (clear-info)
                    6 cells pad + pad 6 cells move
                    (restore-info)
                    init-dp @ erase-to-end
                    reset ;
