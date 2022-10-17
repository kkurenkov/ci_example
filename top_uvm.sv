`include "uvm_macros.svh"
import uvm_pkg::*;

class delay_class extends uvm_test;
    `uvm_component_utils(delay_class)

    rand int unsigned time_delay;
    constraint time_delay_c {time_delay inside {[0:10]};}

    function new(string name = "delay_class", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new
   
    task get_delay;
        #time_delay;
        $display("time_delay = %0d, time = %0d",time_delay, $time());
    endtask

    task main_phase(uvm_phase phase);
        phase.raise_objection(this, "Starting main_phase" );

        // delay_class delay=new();
        // delay.rand_mode(0);
        // assert(delay.randomize() with {time_delay== 5;});
        assert(delay.randomize());
        delay.get_delay();

        // delay.rand_mode(1);
        assert(delay.randomize());
        delay.get_delay();

        phase.drop_objection(this, "Ending main_phase");
	endtask : main_phase

endclass

module tb_top;
    initial
        run_test();
endmodule : tb_top