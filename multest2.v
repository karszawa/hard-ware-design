module  multest;
reg	[7:0]	A, B;
reg	ck;
reg	start;
reg	[3:0] st;
wire [16:0] O;
reg	[16:0] OR;
initial begin
	ck=0;
	start=0;
	st=0;
	$dumpvars;
	$dumpfile("mul.vcd");
	$monitor( "%t\tA=%h, B=%h, (OUT=%h) OUT=%h fin=%h st=%h", $time, A, B, O, OR, fin, st);
	A=0;
	B=0;
end
mul	MUL(A , B , O ,  ck, start,fin);
always	#10	ck = ~ck;
always @(negedge ck) begin
	if( st == 0 ) begin
	  start <= 1;
	end else begin
		start <= 0;
	end
	
	if( fin == 1 ) begin
	    OR <= O;
	    {B,A} <= {B,A} + 1;
	   st <= 0;
            if( O != A*B ) begin
                  $finish;
            end
            if( A == 'h f && B == 'h f ) begin
               $display( "OK\n" );
               $finish;
            end
	end else  st <= st+1;
end
endmodule
