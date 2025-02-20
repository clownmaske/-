module states1(in,clk,reset,lock,state);
input clk,reset;
input [3:0]in;
output reg lock;
output [2:0]state;
reg [2:0]state;

parameter s0=0,s1=1,s2=2,s3=3,s4=4;
always @ (posedge clk)
begin
	if(!reset)
	begin
	   state<=s0;lock<=0;
	end
	else
	begin
		case(state)
         s0:if(in==4'b0000)
			   begin state<=s1;lock<=0; end
			   else if(in==4'b1111)
				begin state<=s0;lock<=0; end
				else
				begin state<=s0;lock<=0; end
			s1:if(in==4'b1000)
			   begin state<=s2;lock<=0; end
				else if(in==4'b0000)
			   begin state<=s1;lock<=0; end
			   else if(in==4'b1111)
				begin state<=s1;lock<=0; end
				else
				begin state<=s0;lock<=0; end
			s2:if(in==4'b0010)
			   begin state<=s3;lock<=0; end
				else if(in==4'b0000)
			   begin state<=s1;lock<=0; end
			   else if(in==4'b1111)
				begin state<=s2;lock<=0; end
				else
				begin state<=s0;lock<=0; end
			s3:if(in==4'b0101)
			   begin state<=s4;lock<=0; end
				else if(in==4'b0000)
			   begin state<=s1;lock<=0; end
			   else if(in==4'b1111)
				begin state<=s3;lock<=0; end
				else
				begin state<=s0;lock<=0; end
			s4:if(in==4'b0000)
			   begin state<=s1;lock<=0; end
				else if(in==4'b1111)
				begin state<=s4;lock<=1; end
				else
				begin state<=s0;lock<=0; end
			default:
			   begin state<=s0;lock<=0; end
		endcase
	end
end
endmodule

module button1(k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,clk,out);
input k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,clk;
output [9:0]out;
reg [9:0]out;
reg [9:0]in,last,chan;
always @ (posedge clk) 
begin
	last=in;
	in={k0,k1,k2,k3,k4,k5,k6,k7,k8,k9};
	chan=in&(~last);
	case(chan)
		10'b1000000000:out<=10'b1000000000;
		10'b0100000000:out<=10'b0100000000;
		10'b0010000000:out<=10'b0010000000;
		10'b0001000000:out<=10'b0001000000;
		10'b0000100000:out<=10'b0000100000;
		10'b0000010000:out<=10'b0000010000;
		10'b0000001000:out<=10'b0000001000;
		10'b0000000100:out<=10'b0000000100;
		10'b0000000010:out<=10'b0000000010;
		10'b0000000001:out<=10'b0000000001;
		default:out<=10'b0000000000;
	endcase
end
endmodule

module trans1(a,b);
input [9:0]a;
output [3:0]b;
reg [3:0]b;
always @ (a)
begin
	case(a)
		10'b1000000000:b=4'b0000;
		10'b0100000000:b=4'b0001;
		10'b0010000000:b=4'b0010;
		10'b0001000000:b=4'b0011;
		10'b0000100000:b=4'b0100;
		10'b0000010000:b=4'b0101;
		10'b0000001000:b=4'b0110;
		10'b0000000100:b=4'b0111;
		10'b0000000010:b=4'b1000;
		10'b0000000001:b=4'b1001;
		default:b=4'b1111;
	endcase
end
endmodule

module fre1(clk,nclk);
input clk;
output nclk;
reg nclk;
reg [30:0]count=0;
always @ (posedge clk) 
begin
	count=count+1;
	if(count==20000)
	begin 
	   count = 0;nclk=!nclk; 
	end
	else 
	begin
	   nclk=nclk;
	end
end
endmodule

module view1(a,b);
input [2:0]a;
output [4:0]b;
reg [4:0]b;
always @ (a)
begin
	case(a)
		3'b000:b=5'b00001;
		3'b001:b=5'b00010;
		3'b010:b=5'b00100;
		3'b011:b=5'b01000;
		3'b100:b=5'b10000;
		default:b=5'b00000;
	endcase
end
endmodule

module bir1(k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,reset,clk,lock,out);
input k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,reset,clk;
output [4:0]out;
output lock;
wire nclk;
wire [9:0]in;
wire [2:0]state;
wire [3:0]in2;
fre1 fre(clk,nclk);
button1 button(k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,nclk,in);
trans1 trans(in,in2);
states1 states(in2,nclk,reset,lock,state);
view1 view(state,out);
endmodule
					
			
							

