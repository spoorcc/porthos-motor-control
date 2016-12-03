# Taken from https://nnarain.github.io/2016/04/09/Debugging-with-SimAVR.html

find_program(SIMAVR
    NAME
        simavr

    PATHS
        /usr/bin/
        $ENV{SIMAVR_HOME}
)

if(NOT SIMAVR)
    message("-- Could not find simavr")
else(NOT SIMAVR)
    message("-- Found simavr: ${SIMAVR}")
endif(NOT SIMAVR)

find_path(SIMAVR_INCLUDE_DIR
    NAMES
        "simavr/avr/avr_mcu_section.h"

    PATHS
        /usr/include/
        /usr/local/include/
)

macro(add_sim_target target_name mcu clock_speed)

    if(SIMAVR)
        # create sim avr targets

        set(elf_file ${target_name}-${mcu}.hex)

        message("-- Adding command: sim-${target_name}")
        add_custom_command(
            OUTPUT "sim-${elf_file}"

            COMMAND
                ${SIMAVR} -m ${mcu} -f ${clock_speed} ${elf_file}
        )

        message("-- Adding target: sim-${elf_file}")
        add_custom_target(
            "sim-${target_name}"

            DEPENDS "sim-${elf_file}"
        )
    endif(SIMAVR)

endmacro(add_sim_target)

macro(add_vcd_trace target_name mcu clock_speed)
    message("-- Generating ${target_name} VCD trace file for ${mcu}")

    # list of our trace arguments
    set(trace_list)

    foreach(arg ${ARGN})

        # break down argument string
        string(REPLACE "," ";" arg_list ${arg})

        # get arguments
        list(GET arg_list 0 symbol_name)
        list(GET arg_list 1 mask)
        list(GET arg_list 2 what)

        # append structure
        list(APPEND trace_list "\t{ AVR_MCU_VCD_SYMBOL(\"${symbol_name}\"), .mask = (1 << ${mask}), .what = (void*)&${what}, },\n")

    endforeach(arg ${ARGN})

    # remove semi-colons that delimit a cmake list
    string(REPLACE ";" " " trace_list ${trace_list})

    # our file name
    set(FILENAME "${target_name}_${mcu}_vcd_trace.c")
    # full file path
    set(TRACE_FILE "${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}")

    # generate the file
    file(WRITE ${TRACE_FILE}
        "// Auto generated file by cmake\n"
        "// Generated VCD trace info for ${mcu} with clock speed ${clock_speed}\n\n"

        "#include <avr/io.h>\n"

        "#include <simavr/avr/avr_mcu_section.h>\n\n"
        "AVR_MCU(${clock_speed}, \"${AVR_MCU}\");\n"
        "AVR_MCU_VCD_FILE(\"${target_name}_trace.vcd\", 1000);\n\n"

        "const struct avr_mmcu_vcd_trace_t _mytrace[] _MMCU_ = {\n"
        "${trace_list}"
        "};\n"
    )

    set("${target_name}_VCD_TRACE_FILE" ${TRACE_FILE})

endmacro(add_vcd_trace)
