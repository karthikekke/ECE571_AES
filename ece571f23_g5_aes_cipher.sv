/////////////////////////////////////////////
//ece571f23_g5_aes_cipher.sv – This is design module for encryption
// Author: 1) Karthik Ekke <ekke@pdx.edu> 2) Enoch Akanksh Vasimalla - <enochv@pdx.edu> 3) Harshavardhan Kasireddy <harshak@pdx.edu> 4) Deepthi Chevuru <chevuru@pdx.edu>
// Date: 11/20/2023
// Description: This is the main module for encryption with inputs as plaintext and key output is cipher text (encrypted text). 
// We perform 4 transformations for encryption for 1 to n-1 rounds and 3 transformations for nth round. 
//////////////////////////////////////////////

module ece571f23_g5_aes_cipher   (	output logic [127:0] cipher,
									input logic [127:0] plaintext,
									input logic [127:0] key
									);
  
  logic [127:0] rout [0:10];
  logic [127:0] keyout [0:10];
  
// Encryption rounds
  
// Round 0
  
  assign keyout [0] = key;
  assign rout [0] = plaintext ^ keyout[0];
 
// Round 1 to n-1 (9)
                   
genvar i; 
generate 
  for (i = 1; i < 10; i++) 
    begin : encryption
      ece571f23_g5_aes_encryption Er1_9 ( .roundout(rout[i]), .keyout_1_9(keyout[i]), .din(rout[i-1]), .key(keyout[i-1]), .rcount(i-1)); 
                    
                    
	end : encryption
endgenerate

		
// Round n
                    
  ece571f23_g5_aes_encryptionlastround ENCRYP_LAST (.roundout(rout [10]), .keyout(keyout[10]), .din(rout[10-1]), .key(keyout[10-1]), .rcount('h09));
 
 assign cipher = rout [10];   

endmodule : ece571f23_g5_aes_cipher 


    
// Encrption module for round 1 to round n-1 4 transformations performed
    
module ece571f23_g5_aes_encryption ( 

     output logic [127:0] roundout,
     output logic [127:0] keyout_1_9,
     input logic [127:0] din,
     input logic [127:0] key,
     input logic [31:0] rcount
      );
      
logic [127:0] subbytesoutput,shiftrowsoutput,mixcolumnsoutput;
      
ece571f23_g5_aes_keyexpansion k (keyout_1_9,rcount,key);
ece571f23_g5_aes_subbytes t1 (subbytesoutput,din);
ece571f23_g5_aes_shiftrows t2 (shiftrowsoutput,subbytesoutput);
ece571f23_g5_aes_mixcolumns t3 (mixcolumnsoutput,shiftrowsoutput);
ece571f23_g5_aes_addroundkey t4 (roundout,mixcolumnsoutput,keyout_1_9);
  
  endmodule : ece571f23_g5_aes_encryption
  
  
// Encrption module for last round n only 3 transformations performed


  module ece571f23_g5_aes_encryptionlastround ( 
            
      output logic [127:0] roundout,
     output logic [127:0] keyout,
     input logic [127:0] din,
     input logic [127:0] key,
     input logic [31:0] rcount
      );
      
     logic [127:0] subbytesoutput,shiftrowsoutput;
      
ece571f23_g5_aes_keyexpansion k (keyout,rcount,key);
ece571f23_g5_aes_subbytes t1 (subbytesoutput,din);
ece571f23_g5_aes_shiftrows t2 (shiftrowsoutput,subbytesoutput);
ece571f23_g5_aes_addroundkey t4 (roundout,shiftrowsoutput,keyout);
 
endmodule : ece571f23_g5_aes_encryptionlastround 




/*  encryption for round 1-9 same work as generate block


ece571f23_g5_aes_encryption R1(.roundout(rout[1]), .keyout_1_9(keyout[1]), .din(rout[0]), .key (keyout[0]), .rcount (32'h00) );
ece571f23_g5_aes_encryption R2(.roundout(rout[2]), .keyout_1_9(keyout[2]), .din(rout[1]), .key (keyout[1]), .rcount (32'h01) );
ece571f23_g5_aes_encryption R3(.roundout(rout[3]), .keyout_1_9(keyout[3]), .din(rout[2]), .key (keyout[2]), .rcount (32'h02) );
ece571f23_g5_aes_encryption R4(.roundout(rout[4]), .keyout_1_9(keyout[4]), .din(rout[3]), .key (keyout[3]), .rcount (32'h03) );
ece571f23_g5_aes_encryption R5(.roundout(rout[5]), .keyout_1_9(keyout[5]), .din(rout[4]), .key (keyout[4]), .rcount (32'h04) );
ece571f23_g5_aes_encryption R6(.roundout(rout[6]), .keyout_1_9(keyout[6]), .din(rout[5]), .key (keyout[5]), .rcount (32'h05) );
ece571f23_g5_aes_encryption R7(.roundout(rout[7]), .keyout_1_9(keyout[7]), .din(rout[6]), .key (keyout[6]), .rcount (32'h06) );
ece571f23_g5_aes_encryption R8(.roundout(rout[8]), .keyout_1_9(keyout[8]), .din(rout[7]), .key (keyout[7]), .rcount (32'h07) );
ece571f23_g5_aes_encryption R9(.roundout(rout[9]), .keyout_1_9(keyout[9]), .din(rout[8]), .key (keyout[8]), .rcount (32'h08) );
            
*/