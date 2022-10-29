This project is counter implementation for RZ-easyfpga A2.1 Altera Cyclone IV FPGA  
Schematic: 
[1](https://github.com/vanBassum/RZ_EasyFPGA/blob/master/Devboard%20documentation/Development%20board%20schematic%20diagram%20V2.1.pdf), 
[2](https://forum.maxiol.com/index.php?act=Attach&type=post&id=9204)  
[Docs:](https://kit-e.ru/memory/programmirovanie-pzu-po-jtag/)

Temporary project implements simple connection of lines:  
LED1(U5.84) - KEY1(U5.88)  
LED2(U5.85) - KEY2(U5.89)  
LED3(U5.86) - KEY3(U5.90)  
LED4(U5.87) - KEY4(U5.91)  

The folowing document describes detailed information about console commands:  
**Quartus II Scripting Reference Manual**  
*For Command-Line Operation & Tool Command Language (Tcl) Scripting*

- Analysis and Synthesis builds a single project database that integrates all the design files in a design entity or project hierarchy, performs logic synthesis to minimize the logic of the design, and performs technology mapping to implement the design logic using device resources such as logic elements.  

```bash
quartus_map counter --source=../src/counter.v
```

or  

```bash
quartus_map counter --source=counter.bdf --family="Cyclone IV E"
```

Option to check the specified design file for syntax and semantic errors  

```bash
quartus_map counter --analyze_file=../src/counter.v
```

- Fitter performs place-and-route by fitting the logic of a design into a device. The Fitter selects appropriate interconnection paths, pin assignments, and logic cell assignments.  

```bash
quartus_fit counter --part=EP4CE6E22C8N --pack_register=minimize_area
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
Modes: JTAG, AS, PS, SD  

JTAG Program:  
-o pvb;file.pof  
-o pvbi;file.jic  
  
Active Serial Program:  
-o pl;file.pof    

```bash
quartus_pgm -c "USB-Blaster [2-1]"
quartus_pgm -c "USB-Blaster [2-1]" --mode=JTAG
quartus_pgm -c "USB-Blaster" --mode=AS -o "R;counter.pof"
```

```bash
quartus_sh --flow compile counter

vlog -work work ../src/counter.v

vsim -L altera_mf_ver -L lpm_ver counter
```

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt install libxft2 libxft2:i386 lib32ncurses5
sudo apt install libxext6
sudo apt install libxext6:i386
```