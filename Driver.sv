class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual intf vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual intf vif,mailbox gen2driv);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(!vif.resetn);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.Rqst0 <= 0;
    vif.Rqst1 <= 0;
    vif.Rqst2 <= 0;
    vif.Rqst3 <= 0;
    wait(vif.resetn);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  
  //drivers the transaction items to interface signals
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
      @(posedge vif.clk) begin
      vif.Rqst0     <= trans.Rqst0;
      vif.Rqst1     <= trans.Rqst1;
      vif.Rqst2     <= trans.Rqst2;
      vif.Rqst3     <= trans.Rqst3;
      end
      @(posedge vif.clk) begin
      trans.Grant0   <= vif.Grant0;
      trans.Grant1   <= vif.Grant1;
      trans.Grant2   <= vif.Grant2;
      trans.Grant3   <= vif.Grant3;
      end
      @(posedge vif.clk);
      	trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass
