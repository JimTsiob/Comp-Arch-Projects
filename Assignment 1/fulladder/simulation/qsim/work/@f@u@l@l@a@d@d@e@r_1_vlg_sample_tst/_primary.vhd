library verilog;
use verilog.vl_types.all;
entity FULLADDER_1_vlg_sample_tst is
    port(
        cin             : in     vl_logic;
        in1             : in     vl_logic;
        in2             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FULLADDER_1_vlg_sample_tst;
