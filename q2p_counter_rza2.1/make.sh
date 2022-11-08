#!/bin/bash

# $1 - operation type [build | sim | load | prog]
# $2 - programmer name prog_name

SRC=../src/

build() {
	echo "---> build()"
	quartus_fit counter --import_settings_files=on --export_settings_files=off
}

gen_img() {
	quartus_asm counter
	quartus_cpf -c -d EPCS16 counter.sof counter.pof
}

programm() {
	local pof_file="counter.pof"
	local prog_name=${1}
	
	if ! [ -f ${pof_file} ]
	then
		echo "There isn't ${pof_file}. Building should be made."
		return -1
	fi
	
	quartus_pgm -c ${prog_name} --mode=AS -o "R;${pof_file}"
	quartus_pgm -c ${prog_name} --mode=AS -o "P;${pof_file}"
}

load() {
	local pof_file="counter.sof"
	local prog_name=${1}
	
	if ! [ -f ${pof_file} ]
	then
		echo "There isn't ${sof_file}. Building should be made."
		return -1
	fi
	
	quartus_pgm -c ${prog_name} --mode=JTAG -o "P;${pof_file}"
}

simulate_icarus() {
	iverilog -o fifo ${SRC}/counter.v ${SRC}/counter_tb.v
	vvp fifo
}

main() {
	
	echo "---> main()"
	case ${1} in
			"build")
				build
			;;
	
			"sim")
				simulate_icarus
			;;
	
			"load")
				gen_img
				load ${2}
			;;
	
			"prog")
				gen_img
				programm ${2}
			;;
	
	
			*)
				return -1
			;;
		esac 
}

echo "---> ${0} ${1} ${2} ${3}"
echo "---> $#"

if [[ $# -lt 1 ]]
then
	echo FAILED
	exit -1
fi

main ${1} ${2}
