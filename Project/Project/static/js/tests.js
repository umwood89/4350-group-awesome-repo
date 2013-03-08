test("OK Pass",function(){ok( 1 == "1", "1 == 1, True");});
test("OK Fail",function(){ok( 1 == "2", "1 != 2, False");});
test("Equal Pass",function(){equal(1+1,2,"1+1=2");});
test("Equal Fail",function(){equal(2+1,4,"2+1=3");});