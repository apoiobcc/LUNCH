%*
Soft #1
-------------------------------------
Required courses should not conflict with electives of the same period
*%

weak(20, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              obligatory(C1, IDEAL1), elective(C2, IDEAL2),
              IDEAL1 == IDEAL2,
              Id = @concat("sc1",C1,G1,C2,G2).