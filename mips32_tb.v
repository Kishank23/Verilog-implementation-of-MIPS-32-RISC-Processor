`timescale 1ns/10ps
`include"mips32.v"

module mips32_tb;
    reg clk1, clk2;
    integer k;

    mips32 mip(clk1, clk2);

    initial
        begin 
            clk1 = 0; clk2 = 0;
            repeat (20)
            begin
                #5 clk1 = 1; #5 clk1 = 0;
                #5 clk2 = 1; #5 clk2 = 0;
            end
        end
    initial 
        begin
            for ( k = 0; k<31 ; k++)
                mip.Reg[k] = k;
            
            mip.Mem[0] = 32'h2801000a;
            mip.Mem[1] = 32'h28020014;
            mip.Mem[2] = 32'h28030019;
            mip.Mem[3] = 32'h0ce77800;
            mip.Mem[4] = 32'h0ce77800;
            mip.Mem[5] = 32'h00222000;
            mip.Mem[6] = 32'h0ce77800;
            mip.Mem[7] = 32'h00832800;
            mip.Mem[8] = 32'hfc000000;
            mip.HALTED = 0;
            mip.PC     = 0;
            mip.TAKEN_BRANCH = 0;

            #280
            for (k = 0; k<6; k++)
                $display ("R%1d - %2d", k , mip.Reg[k]);
        end

    initial
        begin
            $dumpfile ("mips.vcd");
            $dumpvars (0, mips32_tb);
            #300 $finish;
        end
endmodule