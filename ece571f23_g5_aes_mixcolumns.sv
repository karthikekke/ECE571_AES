/////////////////////////////////////////////
// ece571f23_g5_aes_mixcolumns.sv - Matrix Multiplication step for encryption
// Author: Deepthi Chevuru - chevuru@pdx.edu
// Date: 11/20/2023
// Description: In this module performs mix columns operation by matrix multiplication of input data by colum wise by a predefined 4X4 matrix given by AES spec
//////////////////////////////////////////////
/////////////////////////////////////////////



module ece571f23_g5_aes_mixcolumns(output logic [127:0] out,
								input logic [127:0] in);



function automatic [7:0] mulby2 (input logic [7:0] num);
begin
if (num & 'h80) mulby2 = (num << 1) ^ 'h1b;
else  		mulby2 = (num << 1);
end
endfunction

function automatic [7:0] mulby3 (input logic [7:0] num);
begin
mulby3 = mulby2(num) ^ num;
end
endfunction


always_comb
begin

	for(int i; i<4; i++)
	begin
		out[(32*i+24)+:8] = mulby2(in[(32*i+24)+:8]) ^ mulby3(in[(32*i+16)+:8]) ^ in[(32*i+8)+:8] ^ in[(32*i)+:8];
		out[(32*i+16)+:8] = in[(32*i+24)+:8] ^ mulby2(in[(32*i+16)+:8]) ^ mulby3(in[(32*i+8)+:8]) ^ in[(32*i)+:8];
		out[(32*i+8)+:8] = in[(32*i+24)+:8] ^ in[(32*i+16)+:8] ^ mulby2(in[(32*i+8)+:8]) ^ mulby3(in[(32*i)+:8]);
		out[(32*i)+:8] = mulby3(in[(32*i+24)+:8]) ^ in[(32*i+16)+:8] ^ in[(32*i+8)+:8] ^ mulby2(in[(32*i)+:8]);
	end

end

endmodule : ece571f23_g5_aes_mixcolumns
