module tb_seq;
	import uvm_pkg::*;
   `include "uvm_macros.svh"
   import pds_pkg::*;
   
   pds_seq_item p1, p2, p3;
   
   initial begin
	   p1=new("p1");
	   p2=new("p2");
	   assert(p1.randomize());
	   p2.copy(p1);
	   $cast(p3,p1.clone());
	   p1.print();
	   p2.print();
	   p3.print();
	   $finish();
	   
   end
   
endmodule