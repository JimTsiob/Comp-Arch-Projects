library verilog;
use verilog.vl_types.all;
entity XOR_2 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end XOR_2;
