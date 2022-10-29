##### This project is a set of small projects for fpga.

*.qsf - Quartus Settings File  
*.qpf - Quartus Project File  
*.bdf - Block Diagram File  
*.bsf - Block Symbol File  

```bash
quartus_fit badprog1 --read_settings_files=off
quartus_fit badprog1 --write_settings_files=off
```

```bash
export PATH=$PATH:"/home/user/drive/soft/intelFPGA_lite/20.1/quartus/bin/"
export PATH=$PATH:"/home/user/drive/soft/intelFPGA_lite/20.1/modelsim_ase/bin/"
```

##### Create new project

The top level entity is counter.bdf - graphically represented schematic

```bash
quartus_map counter --source=counter.bdf --family="Cyclone IV E"
```

 The top level entity is counter.v - schematic composed with Verilog HDL

```bash
quartus_map counter --source=counter.v --family="Cyclone IV E"
quartus_fit counter --part=EP4CE6E22C8N --pack_register=minimize_area
quartus_asm counter
quartus_sta counter
iverilog -o fifo ../../src/fifo.v ../../src/fifo_tb.v
vvp fifo
gtkwave dump.vcd
```
