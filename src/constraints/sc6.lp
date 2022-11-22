%*
Soft #6
-------------------------------------
Courses should not conflict with other courses of the same postgraduate curriculum
*%

weak(Weight, 1, Id) :- class(C1, G1, _, P), class(C2, G2, _, P),
                conflict(C1, G1, C2, G2, P),
                C1 > C2,
                postgrad(C1), postgrad(C2),
                curriculum(C1, CUR,_), curriculum(C2, CUR,_),
                Weight = @calculate_weight_sc6(CUR),
                Id = @concat("sc6",C1,G1,C2,G2).
