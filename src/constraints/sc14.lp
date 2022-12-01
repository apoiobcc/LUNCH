%*
Soft #14
-------------------------------------
Courses should be given on teachers' preferred days
*%

weak(5, 1, ID) :- class(C1, G1, T1, P1),
                   available(T2, P2, 0),
                   T1 == T2, P1 == P2,
                   ID = @concat("sc14", T1, P1).




