/////////////////////////////////////////////
//ece571f23_g5_aes_subbytes.sv – This is design module for Subbytes
// Author: Enoch Akanksh Vasimalla - enochv@pdx.edu
// Date: 11/20/2023
// Description: This module performs substitution of bytes operation here input plaintext is substituted by sbox values 
//////////////////////////////////////////////


module ece571f23_g5_aes_subbytes ( 	output logic [127:0] dataout,
									input logic [127:0] datain
		       			         );
	
	
	
// using generate and genvar to instantiate sbox module to generate subbytes 						
		
			genvar i;
				generate 
					for(i=0;i<128;i=i+8)
						begin :SubBytes 
									ece571f23_g5_aes_sbox SBOX(dataout[i +:8],datain[i +:8]);
						end
				endgenerate

endmodule :	ece571f23_g5_aes_subbytes		
								 
								 
/*	instantiate the sbox module by name based port mapping doed the same work as generate block


// external wire for storing temporary datain
	logic [127:0] tmp_out;




     ece571f23_g5_aes_sbox s0(tmp_out[127:120],datain[127:120]);
     ece571f23_g5_aes_sbox s1(tmp_out[119:112],datain[119:112]);
     ece571f23_g5_aes_sbox s2(tmp_out[111:104],datain[111:104]);
     ece571f23_g5_aes_sbox s3(tmp_out[103:96],datain[103:96]);
     
     ece571f23_g5_aes_sbox s4(tmp_out[95:88],datain[95:88]);
     ece571f23_g5_aes_sbox s5(tmp_out[87:80],datain[87:80]);
     ece571f23_g5_aes_sbox s6(tmp_out[79:72],datain[79:72]);
     ece571f23_g5_aes_sbox s7(tmp_out[71:64],datain[71:64]);
     
     ece571f23_g5_aes_sbox s8(tmp_out[63:56],datain[63:56]);
     ece571f23_g5_aes_sbox s9(tmp_out[55:48],datain[55:48]);
     ece571f23_g5_aes_sbox s10(tmp_out[47:40],datain[47:40]);
     ece571f23_g5_aes_sbox s11(tmp_out[39:32],datain[39:32]);
     
     ece571f23_g5_aes_sbox s12(tmp_out[31:24],datain[31:24]);
     ece571f23_g5_aes_sbox s13(tmp_out[23:16],datain[23:16]);
     ece571f23_g5_aes_sbox s14(tmp_out[15:8],datain[15:8]);
     ece571f23_g5_aes_sbox s15(tmp_out[7:0],datain[7:0]);
	
//finally assigning the temporary data to dataout for every rising clock edge	
	always_comb
	begin
	 dataout=tmp_out;
	end
	
	*/
