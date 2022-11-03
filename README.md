##### This project is a set of small projects for fpga.

```bash
export PATH=$PATH:"/home/user/drive/soft/intelFPGA_lite/20.1/quartus/bin/"
export PATH=$PATH:"/home/user/drive/soft/intelFPGA_lite/20.1/modelsim_ase/bin/"
```

[SystemVerilog Testbench](https://www.chipverify.com/systemverilog/systemverilog-simple-testbench)  
[Краткий курс HDL. Язык Verilog](https://kit-e.ru/hdl/kratkij-kurs/)  
[FPGA designs with Verilog and SystenVerilog](https://verilogguide.readthedocs.io/en/latest/index.html#)


Directories of the project
- `icarus`  
Current directory contains subdirectory `fifo_sim` which contains a script simulate.sh. This script performs simulation of `fifo` module from `fifo.v` file with `fifo_tb` module form `fifo_tb.v` file. After success simulation it need to run `gtkwave dump.vcd` command.  

- `q2p_alu_rza2.1`  
Current directory should contain ALU Quartus II project files required to built, place and rout, and write resulting binary file into RZ-easyfpga A2.1 Altera Cyclone IV FPGA board. 
  
- `q2p_counter_rza2.1`  
Current directory contains simple counter Quartus II project files required to built, place and rout, and write resulting binary file into RZ-easyfpga A2.1 Altera Cyclone IV FPGA board.  

- `src`  
Current directory contains source files.


##### Example of building q2p_counter_rza2.1 project

The folowing document describes detailed information about console commands:  
**Quartus II Scripting Reference Manual**  
*For Command-Line Operation & Tool Command Language (Tcl) Scripting*

Files type of Quartus II projects:  
`*.qsf` - Quartus Settings File  
`*.qpf` - Quartus Project File  
`*.bdf` - Block Diagram File  
`*.bsf` - Block Symbol File  
`*.sof` - SRAM Object Files  
`*.pof` - Programmer Object Files  
`*.cof` - Conversion Setup Files

`--read_settings_files[=on|off]`  
Overview
Option to read the assignments from the Quartus II Settings File (.qsf) and override assignments obtained
from the database. All options that pass from the command line still override any conflicting assignments
found in the QSF.
By default, assignments are read from the QSF unless you specify "--read_settings_files=off".

Precedence for Reading Assignments
| Option specified | Precedence for Reading Assignments |  
|---|---|  
| --import_settings_files=on (Default)| 1. Command-line options<br/>2. Quartus II Settings File (.qsf)<br/>3. Compiler database (db directory, if it exists)<br/>4. Quartus II software defaults|  
|--import_settings_files=off| 1. Quartus II Settings File (.qsf)<br/>2. Compiler database (db directory, if it exists)<br/>3. Quartus II software defaults |  

Location for Writing Assignments
| Option specified | Location for Writing Assignments |  
|---|---|  
| --export_settings_files=on (Default)| 1. Quartus II Settings File (.qsf)<br/>2. Compiler database |  
|--export_settings_files=off| 1. Compiler database | 

- Analysis and Synthesis builds a single project database that integrates all the design files in a design entity or project hierarchy, performs logic synthesis to minimize the logic of the design, and performs technology mapping to implement the design logic using device resources such as logic elements.  
The top level entity is counter.v - schematic composed with Verilog HDL.  

```bash
quartus_map counter --source=../src/counter.v --family="Cyclone IV E
```
or  
The top level entity is counter.bdf - schematic composed with Block Diagram File.

```bash
quartus_map counter --source=counter.bdf --family="Cyclone IV E"
```

Option to check the specified design file for syntax and semantic errors  

```bash
quartus_map counter --analyze_file=../src/counter.v --import_settings_files=off --export_settings_files=off 
```

- Fitter performs place-and-route by fitting the logic of a design into a device. The Fitter selects appropriate interconnection paths, pin assignments, and logic cell assignments.  

```bash
quartus_fit counter --part=EP4CE6E22C8 --pack_register=minimize_area
```

- Assembler generates a device programming image, in the form of one or more Programmer Object Files (.pof), SRAM Object Files (.sof), Hexadecimal (Intel-Format) Output Files (.hexout), Tabular Text Files (.ttf), and Raw Binary Files(.rbf), from a successful fit (that is, place and route). The .pof and .sof files can then be processed by the Quartus II Programmer and the MasterBlaster™ or the ByteBlaster™ II Download Cable, or the Altera® Programming Unit (APU). The .hexout, .ttf, and .rbf files can be used by other programming hardware manufacturers that provide programming support for Altera devices.  

```bash
quartus_asm counter
```
- Convert Programming Files converts one programming file format to a different possible format.  

```bash
quartus_cpf -c -d EPCS16 counter.sof counter.pof
```
or  

```bash
quartus_cpf -w counter.cof
quartus_cpf -c -o counter.cof -d EPCS16 counter.sof counter.pof
```

-  Programmer programs Altera devices. The Programmer uses one of the supported file formats:  
*Programmer Object Files (.pof)*  
*SRAM Object Files (.sof)*  
*Jam File (.jam)*  
*Jam Byte-Code File (.jbc)*    

Option to detect and display all the devices in the device chain.  

```bash
quartus_pgm -a
```
> Info: _*******************************************************************_   
> Info: Running Quartus Prime Programmer   
>     Info: Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition>  
>     Info: Copyright (C) 2020  Intel Corporation. All rights reserved.  
>     Info: Your use of Intel Corporation's design tools, logic functions   
>     Info: and other software and tools, and any partner logic  
>     Info: functions, and any output files from any of the foregoing  
>     Info: (including device programming or simulation files), and any  
>     Info: associated documentation or information are expressly subject  
>     Info: to the terms and conditions of the Intel Program License  
>     Info: Subscription Agreement, the Intel Quartus Prime License Agreement,  
>     Info: the Intel FPGA IP License Agreement, or other applicable license  
>     Info: agreement, including, without limitation, that your use is for  
>     Info: the sole purpose of programming logic devices manufactured by  
>     Info: Intel and sold by Intel or its authorized distributors.  Please  
>     Info: refer to the applicable agreement for further details, at  
>     Info: https://fpgasoftware.intel.com/eula.  
>     Info: Processing started: Thu Nov  3 15:16:03 2022  
> Info: Command: quartus_pgm -a  
> Info (213045): Using programming cable <span style="color:red;font-weight:400;font-size:16px"> **"USB-Blaster [1-2]"** </span>  
> 1) USB-Blaster [1-2]  
>   020F10DD   10CL006(Y|Z)/10CL010(Y|Z)/..  
>   
> Info: Quartus Prime Programmer was successful. 0 errors, 0 warnings  
>     Info: Peak virtual memory: 280 megabytes  
>     Info: Processing ended: Thu Nov  3 15:16:03 2022  
>     Info: Elapsed time: 00:00:00  
>     Info: Total CPU time (on all processors): 00:00:00 


Modes: JTAG, AS, PS, SD  

Options:  
| Option | Description |
|---|---|
| P | Program |
| R | Erase |
| L | Lock/Security Bit |
| I | Initialize Bridge Device\* |
| V | Verify |
| B | Blank-check |
| C | ISP Clamp |
| E | Examine |
| S | Skip/Bypass\*\* |

\* Serial FLASH Loader option only  
\*\* Cannot be used in combination with other options  


JTAG Program:  
`-o pvb;file.pof`  
`-o pvbi;file.jic`   
  
Active Serial Program:  
`-o pl;file.pof`  

```bash
quartus_pgm -c "USB-Blaster [1-2]" --mode=JTAG -o "P;counter.sof"
```

or  

```bash
quartus_pgm -c "USB-Blaster" --mode=AS -o "R;counter.pof"
```

##### Verification

- Using Icarus Verilog  

```bash
iverilog -o fifo path_to/fifo.v path_to/fifo_tb.v
vvp fifo
gtkwave dump.vcd
```

- Using Modelsim  

```bash
quartus_sh --flow compile counter
vlog -work work ../src/counter.v
vsim -L altera_mf_ver -L lpm_ver counter
```
##### Troubleshooting

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt install libxft2 libxft2:i386 lib32ncurses5
sudo apt install libxext6
sudo apt install libxext6:i386
```