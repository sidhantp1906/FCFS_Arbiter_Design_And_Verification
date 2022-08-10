`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "directed_test.sv"
//----------------------------------------------------------------

module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit resetn;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    resetn = 0;
    #5 resetn =1;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  intf i_intf(clk,resetn);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
 Arbiter DUT (
    .clk(i_intf.clk),
    .resetn(i_intf.resetn),
    .Rqst0(i_intf.Rqst0),
    .Rqst1(i_intf.Rqst1),
    .Rqst2(i_intf.Rqst2),
    .Rqst3(i_intf.Rqst3),
    .Grant0(i_intf.Grant0),
    .Grant1(i_intf.Grant1),
    .Grant2(i_intf.Grant2),
    .Grant3(i_intf.Grant3)
   );
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
