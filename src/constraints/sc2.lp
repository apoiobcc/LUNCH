%*
Soft #2
-------------------------------------
Required courses should not conflict with required courses of differents periods
*%

weak(10, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              obligatory(C1, IDEAL1), obligatory(C2, IDEAL2),
              IDEAL1 != IDEAL2,
              Id = @concat("sc2",C1,G1,C2,G2).