/**
 * \brief Simple application for motor control through USART
 *
 * \file main.c
 */

#include <avr/io.h>
#include "serial.h"
#include "move.h"
#include "led.h"

/**
 * \brief main loop
 * Within the main loop the LED port(s) are initialized and toggled, using mylib. The
 * main loop never ends until switching off the AVR itself.
 */
void setup(void);
void decode_command(unsigned char command);

int main(void)
{
   unsigned char data = 0;

   setup();

   while(1)
   {
      data = serial_receive();
      led_toggle();

      decode_command(data);
   }

   return 0;
}

void setup(void)
{
    move_init();
    serial_init(MYUBRR);
}

void decode_command(unsigned char command)
{
    switch(command)
    {
        case 0x01:
            move_forward();
            break;
        case 0x02:
            move_right();
            break;
        case 0x03:
            move_backward();
            break;
        case 0x04:
            move_left();
            break;
        default:
            move_stop();
            break;
    }
}
