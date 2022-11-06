%*
Soft #1
-------------------------------------
Required courses should not conflict with electives of close periods
The lower the difference between the periods, the higher should be
the weight of that occurrence
*%

weak(weight, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              obligatory(C1, IDEAL1), elective(C2, IDEAL2),
              weight = @calculate_weight_sc1(IDEAL1, IDEAL2),
              Id = @concat("sc1",C1,G1,C2,G2).