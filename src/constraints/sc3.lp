%*
Soft #3
-------------------------------------
Required courses should not conflict with other required courses of the same curriculum
*%

weak(10, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              curriculum(C1, CUR, 1), curriculum(C2, CUR, 1),
              C1 > C2,
              Id = @concat("sc3",C1,G1,C2,G2).
