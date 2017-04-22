module crc( data_in, crc_en, crc_out, rst, ck );
  input [7:0] data_in;
  input crc_en;
  output [4:0] crc_out;
  input rst;
  input ck;

  reg [4:0] lfsr_q;
  wire [4:0] lfsr_c;

  always @(posedge ck) begin
  end

  assign lfsr_c[0] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[3] ^ data_in[0] ^ data_in[3] ^ data_in[5] ^ data_in[6];
  assign lfsr_c[1] = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[1] ^ data_in[4] ^ data_in[6] ^ data_in[7];
  assign lfsr_c[2] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[6] ^ data_in[7];
  assign lfsr_c[3] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[4] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[7];
  assign lfsr_c[4] = lfsr_q[1] ^ lfsr_q[2] ^ data_in[2] ^ data_in[4] ^ data_in[5];
endmodule
