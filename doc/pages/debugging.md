
# Debugging howto
-------------------

  cd bld/ext/simavr/Install/SimAVR/examples/board_simduino
  make
  <bld-dir>/simduino.elf -d
  gdb
  (gdb) target remote :1234
  avrdude -p m328p -c arduino -P /tmp/simavr-uart0 -U flash:w:porthos-mc-atmega328p.hex
