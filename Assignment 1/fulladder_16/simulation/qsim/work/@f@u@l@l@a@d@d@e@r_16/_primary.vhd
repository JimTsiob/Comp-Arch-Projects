library verilog;
use verilog.vl_types.all;
entity FULLADDER_16 is
    port(
        in1             : in     vl_logic_vector(15 downto 0);
        in2             : in     vl_logic_vector(15 downto 0);
        cin             : in     vl_logic;
        sum             : out    vl_logic_vector(15 downto 0);
        cout            : out    vl_logic;
        overflow        : out    vl_logic
    );
end FULLADDER_16;
