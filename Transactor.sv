class transaction;
  
  //declaring the transaction items
  rand bit Rqst0;
  rand bit Rqst1;
  rand bit Rqst2;
  rand bit Rqst3;
       bit Grant0;
       bit Grant1;
       bit Grant2;
       bit Grant3;
constraint in{
{Rqst0,Rqst1,Rqst2,Rqst3} inside {0,1,2,4,8};
}
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("-time = %0t rqst0 = %0d, rqst1 = %0d,rqst2 = %0d, rqst3 = %0d",$time,Rqst0,Rqst1,Rqst2,Rqst3);
    $display("- time = %0t grnt0 = %0d, grnt1 = %0d, grnt2 = %0d, grnt3 = %0d",$time,Grant0,Grant1,Grant2,Grant3);
    $display("-------------------------");
  endfunction
  function void accuracy(real a);
    $display("----------Accuracy Report----------");
    $display("Accuracy : %0d%",a);
    $display("----------Accuracy Report Done-----");
  endfunction
endclass
