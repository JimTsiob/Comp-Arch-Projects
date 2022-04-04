library verilog;
use verilog.vl_types.all;
entity OR_2_vlg_sample_tst is
    port(
        IN1             : in     vl_logic;
        IN2             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end OR_2_vlg_sample_tst;
