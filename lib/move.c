#include <avr/io.h>

#include "move.h"

/** M1 Speed Control */
#define M1_PWM PIN5
/** M2 Speed Control */
#define M2_PWM PIN6
/** M1 Direction Control */
#define M1_DIR PIN4
/** M2 Direction Control */
#define M2_DIR PIN7

#define FORWARD (1)
#define BACKWARD (0)

#define TURNSPEED (255)
#define MOVESPEED (255)

typedef enum{
    MOTOR1 = 0,
    MOTOR2
}motor_enum_t;


static void set_pwm(motor_enum_t motor, unsigned char value);
static void set_dir(motor_enum_t motor, unsigned char direction);

/** \addtogroup move-library
 *  Library for moving robot
 *  @{
 */

/**
  \brief Initialization of Movement library
*/
void move_init(void)
{
    /* Set M1 & M2 pins as output */
    DDRD |= (1 << M1_PWM);
    DDRD |= (1 << M2_PWM);
    DDRD |= (1 << M1_DIR);
    DDRD |= (1 << M2_DIR);

    /* Configure PWM */

    /* set none-inverting mode */
    TCCR0A |= (1 << COM0A1);
    TCCR0A |= (1 << COM0B1);

    /* set fast PWM Mode */
    TCCR0A |= (1 << WGM01) | (1 << WGM00);

    /* set prescaler to 64 and starts PWM */
    TCCR0B |= (1 << CS01) | (1 << CS00);
}

/**
  \brief Stops both motors
*/
void move_stop(void)
{
    set_pwm(MOTOR1, 0);
    set_pwm(MOTOR2, 0);
}

/**
  \brief Moves both motors forward
*/
void move_forward(void)
{
    set_dir(MOTOR1, FORWARD);
    set_dir(MOTOR2, FORWARD);
    set_pwm(MOTOR1, MOVESPEED);
    set_pwm(MOTOR2, MOVESPEED);
}

/**
  \brief Turns robot left
*/
void move_left(void)
{
    set_dir(MOTOR1, FORWARD);
    set_dir(MOTOR2, BACKWARD);
    set_pwm(MOTOR1, TURNSPEED);
    set_pwm(MOTOR2, TURNSPEED);
}

/**
  \brief Moves robot backward
*/
void move_backward(void)
{
    set_dir(MOTOR1, BACKWARD);
    set_dir(MOTOR2, BACKWARD);
    set_pwm(MOTOR1, MOVESPEED);
    set_pwm(MOTOR2, MOVESPEED);
}

/**
  \brief Turns robot to the right
*/
void move_right(void)
{
    set_dir(MOTOR1, BACKWARD);
    set_dir(MOTOR2, FORWARD);
    set_pwm(MOTOR1, TURNSPEED);
    set_pwm(MOTOR2, TURNSPEED);
}

/** @}*/

static void set_pwm(motor_enum_t motor, unsigned char value)
{
    switch(motor)
    {
        case MOTOR1:
            OCR0B = value;
            break;
        case MOTOR2:
            OCR0A = value;
            break;
    }
}

static void set_dir(motor_enum_t motor, unsigned char direction)
{
    switch(motor)
    {
        case MOTOR1:
            if (direction)
                PORTD |= (1 << M1_DIR);
            else
                PORTD &= ~(1 << M1_DIR);
            break;
        case MOTOR2:
            if (direction)
                PORTD |= (1 << M2_DIR);
            else
                PORTD &= ~(1 << M2_DIR);
            break;
    }
}

