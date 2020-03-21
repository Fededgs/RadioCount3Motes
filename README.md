Federico Di Giusto
10693473
Link repository github: https://github.com/Fededgs/RadioCount3Motes

# IOT_Home_Challenge1
Home Challenge 1 - TinyOS, Cooja

## Key Points on development
* Use of  ```switch``` case on ``` TOS_NODE_ID``` to set the correct period time of timers
* Message sent in ```BROADCAST```
* Message defined as ```nx_struct``` with ```counter``` and ```nodeid``` as ```nx_uint16_t```
* ```counter``` updated in ```event receiver```
* Use of ```enum``` in ```.h``` file as support for the period time of timers (```1Hz```,```3Hz```,```5Hz```)
* When ```(rcm->counter)%10==0)``` turn off all leds


## Supplementary Points
* Mechanism of ```locked``` - ```not locked``` resource for sending
* use of ```printf``` for debugging. It prints on output console what a node sends, what it receives and when the ```counter MOD 10``` is equal to ```0```.










## Rules
* Create a Cooja simulation with three
TinyOS (sky) motes, called 1, 2 and 3.
* The three motes communicate over the
radio. The message is composed by a
counter and the sender id. All the
messages are sent in BROADCAST.
* Messages are sent at:
  * 1 Hz for mote 1
  * 3 Hz for mote 2
  * 5 Hz for mote 3
* Turn on/off the LEDs according the
following rules:
  * Messages sent by mote 1 toggle led0
  * Messages sent by mote 2 toggle led1
  * Messages sent by mote 3 toggle led2
  * Messages with ’counter mod 10’ == 0 turn
off all the LEDs
* The counter is incremented every time a
message is received.
### Delivering
Zip content:
* Source code folder:
  * fooC.nc
  * fooAppC.nc
  * foo.h
  * Other files, if needed
* Small project report (max 2 pages)
* Your names + ID number/matricola on
top of the report
* Repository link (if used)
