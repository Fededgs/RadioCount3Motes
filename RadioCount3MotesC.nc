#include "Timer.h"
#include "RadioCount3Motes.h"
#include "printf.h"

module RadioCount3MotesC @safe(){
	uses {
		interface Leds;
	 	interface Boot;
		interface Receive;
		interface AMSend;
		interface Timer<TMilli> as MilliTimer;
		interface SplitControl as AMControl;
    	interface Packet;			
	}
}
implementation {
	message_t packet;
	bool locked;
	uint16_t counter=0;
	
	event void Boot.booted() {
		call AMControl.start();
	}
	
	
	event void AMControl.startDone(error_t err) {
	    if (err == SUCCESS) {
			switch (TOS_NODE_ID)
			{
				case 1:
					call MilliTimer.startPeriodic(PERIOD_NODE_1);
				break;
				
				case 2:
					call MilliTimer.startPeriodic(PERIOD_NODE_2);
				break;
				
				case 3:
					call MilliTimer.startPeriodic(PERIOD_NODE_3);
				break;
				
				default:
				break;
			}	    	
	    }
	    else {
	      call AMControl.start();
	    }
	}
  
  
	event void AMControl.stopDone(error_t err) {
    	//
	}
	
  
	event void MilliTimer.fired(){	
		printf("Timer FIRED \n");
		printfflush();	  
		
		if(locked){
	  		return;
	  	}
	  	else {
		radio_count_msg_t* rcm =(radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));	  
	  	if(rcm==NULL){
	  		return;	
	  	}
	  	
	  	rcm->counter=counter;
	  	rcm->nodeid=TOS_NODE_ID;
	  	
	  	printf("Sent%u,%u \n",rcm->nodeid,rcm->counter);
	 	printfflush();
	  	
	  	if(call AMSend.send(AM_BROADCAST_ADDR,&packet,sizeof(radio_count_msg_t))==SUCCESS){
	  		locked=TRUE;	
	  	}	
	  		
		}
		
	}
	
	
	//locked set to FALSE
	event void AMSend.sendDone(message_t* bufPtr, error_t error) {
		if (&packet == bufPtr) {
		  locked = FALSE;
		}
 	}
 	
 	
 	//Receive a packet
 	event message_t* Receive.receive(message_t* bufPtr, void* payload, uint8_t len) {
 	 	
 	 	if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
 	 	
	 	else {
      		radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
      		
      		printf("Rec:%u,%u\n",rcm->nodeid,rcm->counter );
	 	 	printfflush();	 	
	 	 	
	 		if((rcm->counter)%10==0){
	 			call Leds.led0Off(); 
	 			call Leds.led1Off();
	 			call Leds.led2Off();
	 			
	 			printf("MOD10\n");
	 			printfflush();
	 		}	
	 		
	 		else{
	 			switch (rcm->nodeid)
				{
					case 1:
						call Leds.led0Toggle();
					break;
			
					case 2:
						call Leds.led1Toggle();
					break;
			
					case 3:
						call Leds.led2Toggle();
					break;
			
					default:
					break;
				}
	 		
	 		}
 	 	}
 	 	
 	 	//when receive,update counter
 	 	counter++;
 	 	
 	 	return bufPtr;
 	 }
 	 
 }

