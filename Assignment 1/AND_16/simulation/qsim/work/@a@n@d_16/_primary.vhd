library verilog;
use verilog.vl_types.all;
entity AND_16 is
    port(
        in1             : in     vl_logic_vector(15 downto 0);
        in2             : in     vl_logic_vector(15 downto 0);
        output          : out    vl_logic_vector(15 downto 0)
    );
end AND_16;
