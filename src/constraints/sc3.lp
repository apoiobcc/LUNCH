%*
Soft #3
-------------------------------------
Required courses should not conflict with other required courses of the same curriculum
*%

weak(1, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
              obligatory(C1, IDEAL1), obligatory(C2, IDEAL2),
              curriculum(C1, CUR1), curriculum(C2, CUR2),
              CUR1 == CUR2,
              Id = @concat(@concat(C1,G1), @concat(C2,G2)).