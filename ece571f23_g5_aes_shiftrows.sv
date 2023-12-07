/////////////////////////////////////////////
//ece571f23_g5_aes_shiftrows.sv – This is design module for shifting rows
// Author: Harshavardhan Kasireddy - harshak@pdx.edu
// Date: 11/20/2023
// Description: In this module circular shift operation is performed on input where 1st row has no shift, 2nd row is shited by 1 , 3rd row is shifted by 2, 4th row is shifted  by 3
//////////////////////////////////////////////


module ece571f23_g5_aes_shiftrows (
									output logic [127:0] data_out,
									input logic [127:0] data_in
									);
  
assign data_out = {data_in[127:120] ,  data_in[87:80]  , data_in[47:40]    ,  data_in[7:0]    ,
				data_in[95:88]   ,  data_in[55:48]  , data_in[15:8]     ,  data_in[103:96] , 
				data_in[63:56]   ,  data_in[23:16]  , data_in[111:104]  ,  data_in[71:64]  ,
				data_in[31:24]   ,  data_in[119:112], data_in[79:72]    ,  data_in[39:32]
			  };

endmodule : ece571f23_g5_aes_shiftrows






