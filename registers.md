# Registers

Registers are each 16-bits wide.

**AX** Accumulator  
**BX** Common use (address)  
**CX** Common use (counter)  
**DX** Common use (32-bit extension of AX)  
**SI** Common use (source address)  
**DI** Common use (destination/target address)  
**BP** Base pointer (used along SP)  
**SP** Stack pointer  
**Flags** State of last instruction affecting flags.  

Most registers besides the Flags register are free to use as one wishes,
but most have dedicated fucntions for certain instructions.  

The common use registers AX, BX, CX, DX, can be used in 8-bit halves.  
for example, one can use the upper 8-bits of AX by specifying AH (A High),  
or the lower 8-bits by specifying AL (A Low).  
So if 0x55AA where to be stored in AX, then AH would contain 0x55,  
and AL would contain 0xAA.  

