class monitor;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual intf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
     @(posedge vif.clk) begin
      @(posedge vif.clk);
      trans.Rqst0   = vif.Rqst0;
      trans.Rqst1   = vif.Rqst1;
      trans.Rqst2   = vif.Rqst2;
      trans.Rqst3   = vif.Rqst3;
      end
      @(posedge vif.clk) begin
      trans.Grant0   = vif.Grant0;
      trans.Grant1   = vif.Grant1;
      trans.Grant2   = vif.Grant2;
      trans.Grant3   = vif.Grant3;
      end
      @(posedge vif.clk) begin
      mon2scb.put(trans);
      trans.display("[ Monitor ]");
      end
    end
  endtask
  
endclass
