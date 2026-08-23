class router_vbase_seq extends uvm_sequence #(uvm_sequence_item);

        `uvm_object_utils(router_vbase_seq)

        router_wr_sequencer wr_seqrh[];
        router_rd_sequencer rd_seqrh[];
        router_virtual_sequencer vseqrh;

        router_env_config m_cfg;

        extern function new(string name="router_vbase_seq");
        extern task body();

endclass

function router_vbase_seq ::new(string name ="router_vbase_seq");
        super.new(name);
endfunction

task router_vbase_seq ::body();
        if(!uvm_config_db #(router_env_config)::get(null,get_full_name(),"router_env_config",m_cfg))
                `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db have u set it?")
        wr_seqrh=new[m_cfg.no_of_write_agent];
        rd_seqrh=new[m_cfg.no_of_read_agent];
        assert($cast(vseqrh,m_sequencer))
                else
                        `uvm_error("BODY","error in cast of virtual sequencer")
        foreach(wr_seqrh[i])
                wr_seqrh[i]=vseqrh.wr_seqrh[i];
        foreach(rd_seqrh[i])
                rd_seqrh[i]=vseqrh.rd_seqrh[i];
endtask

//----------------------------------------------------------------------------------------------------------------------

class router_small_pkt_vseq extends router_vbase_seq;

        `uvm_object_utils(router_small_pkt_vseq)
        bit[1:0]addr;

        router_wxtns_small_pkt wrtns;
        router_rxtns1 rdtns;

        extern function new(string name="router_small_pkt_vseq");
        extern task body();

endclass

function router_small_pkt_vseq ::new(string name="router_small_pkt_vseq");
        super.new(name);
endfunction

task router_small_pkt_vseq::body();
        super.body();
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")
        if(m_cfg.has_wagent)
                wrtns=router_wxtns_small_pkt::type_id::create("wrtns");
        if(m_cfg.has_ragent)
                rdtns=router_rxtns1::type_id::create("rdtns");
        fork
                begin
                        wrtns.start(wr_seqrh[0]);
                end

                begin
                        if(addr==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr==2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end
        join
endtask

//----------------------------------------------------------------------------------------------------------------------------

class router_medium_pkt_vseq extends router_vbase_seq;

        `uvm_object_utils(router_medium_pkt_vseq)
        bit[1:0]addr;

        router_wxtns_medium_pkt wrtns;
        router_rxtns1 rdtns;

        extern function new(string name="router_medium_pkt_vseq");
        extern task body();

endclass

function router_medium_pkt_vseq ::new(string name="router_medium_pkt_vseq");
        super.new(name);
endfunction

task router_medium_pkt_vseq::body();
        super.body();
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")
        if(m_cfg.has_wagent)
                wrtns=router_wxtns_medium_pkt::type_id::create("wrtns");
        if(m_cfg.has_ragent)
                rdtns=router_rxtns1::type_id::create("rdtns");
        fork
                begin
                        wrtns.start(wr_seqrh[0]);
                end

                begin
                        if(addr==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr==2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end
        join
endtask

//-------------------------------------------------------------------------------------------------------------------

class router_large_pkt_vseq extends router_vbase_seq;

        `uvm_object_utils(router_large_pkt_vseq)
        bit[1:0]addr;

        router_wxtns_large_pkt wrtns;
        router_rxtns1 rdtns;

        extern function new(string name="router_large_pkt_vseq");
        extern task body();

endclass

function router_large_pkt_vseq ::new(string name="router_large_pkt_vseq");
        super.new(name);
endfunction

task router_large_pkt_vseq::body();
        super.body();
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")
        if(m_cfg.has_wagent)
                wrtns=router_wxtns_large_pkt::type_id::create("wrtns");
        if(m_cfg.has_ragent)
                rdtns=router_rxtns1::type_id::create("rdtns");
        fork
                begin
                        wrtns.start(wr_seqrh[0]);
                end

                begin
                        if(addr==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr==2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end
        join
endtask

//------------------------------------------------------------------------------------------------------------------------

class router_err_pkt_vseq extends router_vbase_seq;

        `uvm_object_utils(router_err_pkt_vseq)
        bit[1:0]addr;

        router_wxtns_err_pkt wrtns;
        router_rxtns1 rdtns;

        extern function new(string name="router_err_pkt_vseq");
        extern task body();

endclass

function router_err_pkt_vseq ::new(string name="router_err_pkt_vseq");
        super.new(name);
endfunction

task router_err_pkt_vseq::body();
        super.body();
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")
        if(m_cfg.has_wagent)
                wrtns=router_wxtns_err_pkt::type_id::create("wrtns");
        if(m_cfg.has_ragent)
                rdtns=router_rxtns1::type_id::create("rdtns");
        fork
                begin
                        wrtns.start(wr_seqrh[0]);
                end

                begin
                        if(addr==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr==2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end
        join
endtask
