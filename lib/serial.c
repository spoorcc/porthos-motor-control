#include <avr/io.h>

#include "serial.h"


/** \addtogroup serial-library
 *  Library for serial communication using HW USART
 *  @{
 */

/**
  \brief Initialization of USART

  \param [in] ubrr
*/
void serial_init(unsigned int ubrr)
{
   /*Set baud rate */
   UBRR0H = (unsigned char)(ubrr>>8);
   UBRR0L = (unsigned char) ubrr;

   /* Enable receiver and transmitter */
   UCSR0B = (1<<RXEN0)|(1<<TXEN0);
   /* Set frame format: 8data, 1stop bit */
   UCSR0C = (0<<USBS0)|(3<<UCSZ00);
}

/**
  \brief Places char to transmit in transmit buffer

  \param [in] data
*/
void serial_transmit( unsigned char data )
{
   /* Wait for empty transmit buffer */
   while ( !( UCSR0A & (1<<UDRE0)) );

   /* Put data into buffer, sends the data */
   UDR0 = data;
}

/**
  \brief Waits until data is received

  \retval data
*/
unsigned char serial_receive( void )
{
   /* Wait for data to be received */
   while ( !(UCSR0A & (1<<RXC0)) );

   /* Get and return received data from buffer */
   return UDR0;
}

/** @}*/
