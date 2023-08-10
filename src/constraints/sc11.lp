%*
Soft #11
-------------------------------------
Classes of the same course should not be given in consecutive days
*%

:~  class(C1, G1, _, P1), class(C1, G1, _, P2),
    P1 > P2,
    not double(C1),
    @get_digit(P1,3) != @get_digit(P2,3) + 2,
    W = @calculate_weight_sc11(@get_digit(P1,3) - @get_digit(P2,3)),
    Pr = @get_priority("sc11").
    [W@Pr,"sc11",C1,G1]
