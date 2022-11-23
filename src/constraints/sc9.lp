%*
Soft #9
-------------------------------------
Post graduate courses should not conflict with other post graduate courses of the same scope
*%

weak(10, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
                    conflict(C1, G1, C2, G2, P),
                    C1 > C2,
                    postgrad(C1), postgrad(C2),
                    scope(C1, SCP), scope(C2, SCP),
                    Id = @concat("sc9",C1,G1,C2,G2).
