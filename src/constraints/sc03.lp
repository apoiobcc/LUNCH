%*
Soft #03
-------------------------------------
Mandatory courses to complete a curriculum should not conflict
with other courses in this curriculum, mandatory or not.
*%

weak(W, Pr, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              conflict(C1, G1, C2, G2, P),
              C1 > C2,
              curriculum(C1, CUR, 1), curriculum(C2, CUR, 1),
              W = @get_weight("sc03"),
              Pr = @get_priority("sc03"),
              Id = @concat("sc03",C1,G1,C2,G2).

weak(W, Pr, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              conflict(C1, G1, C2, G2, P),
              curriculum(C1, CUR, 1), curriculum(C2, CUR, 0),
              W = @get_weight("sc03"),
              Pr = @get_priority("sc03"),
              Id = @concat("sc03",C1,G1,C2,G2).
