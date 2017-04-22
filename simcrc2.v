module top;
reg [7:0] data_in;
reg ck, rst, crc_en;
wire [4:0] crc_out;

crc crc(data_in, crc_en, crc_out, rst, ck);

initial begin
  ck=0; rst=0;
  $dumpfile("crc.vcd");
  $dumpvars;
  #100 rst=1;
  #100 rst=0;
  #1000
    $display( "OK\n" );
   $finish;
end

always #10 ck<=~ck;
always @(negedge ck) begin
   crc_en <= $random;
   data_in <= $random;
end

   /////////////// test purpose
reg [4:0] lfsr_q;
wire [4:0] lfsr_c;

assign lfsr_c[0] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[3] ^ data_in[0] ^ data_in[3] ^ data_in[5] ^ data_in[6];
assign lfsr_c[1] = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[1] ^ data_in[4] ^ data_in[6] ^ data_in[7];
assign lfsr_c[2] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[6] ^ data_in[7];
assign lfsr_c[3] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[4] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[7];
assign lfsr_c[4] = lfsr_q[1] ^ lfsr_q[2] ^ data_in[2] ^ data_in[4] ^ data_in[5];

always @(negedge ck) begin
   if( crc_out != lfsr_q) $finish;
end
   
always @(posedge ck) begin
if(rst)   lfsr_q <= {5{1'b1}};
else lfsr_q <= crc_en ? lfsr_c : lfsr_q;
end
   /////////////// test purpose

endmodule
