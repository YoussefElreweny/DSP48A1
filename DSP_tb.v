module DSP48A1_tb;

    // Inputs
    reg [17:0] A;
    reg [17:0] B;
    reg [47:0] C;
    reg [17:0] D;
    reg clk;
    reg CARRYIN;
    reg [7:0] OPMODE;
    reg [17:0] BCIN;
    reg RSTA;
    reg RSTB;
    reg RSTM;
    reg RSTP;
    reg RSTC;
    reg RSTD;
    reg RSTCARRYIN;
    reg RSTOPMODE;
    reg CEA;
    reg CEB;
    reg CEM;
    reg CEP;
    reg CEC;
    reg CED;
    reg CECARRYIN;
    reg CEOPMODE;
    reg [47:0] PCIN;

    // Outputs
    wire [17:0] BCOUT;
    wire [47:0] PCOUT;
    wire [47:0] P;
    wire [35:0] M;
    wire CARRYOUT;
    wire CARRYOUTF;

    // Instantiate the Unit Under Test (UUT)
    DSP48A1 uut (
        .A(A), 
        .B(B), 
        .C(C), 
        .D(D), 
        .clk(clk), 
        .CARRYIN(CARRYIN), 
        .OPMODE(OPMODE), 
        .BCIN(BCIN), 
        .RSTA(RSTA), 
        .RSTB(RSTB), 
        .RSTM(RSTM), 
        .RSTP(RSTP), 
        .RSTC(RSTC), 
        .RSTD(RSTD), 
        .RSTCARRYIN(RSTCARRYIN), 
        .RSTOPMODE(RSTOPMODE), 
        .CEA(CEA), 
        .CEB(CEB), 
        .CEM(CEM), 
        .CEP(CEP), 
        .CEC(CEC), 
        .CED(CED), 
        .CECARRYIN(CECARRYIN), 
        .CEOPMODE(CEOPMODE), 
        .PCIN(PCIN), 
        .BCOUT(BCOUT), 
        .PCOUT(PCOUT), 
        .P(P), 
        .M(M), 
        .CARRYOUT(CARRYOUT), 
        .CARRYOUTF(CARRYOUTF)
    );

    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;
        end
    end

    initial begin
        //D register
        A = 10;
        B = 20;
        C = 10;
        D = 15;
        CARRYIN = 1;
        PCIN = 8;
        BCIN = 4;
        RSTA = 1;
        RSTB = 1;
        RSTC = 1;
        RSTD = 1;
        RSTM = 1;
        RSTP = 1;
        RSTC = 1;
        RSTCARRYIN = 1;
        RSTOPMODE = 1;
        OPMODE = 8'b00010000;
        CEOPMODE = 1;
        CEA = 1;
        CEB = 1;
        CEC = 1;
        CED = 1;
        CEM = 1;
        CEP = 1;
        CEC = 1;
        @(negedge clk);
        RSTD = 0;
        RSTA = 0;
        RSTB = 0;
        RSTC = 0;
        RSTM = 0;
        RSTP = 0;
        RSTC = 0;
        RSTCARRYIN = 0;
        RSTOPMODE = 0;
        OPMODE = 8'b10010001;
        @(negedge clk);
        OPMODE = 8'b00010001;
        @(negedge clk);
        OPMODE = 8'b00010111;
        @(negedge clk);
        OPMODE = 8'b00110000;
        
        repeat (5) begin
        OPMODE = OPMODE + 1;
        @(negedge clk);
        end
        $stop;
    end

endmodule
