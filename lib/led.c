#include <avr/io.h>

#include "led.h"


/**
  \brief Initialization of LED
*/
void led_init()
{
    DDRB |= (1 << PIN5);
}

/**
  \brief Toggles led
*/
void led_toggle( )
{
    PORTB ^= (1 << PIN5);
}

/**
  \brief Switches on LED
*/
void led_on( )
{
    PORTB |= (1 << PIN5);
}

/**
  \brief Switches LED off
*/
void led_off( )
{
    PORTB &= ~(1 << PIN5);
}
