/** Clock speed */
#define FOSC 1843200 

/** Baud rate */
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

void serial_init(unsigned int ubrr);

void serial_transmit( unsigned char data );

unsigned char serial_receive( void );

