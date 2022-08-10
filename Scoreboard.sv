class scoreboard;
   
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_transactions;
  int c;
  
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Compares the Actual result with the expected result
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
        if(({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0} == 4'b0000 && {trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0} == 4'b0000)||({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0} == 4'b0001 && {trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0} == 4'b0001)||({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0} == 4'b0010 && {trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0} == 4'b0010)||({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0} == 4'b0100 && {trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0} == 4'b0100)||
({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0} == 4'b1000 && {trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0} == 4'b1000))
       begin
          $display("Result is as Expected");
          c++;
        end
        else
          $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",({trans.Rqst3,trans.Rqst2,trans.Rqst1,trans.Rqst0}),{trans.Grant3,trans.Grant2,trans.Grant1,trans.Grant0});
        no_transactions++;
      trans.display("[ Scoreboard ]");
      trans.accuracy((c)*10);
    end
  endtask
  
endclass
