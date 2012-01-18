/////////////////////////////////////////////////////////////////////////////
//                             blinky.c
//  This essential program makes a blinking light on your PIC16F628 pin 
/////////////////////////////////////////////////////////////////////////////

// In C, h-files typically include all sorts of useful constants,
// variables, and function definitions.  Here, we pick up definitions
// associated with PIC processors and the pic16f628 specifically.
 
#include <pic.h>
#include <pic16f6x.h>

//  This __Config command sets the register config at the PIC's memory
//  address 2007h.  The bit settings 0x3FF0 correspond to:
//  - no code protection              - low voltage 5 volt programming
//  - brown-out detection enabled     - Master clear enabled
//  - power-up timer enabled          - watch-dog timer disabled
//  - use of the internal oscillator, RA6 and RA7 left for I/O.
//  See the PIC16F62X data sheet regarding the configuration bits/word

// 16F628 config word appropriate for LVP
__CONFIG(0x3FF0);

void delay(void); 	// In C, use a function "prototype" to let the
		  	// compiler know that you will be defining a
		  	// function called delay later in the file.

// All C programs have a "main" routine.  This is
// the entry-point, the first code to be executed.

void main(void) {
	TRISB = 0xF0;  // TRISB masks the pins on port B for I/O. Pins
	               // set to "1" are tri-state, ready for use as
	               // inputs.  Pins set to "0" are actively driven
	               // and can be used as outputs.

	// In C, this "while" loop will loop forever:
	while (1) {   
		PORTB = 0b00000001; // Set RB0 high
		delay();	    // Wait a while
		PORTB = 0b00000000; // Set RB0 low
		delay();	    // Wait a while
	}
}

// Delay executes a for-next loop that wastes time so that
// we can enjoy the blinking.
void delay(void) {
   unsigned int i; //for delay

   for (i=0; i<10000; i ++)
	   ;                // Do nothing
}
