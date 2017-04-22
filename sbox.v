module sbox(in, s, ck);
input [3:0] in;
output [3:0] s;
input ck;

reg [3:0] s;

always @(posedge ck) begin
  case ({in[0],in[3]})
    0: begin case ({in[1],in[2]}) 0: s <= 14; 1: s <= 4; 2: s <= 13; 3: s <= 1; endcase end
    1: begin case ({in[1],in[2]}) 0: s <= 0; 1: s <= 15; 2: s <= 7; 3: s <= 4; endcase end
    2: begin case ({in[1],in[2]}) 0: s <= 4; 1: s <= 1; 2: s <= 14; 3: s <= 8; endcase end
    3: begin case ({in[1],in[2]}) 0: s <= 15; 1: s <= 12; 2: s <= 8; 3: s <= 2; endcase end
  endcase
end

endmodule
