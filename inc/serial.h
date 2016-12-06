/** Baud rate */
#define BAUD 9600
#define MYUBRR F_CPU/(16UL*BAUD)-1

void serial_init(unsigned int ubrr);

void serial_transmit( unsigned char data );

unsigned char serial_receive( void );

