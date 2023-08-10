%*
Soft #01
-------------------------------------
Required courses should not conflict with electives of close periods
The lower the difference between the periods, the higher should be
the weight of that occurrence
*%

:~  conflict(C1, G1, C2, G2, P),
    obligatory(C1, IDEAL1), elective(C2, IDEAL2),
    W = @calculate_weight_sc01(IDEAL1, IDEAL2),
    Pr = @get_priority("sc01").
    [W@Pr,"sc01",C1,G1,C2,G2]
