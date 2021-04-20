# Janus Forth Cross Compiler

This is a simple Forth cross compiler inspired by
[embed](https://github.com/howerj/embed) and
[J1](https://github.com/jamesbowman/j1).

[CoreForth-0](https://github.com/ekoeppen/CoreForth-0) is one of the initial
Forths, with Cortex-M0/3 and MSP430 as the targets, and included as a Git
submodule.

Janus uses [gforth](https://gforth.org) as the host compiler. The following
command line switches are defined:

    -f FILE: This file will be included as the target Forth
    --stc: Passed on to the target Forth for subroutine threaded Forth
    --dtc: Passed on to the target Forth for direct threaded Forth
    --itc: Passed on to the target Forth for indirect threaded Forth

DTC CoreForth-0 for the Nucleo-F072RB board is for example compiled with

    gforth janus.ft -f CoreForth-0/boards/nucleo_f072rb --dtc
