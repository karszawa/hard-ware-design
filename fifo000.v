module fifo(Din, Dout, Wen, Ren, rst, ck, Fempty, Ffull);
  input [7:0] Din;
  output [7:0] Dout;
  input Wen, Ren;
  output Fempty, Ffull;
  input rst, ck;

  reg [7:0] FMEM[0:15];
  reg [3:0] Wptr, Rptr;
  reg Fempty, Ffull;
  reg [7:0] obuf;
  wire [3:0] NWptr, NRptr;

  always @(posedge ck) begin
    if( !rst ) begin
      if (Wen == 0) begin
        FMEM[Wptr] <= Din;
        Wptr <= Wptr + 1;
      end else begin
        Rptr <= Rptr + 1;
      end
    end else begin
      Wptr <= 0;
      Rptr <= 0;
    end
  end

  assign Dout = FMEM[Rptr];
endmodule
