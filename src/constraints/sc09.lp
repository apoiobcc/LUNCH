%*
Soft #09
-------------------------------------
Post graduate courses should not conflict with other post graduate courses of the same scope
*%

:~  conflict(C1, G1, C2, G2, P),
    C1 > C2,
    postgrad(C1), postgrad(C2),
    scope(C1, SCP), scope(C2, SCP),
    W = @get_weight("sc09"),
    Pr = @get_priority("sc09").
    [W@Pr,"sc09",C1,G1,C2,G2]
