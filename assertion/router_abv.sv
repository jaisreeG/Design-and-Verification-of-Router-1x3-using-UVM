module router_abv(input logic clock,
                  input logic resetn,
                  input logic[7:0] data_in,
                  input logic pkt_valid,
                  input logic busy,
                  input logic read_enb_0,
                  input logic read_enb_1,
                  input logic read_enb_2,
                  input logic[7:0] data_out_0,
                  input logic[7:0] data_out_1,
                  input logic[7:0] data_out_2,
                  input logic vld_out_0,
                  input logic vld_out_1,
                  input logic vld_out_2
                 );

property pkt_vld;
        @(posedge clock) $rose(pkt_valid) |=> busy;
endproperty

property data_stable;
        @(posedge clock) busy |=> $stable(data_in);
endproperty

property vld_dest;
        @(posedge clock) $rose(pkt_valid) |-> data_in[1:0] != 2'b11;
endproperty

property read0;
        @(posedge clock) $rose(vld_out_0) |=> ##[0:29] read_enb_0;
endproperty

property read1;
        @(posedge clock) $rose(vld_out_1) |=> ##[0:29] read_enb_1;
endproperty

property read2;
        @(posedge clock) $rose(vld_out_2) |=> ##[0:29] read_enb_2;
endproperty

property valid0;
        bit[1:0] addr;
        @(posedge clock) ($rose(pkt_valid), addr = data_in[1:0]) ##3(addr==0) |=> vld_out_0;
endproperty

property valid1;
        bit[1:0] addr;
        @(posedge clock) ($rose(pkt_valid), addr = data_in[1:0]) ##3(addr==1) |=> vld_out_1;
endproperty

property valid2;
        bit[1:0] addr;
        @(posedge clock) ($rose(pkt_valid), addr = data_in[1:0]) ##3(addr==2) |=> vld_out_2;
endproperty

property read_enb_out0;
        @(posedge clock) (vld_out_0 && !read_enb_0) |=> $stable(data_out_0);
endproperty

property read_enb_out1;
        @(posedge clock) (vld_out_1 && !read_enb_1) |=> $stable(data_out_1);
endproperty

property read_enb_out2;
        @(posedge clock) (vld_out_2 && !read_enb_2) |=> $stable(data_out_2);
endproperty

property single_vld_out;
        @(posedge clock) $onehot0({vld_out_0, vld_out_1, vld_out_2});
endproperty

PACKET_VALID:           assert property(pkt_vld);
STABLE_INP_DATA:        assert property(data_stable);
VLD_DEST:               assert property(vld_dest);
VLD_READ_ENB_0:         assert property(read0);
VLD_READ_ENB_1:         assert property(read1);
VLD_READ_ENB_2:         assert property(read2);
VLD_OUT_ENB_0:          assert property(valid0);
VLD_OUT_ENB_1:          assert property(valid1);
VLD_OUT_ENB_2:          assert property(valid2);
DATA_STABLE_RD_0:       assert property(read_enb_out0);
DATA_STABLE_RD_1:       assert property(read_enb_out1);
DATA_STABLE_RD_2:       assert property(read_enb_out2);
SINGLE_VLD_OUT:         assert property(single_vld_out);

endmodule
