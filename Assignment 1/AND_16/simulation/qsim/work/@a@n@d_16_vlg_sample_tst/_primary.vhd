library verilog;
use verilog.vl_types.all;
entity AND_16_vlg_sample_tst is
    port(
        in1             : in     vl_logic_vector(15 downto 0);
        in2             : in     vl_logic_vector(15 downto 0);
        sampler_tx      : out    vl_logic
    );
end AND_16_vlg_sample_tst;
