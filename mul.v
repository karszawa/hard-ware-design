module mul(A, B, O, ck, start, fin);
  input [7:0] A, B;
  input ck, start;
  output [16:0] O;
  output fin;
  reg [7:0] INA, INB;
  reg [3:0] st;
  reg [16:0] tmp;

  always @(posedge ck) begin
    if ( start == 1 ) begin
      INA <= A;
      INB <= B;
      st <= 0;
      tmp <= 0;
    end else begin
      tmp <= (tmp << 1) + INA * INB [7 - st];
      st <= st + 1;
    end
  end

  assign fin = (st == 8 ? 1 : 0);
  assign O = tmp;
endmodule
