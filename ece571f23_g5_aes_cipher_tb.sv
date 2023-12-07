/////////////////////////////////////////////
//ece571f23_g5_aes_shiftrows.sv – This is testbench module for ece571f23_g5_aes_cipher module
// Author: Harshavardhan Kasireddy - harshak@pdx.edu
// Date: 11/20/2023
// Description: In this module circular shift operation is performed on input where 1st row has no shift, 2nd row is shited by 1 , 3rd row is shifted by 2, 4th row is shifted  by 3
//////////////////////////////////////////////


module ece571f23_g5_aes_cipher_tb();
logic  [127:0] cipher;
logic  [127:0] plaintext; 
logic [127:0] key;


// instantiated the main module by using orde based port mapping
ece571f23_g5_aes_cipher dut(cipher,plaintext,key);

//writing the task to give plain text and key values
task inputs(input  [127:0]m, input [127:0] n);
plaintext = m;
key = n;
endtask

//initial block is used to call the input task which assigns plain text and key
initial
begin
inputs(128'h24252abdafc445255353532728192965 , 128'h322332133acdabc33223321332233213);
#10
inputs(128'h242fdabdafc445255353532728192963 , 128'h356332133acdabc332233213dc233214);
#10
inputs(128'h24252abdafc445255353532728192962 , 128'h322332133acdabc33223321332233215);
#10
inputs(128'h24252abdafc445255353ac4728192961 , 128'h322332133acdabc332afd21332233216);

#10; $stop();
end

//initial block to monitor each and every change in inputs and output
initial
begin
$monitor("plaintext=%h, key=%h, cipher=%h", plaintext, key, cipher);

end

endmodule







