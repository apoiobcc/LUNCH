%*
Soft #4
-------------------------------------
Science courses  should not conflict with other obligatory
*%

weak(5, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              curriculum(C1, sciences, 1),
              obligatory(C2, _),
              Id = @concat("sc4",C1,G1,C2,G2).
