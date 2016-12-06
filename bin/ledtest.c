#include <avr/io.h>
#include <util/delay.h>

#include "serial.h"

int main(void)
{
    unsigned char data = 0x0;

    DDRB |= (1 << PIN5);

    serial_init(MYUBRR);

    while(1)
    {
        // toggle pin
        PORTB ^= (1 << PIN5);
        // wait for 250ms
        _delay_ms(15000);

        data = serial_receive();
        serial_transmit(data);
    }

    return 0;
}

