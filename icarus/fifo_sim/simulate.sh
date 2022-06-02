#! /bin/sh
iverilog -o fifo ../../src/fifo.v ../../src/fifo_tb.v
vvp fifo
