# "THE ANY BEVERAGE-WARE LICENSE" (Revision 42 - based on beer-ware
# license):
# <dev@layer128.net> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and
# you think this stuff is worth it, you can buy me a be(ve)er(age) in 
# return. (I don't like beer much.)
#
# Matthias Kleemann

add_vcd_trace(porthos-mc ${AVR_MCU} ${MCU_SPEED}
     "PORTD(2),PIN2,PORTD"
     "PORTD(4),PIN4,PORTD"
     "PORTD(5),PIN5,PORTD"
     "PORTD(6),PIN6,PORTD"
     "PORTD(7),PIN7,PORTD"
)
add_sim_target(porthos-mc ${AVR_MCU} ${MCU_SPEED})

#add_avr_executable(
#   porthos-mc
#   ${porthos-mc_VCD_TRACE_FILE}
#   main.c
#)

# find_library(M_LIB m)
# message(STATUS "avr-libm: ${M_LIB}")

find_library(C_LIB c)
message(STATUS "avr-libc: ${C_LIB}")

#avr_target_link_libraries(porthos-mc serial move ${C_LIB})


add_avr_executable(
   ledtest
   ledtest.c
)

avr_target_link_libraries(ledtest serial ${C_LIB})

