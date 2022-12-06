%*
Soft #10
-------------------------------------
Non-mandatory courses in a curriculum should not conflict
with other non-mandatory courses in this curriculum.
*%

weak(10, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              conflict(C1, G1, C2, G2, P),
              C1 > C2,
              curriculum(C1, CUR, 0), curriculum(C2, CUR, 0),
              Id = @concat("sc3",C1,G1,C2,G2).