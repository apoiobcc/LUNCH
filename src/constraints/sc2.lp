%*
Soft #2
-------------------------------------
Required courses should not conflict with required courses of differents periods
The lower the difference between the periods, the higher should be
the weight of that occurrence
*%

weak(W, Pr, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
                    conflict(C1, G1, C2, G2, P),
                    obligatory(C1, IDEAL1), obligatory(C2, IDEAL2),
                    C1 > C2,
                    IDEAL1 != IDEAL2,
                    W = @calculate_weight_sc2(IDEAL1, IDEAL2),
                    Pr = @get_priority("sc2"),
                    Id = @concat("sc2",C1,G1,C2,G2).
