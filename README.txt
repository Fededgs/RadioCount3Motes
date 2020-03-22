Federico Di Giusto

10693473

Link repository github: https://github.com/Fededgs/RadioCount3Motes

IOT\_Home\_Challenge1
=====================

Key Points on development
-------------------------

-   Use of `switch` case on `TOS_NODE_ID` to set the correct period time
    of timers
-   Message sent in `BROADCAST`
-   Message defined as `nx_struct` with `counter` and `nodeid` as
    `nx_uint16_t`
-   `counter` updated in `event receiver`
-   When `(rcm->counter)%10==0)` turn off all leds
-   Led toggled as request depending on the `nodeid` (sender) of the
    message received.

Supplementary Points
--------------------

-   Use of `enum` in `.h` file as support for the period time of timers
    (`1Hz`,`3Hz`,`5Hz`)
-   Mechanism of `locked` - `not locked` resource for sending
-   Use of `printf` for debugging. It prints on output console what a
    node sends, what it receives and when the `counter MOD 10` is equal
    to `0`.
-   `TOS_NODE_ID` set automatically when is loaded by Cooja.

