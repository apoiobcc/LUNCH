%*
Soft #02
-------------------------------------
Required courses should not conflict with required courses of differents periods
The lower the difference between the periods, the higher should be
the weight of that occurrence
*%

:~  conflict(C1, G1, C2, G2, P),
    obligatory(C1, IDEAL1), obligatory(C2, IDEAL2),
    C1 > C2,
    IDEAL1 != IDEAL2,
    W = @calculate_weight_sc02(IDEAL1, IDEAL2),
    Pr = @get_priority("sc02").
    [W@Pr,"sc02",C1,G1,C2,G2]
