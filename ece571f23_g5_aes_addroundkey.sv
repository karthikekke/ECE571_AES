////////////////////////////////////////////
//ece571f23_g5_aes_addroundkey.sv – This is design module for adding round key
// Author: Karthik - ekke@pdx.edu
// Date: 11/21/2023
// Description: In this module adding round key is done by performing xor operation of key and data from mixcolumns module//////////////////////////////////////////////




module ece571f23_g5_aes_addroundkey (
  
  output logic [127:0] out,
  input logic [127:0] text, 
  input logic [127:0] key
);
  
  assign out = text ^ key;
  
endmodule : ece571f23_g5_aes_addroundkey