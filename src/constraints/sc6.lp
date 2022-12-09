%*
Soft #6
-------------------------------------
Courses should not conflict with other courses of the same postgraduate curriculum
*%

weak(W, Pr, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
                conflict(C1, G1, C2, G2, P),
                C1 > C2,
                postgrad(C1), postgrad(C2),
                curriculum(C1, CUR1, _), curriculum(C2, CUR2, _),
                W = @calculate_weight_sc6(CUR1, CUR2),
                Pr = @get_priority("sc6"),
                Id = @concat("sc6",C1,G1,C2,G2).
