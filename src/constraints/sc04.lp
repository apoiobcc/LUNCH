%*
Soft #04
-------------------------------------
Non-mandatory courses in a curriculum should not conflict
with other non-mandatory courses in this curriculum.
*%

:~  conflict(C1, G1, C2, G2, P),
    C1 > C2,
    curriculum(C1, CUR, 0), curriculum(C2, CUR, 0),
    W = @get_weight("sc04"),
    Pr = @get_priority("sc04").
    [W@Pr,"sc04",C1,G1,C2,G2]
