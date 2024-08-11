module DSP48A1 (
    input [17:0] A,
    input [17:0] B,
    input [47:0] C,
    input [17:0] D,
    input clk,
    input CARRYIN,
    input [7:0] OPMODE,
    input [17:0] BCIN,
    input RSTA,
    input RSTB,
    input RSTM,
    input RSTP,
    input RSTC,
    input RSTD,
    input RSTCARRYIN,
    input RSTOPMODE,
    input CEA,
    input CEB,
    input CEM,
    input CEP,
    input CEC,
    input CED,
    input CECARRYIN,
    input CEOPMODE,
    input [47:0] PCIN,
    output [17:0] BCOUT,
    output [47:0] PCOUT,
    output [47:0] P,
    output [35:0] M,
    output CARRYOUT,
    output CARRYOUTF);

    // Parameter definitions
    parameter A0REG = 0;      // Default: 0 (no register)
    parameter A1REG = 1;      // Default: 1 (register)
    parameter B0REG = 0;      // Default: 0 (no register)
    parameter B1REG = 1;      // Default: 1 (register)
    parameter CREG = 1;       // Default: 1 (registered)
    parameter DREG = 1;       // Default: 1 (registered)
    parameter MREG = 1;       // Default: 1 (registered)
    parameter PREG = 1;       // Default: 1 (registered)
    parameter CARRYINREG = 1; // Default: 1 (registered)
    parameter CARRYOUTREG = 1;// Default: 1 (registered)
    parameter OPMODEREG = 1;  // Default: 1 (registered)
    parameter CARRYINSEL = "OPMODE5"; // Default: OPMODE5
    parameter B_INPUT = "DIRECT";     // Default: DIRECT
    parameter RSTTYPE = "SYNC";       // Default: SYNC


    // first pipline
    wire [17:0] D_reg, B_reg, A_reg;
    wire [47:0] C_reg;
    wire [7:0]  Opmode_reg;
    reg  [17:0] B_small;
    //D
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) f1 (.in(D),.sel(DREG),.out(D_reg),.clk(clk),.rst(RSTD),.en(CED));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) f1 (.in(D),.sel(DREG),.out(D_reg),.clk(clk),.rst(RSTD),.en(CED));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) f1 (.in(D),.sel(DREG),.out(D_reg),.clk(clk),.rst(RSTD),.en(CED));
        endcase
    endgenerate 
    //C
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(48)) f2 (.in(C),.sel(CREG),.out(C_reg),.clk(clk),.rst(RSTC),.en(CEC));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(48)) f2 (.in(C),.sel(CREG),.out(C_reg),.clk(clk),.rst(RSTC),.en(CEC));
        default :  flip_flip_mux_sync   #(.WIDTH(48)) f2 (.in(C),.sel(CREG),.out(C_reg),.clk(clk),.rst(RSTC),.en(CEC));
        endcase
    endgenerate 
    //A
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) f3 (.in(A),.sel(A0REG),.out(A_reg),.clk(clk),.rst(RSTA),.en(CEA));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) f3 (.in(A),.sel(A0REG),.out(A_reg),.clk(clk),.rst(RSTA),.en(CEA));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) f3 (.in(A),.sel(A0REG),.out(A_reg),.clk(clk),.rst(RSTA),.en(CEA));
        endcase
    endgenerate 

    //B
    always @(*) begin
        case (B_INPUT)
            "DIRECT"  : B_small = B;
            "CASCADE" : B_small = BCIN;
            default   : B_small = 0;
        endcase
    end
    
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) f4 (.in(B_small),.sel(B0REG),.out(B_reg),.clk(clk),.rst(RSTB),.en(CEB));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) f4 (.in(B_small),.sel(B0REG),.out(B_reg),.clk(clk),.rst(RSTB),.en(CEB));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) f4 (.in(B_small),.sel(B0REG),.out(B_reg),.clk(clk),.rst(RSTB),.en(CEB));
        endcase
    endgenerate 
    //opmode
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(8)) opmode_f (.in(OPMODE),.sel(OPMODEREG),.out(Opmode_reg),.clk(clk),.rst(RSTOPMODE),.en(CEOPMODE));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(8)) opmode_f (.in(OPMODE),.sel(OPMODEREG),.out(Opmode_reg),.clk(clk),.rst(RSTOPMODE),.en(CEOPMODE));
        default :  flip_flip_mux_sync   #(.WIDTH(8)) opmode_f (.in(OPMODE),.sel(OPMODEREG),.out(Opmode_reg),.clk(clk),.rst(RSTOPMODE),.en(CEOPMODE));
        endcase
    endgenerate 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //Second pipline

    //A1 REG
    wire [17:0] A_reg_2;
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) A2_reg_f (.in(A_reg),.sel(A1REG),.out(A_reg_2),.clk(clk),.rst(RSTA),.en(CEA));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) A2_reg_f (.in(A_reg),.sel(A1REG),.out(A_reg_2),.clk(clk),.rst(RSTA),.en(CEA));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) A2_reg_f (.in(A_reg),.sel(A1REG),.out(A_reg_2),.clk(clk),.rst(RSTA),.en(CEA));
        endcase
    endgenerate 


    //B1 REG
    wire [17:0] B_reg_2;
    wire [17:0] B_reg_1_in;
    wire [17:0] adder_sub_out;
    
    adder_subtractor #(18) Pre_adder (.in0(D_reg),.in1(B_reg),.opcode(Opmode_reg[6]),.out(adder_sub_out));

    assign B_reg_1_in = (Opmode_reg[4]) ? adder_sub_out : B_reg;

    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) B1_reg_f (.in(B_reg_1_in),.sel(B1REG),.out(B_reg_2),.clk(clk),.rst(RSTB),.en(CEB));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) B1_reg_f (.in(B_reg_1_in),.sel(B1REG),.out(B_reg_2),.clk(clk),.rst(RSTB),.en(CEB));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) B1_reg_f (.in(B_reg_1_in),.sel(B1REG),.out(B_reg_2),.clk(clk),.rst(RSTB),.en(CEB));
        endcase
    endgenerate 

    assign BCOUT = B_reg_2;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // THIRD PIPLINE
    // X - MUX
    wire [17:0] M_reg_in;
    assign M_reg_in = A_reg_2 * B_reg_2;

    //M_reg
    wire [17:0] M_reg_out;
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(18)) Mreg_f (.in(M_reg_in),.sel(MREG),.out(M_reg_out),.clk(clk),.rst(RSTM),.en(CEM));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(18)) Mreg_f (.in(M_reg_in),.sel(MREG),.out(M_reg_out),.clk(clk),.rst(RSTM),.en(CEM));
        default :  flip_flip_mux_sync   #(.WIDTH(18)) Mreg_f (.in(M_reg_in),.sel(MREG),.out(M_reg_out),.clk(clk),.rst(RSTM),.en(CEM));
        endcase
    endgenerate


    assign M = M_reg_out;


    reg [47:0] x_out;
    always @(*) begin
        case (Opmode_reg[1:0])
            0 : x_out = 0;
            1 : x_out = M_reg_out;
            2 : x_out = PCOUT;
            3 : x_out = {D_reg[11:0],A_reg[17:0],B_reg[17:0]};
            default: x_out = 0;
        endcase
    end

/////////////////////////////////

    // Z - MUX
    
    reg [47:0] z_out;
    always @(*) begin
        case (Opmode_reg[3:2])
            0 : z_out = 0;
            1 : z_out = PCIN;
            2 : z_out = PCOUT;
            3 : z_out = C_reg;
            default: z_out = 0;
        endcase
    end

////////////////////////////////////////////////////////////////////////////////////////////

    //Fourth Pipline

    //Carryin cascade registring
    reg carry_in;

    always @(*) begin
        case (CARRYINSEL)
            "CARRYIN": carry_in = CARRYIN;
            "OPMODE5": carry_in = Opmode_reg[5];
            default: carry_in = Opmode_reg[5];
        endcase
    end

    wire c_in_adder;
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(1)) cin_f (.in(carry_in),.sel(CREG),.out(c_in_adder),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(1)) cin_f (.in(carry_in),.sel(CREG),.out(c_in_adder),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        default :  flip_flip_mux_sync   #(.WIDTH(1)) cin_f (.in(carry_in),.sel(CREG),.out(c_in_adder),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        endcase
    endgenerate

    //POST_ADDER_WITH_CIN
    wire cout_past_adder;
    wire [47:0] sum_past_adder;

    adder_subtractor_carry #(.WIDTH(48)) Post_adder(.in0(x_out),.in1(z_out),.cin(c_in_adder),.opcode(Opmode_reg[7]),.cout(cout_past_adder),.sum(sum_past_adder));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //Fifth Pipline
    //P
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(48)) P_f (.in(sum_past_adder),.sel(PREG),.out(P),.clk(clk),.rst(RSTP),.en(CEP));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(48)) P_f (.in(sum_past_adder),.sel(PREG),.out(P),.clk(clk),.rst(RSTP),.en(CEP));
        default :  flip_flip_mux_sync   #(.WIDTH(48)) P_f (.in(sum_past_adder),.sel(PREG),.out(P),.clk(clk),.rst(RSTP),.en(CEP));
        endcase
    endgenerate
    assign PCOUT = P;
    //Carryout
    generate 
        case (RSTTYPE)
        "SYNC"  :  flip_flip_mux_sync   #(.WIDTH(48)) cout_f (.in(cout_past_adder),.sel(CARRYINREG),.out(CARRYOUT),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        "ASYNC" :  flip_flip_mux_async  #(.WIDTH(48)) cout_f (.in(cout_past_adder),.sel(CARRYINREG),.out(CARRYOUT),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        default :  flip_flip_mux_sync   #(.WIDTH(48)) cout_f (.in(cout_past_adder),.sel(CARRYINREG),.out(CARRYOUT),.clk(clk),.rst(RSTCARRYIN),.en(CECARRYIN));
        endcase
    endgenerate

    assign CARRYOUTF = CARRYOUT;


endmodule




















module flip_flip_mux_sync(in,sel,out,clk,rst,en);

parameter WIDTH = 1;

input sel;
input [WIDTH-1:0] in;
input clk,rst,en;
output [WIDTH-1:0] out;

reg [WIDTH-1:0] signal;

always @(posedge clk) begin
    if(rst) 
        signal <= 0;
    else if(en)
        signal <= in;
end

assign out = (sel==1) ? signal : in;
endmodule

module flip_flip_mux_async (in,sel,out,clk,rst,en);

parameter WIDTH = 1;

input sel;
input [WIDTH-1:0] in;
input clk,rst,en;
output  [WIDTH-1:0] out;

reg [WIDTH-1:0] signal;

always @(posedge clk,posedge rst) begin
    if(rst) 
        signal <= 0;
    else if(en)
        signal <= in;
end

assign out = (sel==1) ? signal : in;
endmodule



module adder_subtractor(in0,in1,opcode,out);

parameter WIDTH = 1;

input [WIDTH-1:0] in0,in1;
input opcode;
output reg [WIDTH-1:0] out;

always @(*) begin
    case (opcode)
        0 : out = in0 + in1;
        1 : out = in0 - in1; 
        default: out = in0 + in1;
    endcase
end

endmodule



module adder_subtractor_carry(in0,in1,cin,cout,opcode,sum);

parameter WIDTH = 1;

input [WIDTH-1:0] in0,in1;
input opcode,cin;
output reg [WIDTH-1:0] sum;
output reg cout;

always @(*) begin
    case (opcode)
        0: {cout, sum} = in0 + in1 + cin;
        1: {cout, sum} = in0 - in1 - cin;
        default: {cout, sum} = in0 + in1 + cin;
    endcase
end

endmodule

