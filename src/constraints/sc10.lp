%*
Soft #10
-------------------------------------
Courses should be given on teachers' preferred days
*%

:~  class(C1, G1, T1, P1),
    available(T2, P2, 0),
    T1 == T2, P1 == P2,
    W = @get_weight("sc10"),
    Pr = @get_priority("sc10").
    [W@Pr,"sc10",T1,P1]
