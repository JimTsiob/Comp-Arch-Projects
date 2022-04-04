library verilog;
use verilog.vl_types.all;
entity FULLADDER_16_vlg_check_tst is
    port(
        cout            : in     vl_logic;
        overflow        : in     vl_logic;
        sum             : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end FULLADDER_16_vlg_check_tst;
