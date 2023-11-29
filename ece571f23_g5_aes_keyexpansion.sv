////////////////////////////////////////////
//ece571f23_g5_aes_keyexpansion.sv – This is design module for key generation
// Author: Karthik - ekke@pdx.edu
// Date: 11/21/2023
/* Description: In this module key is generated by performing few operations on input key 
1) Dividing the 128 bit key in to four 32 bit words
2) performing circula shift operation on word 3 (LSB)
3) Then using Sbox subbites operation is performed on w3
4) Then Exor operation is done with respective round constants , now we have a modified w3 
5) by taking this generated w3 word and exor operations is performed on input kwy and this process is continued for 10 rounds  */

module ece571f23_g5_aes_keyexpansion (
  output logic [127:0] key_out,
  input logic [3:0] rcount, 
  input logic [127:0] key_in 
);
  
  logic [31:0] w0,w1,w2,w3,rotword,subword;
  
//////// dividing 128 bit key_in into rows / 4 words ///////
  
  assign w0 = key_in[96+:32];
  assign w1 = key_in[64+:32];
  assign w2 = key_in[32+:32];
  assign w3 = key_in[0+:32];
  
  
//////////// circular left shift//////
  
  assign rotword = { w3[23:16] , w3[15:8] , w3[7:0] , w3[31:24]} ;
  
 
  
 
  /////////// subbytes///////////
  
ece571f23_g5_aes_sbox b0 (.data_out(subword[0+:8]), .data_in(rotword[0+:8]));
ece571f23_g5_aes_sbox b1 (.data_out(subword[8+:8]), .data_in(rotword[8+:8]));
ece571f23_g5_aes_sbox b2 (.data_out(subword[16+:8]), .data_in(rotword[16+:8]));
ece571f23_g5_aes_sbox b3 (.data_out(subword[24+:8]), .data_in(rotword[24+:8]));
  
  // assign key_out = rotword;
 
  
  
/////////////// key generation //////
  
  
  assign key_out[96+:32] = w0 ^ subword ^ rcon(rcount);
  assign key_out[64+:32] = w0 ^ subword ^ rcon(rcount) ^ w1;
  assign key_out[32+:32] = w0 ^ subword ^ rcon(rcount) ^ w1 ^ w2;
  assign key_out[0+:32] = w0 ^ subword ^ rcon(rcount) ^ w1 ^ w2 ^ w3;
                                           
  
  ///////////// round constant /////////
  
  
  function [31:0] rcon;
    input logic [3:0] rcount;
    case (rcount)
     
      4'h1 : rcon = 32'h01000000;
      4'h2 : rcon = 32'h02000000;
      4'h3 : rcon = 32'h04000000;
      4'h4 : rcon = 32'h08000000;
      4'h5 : rcon = 32'h10000000;
      4'h6 : rcon = 32'h20000000;
      4'h7 : rcon = 32'h40000000;
      4'h8 : rcon = 32'h80000000;
      4'h9 : rcon = 32'h1b000000;
      4'h10 : rcon = 32'h36000000;
      default : rcon = 32'h00000000;
    endcase
  endfunction 
 
  
endmodule : ece571f23_g5_aes_keyexpansion
