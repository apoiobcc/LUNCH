%*
Soft #14
-------------------------------------
Courses should be given on teachers' preferred days 
*%


weak(15, 1, ID) :- class(_, _, T1, P1), 
                   available(T2, P2, PREF),
                   T1 == T2, PREF == false, P1 == P2,
                   ID = @concat(T1, P1).



