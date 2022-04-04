library verilog;
use verilog.vl_types.all;
entity GEQ_16 is
    port(
        in1             : in     vl_logic_vector(15 downto 0);
        output          : out    vl_logic_vector(15 downto 0)
    );
end GEQ_16;
