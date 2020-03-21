#include "RadioCount3Motes.h"
#include "printf.h"

configuration RadioCount3MotesAppC{}
implementation {
	components MainC, RadioCount3MotesC as App, LedsC;
	components new AMSenderC(AM_RADIO_COUNT_MSG); 
	components new AMReceiverC(AM_RADIO_COUNT_MSG);
	components new TimerMilliC();
	components ActiveMessageC;
	
	//components for printf
	components PrintfC;
  	components SerialStartC;
	
	App.Boot -> MainC.Boot;
  
	App.Receive -> AMReceiverC;
	App.AMSend -> AMSenderC;
	App.AMControl -> ActiveMessageC;
	App.Leds -> LedsC;
	App.MilliTimer -> TimerMilliC;
	App.Packet -> AMSenderC;	

}
