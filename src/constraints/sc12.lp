%*
Soft #12
-------------------------------------
Classes should not be given in different times of the day (morning/afternoon)
*%

:~  class(C1, G1, _, P1), class(C1, G1, _, P2), P1 != P2,
    @get_digit(P1,2) != @get_digit(P2,2),
    W = @get_weight("sc12"),
    Pr = @get_priority("sc12").
    [W@Pr,"sc12",C1,G1]
