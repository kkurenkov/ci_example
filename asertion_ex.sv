module asertion_ex;
  bit clk,a,b;
  bit c;
  //clock generation
  always #5 clk = ~clk;

    always @(posedge clk) begin
        c <= a;
        $display("a %0h b %0h c %0h", a,b,c);
    end

  //generating 'a'
  initial begin
      @(posedge clk);
    a=1;
    b=1;
    #15 b=0;
    #10 b=1;
        a=0;
    #20 a=1;
    #10;
    $finish;
  end



  //Immediate assertion
  always @(posedge clk) assert (a && b);
  assert property (@(posedge clk) a&&b |-> ##1 c);

// Format 1 - Inline expression
concurrent_assertion_name:                          // assertion label
    assert
        property (
            @(posedge clk) // disable iff (b)        // sampling event
            a |-> ##2 c                             // expression to check
        );
        // else                                        // (optional) error message
        //     $error("%m no grant after request");

// Format 2 - Separate property block
property ConcurrentPropName;
   @(posedge clk) //disable iff (rst)
   a |-> ##3 c;
endproperty
AssertionName: assert property (ConcurrentPropName);


endmodule
