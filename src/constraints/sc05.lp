%*
Soft #05
-------------------------------------
Science courses  should not conflict with other obligatory
*%

:~  class(C1, G1, _, P), class(C2, G2, _, P),
    curriculum(C1, sciences, 1),
    obligatory(C2, _),
    W = @get_weight("sc05"),
    Pr = @get_priority("sc05").
    [W@Pr,"sc05",C1,G1,C2,G2]
