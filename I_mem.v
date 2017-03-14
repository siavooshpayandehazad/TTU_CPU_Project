module instmemory( address, data );
parameter BitWidth = 8;
parameter InstructionWidth = 6 + BitWidth; 
 input  [(BitWidth-1):0] address;
 output [(InstructionWidth - 1):0] data; 
 reg [(InstructionWidth - 1):0] data;
 reg [(InstructionWidth - 1):0] memo [0:(2**8)-1];
 initial $readmemb("Instructions.txt",memo,0,63);
 always @(address) data=memo[address[7:0]];
endmodule