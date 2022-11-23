## Parsing of 16 bit code words

Create words with binary machine code, parsing 16 bit unsigned integers
and adding them to the body, ended with the `NEXT` action. 

Fetch a word from the input stream. If the word is found in the
current word list, execute it as code word parsing is run in immediate
mode. If it is not found, parse it as a number, and store it in the
target code space at the current data pointer.

    : parse-code    begin  bl word  dup c@ while
                      find ?dup if
                        drop execute
                      else
                        number? if
                          th,
                        else count type [char] ? emit cr then
                      then
                    repeat drop ;

Define a flag which we can use to check when parsing is done:

    variable code-done

Parse words from the input stream until `code-done` is not zero.

    : read-code     false code-done ! begin
                      parse-code
                      code-done @ if exit then
                      refill
                    0= until ;

Start a new code word by first creating a dictionary header in the
target dictionary by fetching the next word as the code word name,
and then continue to read upcoming words as code words.

    : code          t: read-code ;

If we encounter `end-code` in the input stream, encode the `NEXT` action
to the target dictionary, and set `code-done` to true to stop parsing.

    : end-code      t,next true code-done ! ; immediate
