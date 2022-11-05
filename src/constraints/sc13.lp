%*
Soft #13
-------------------------------------
Classes should not be given in different times of the day (morning/afternoon)
*%
weak(4, 1,Id) :- class(C1, G1, _, P1), class(C1, G1, _, P2), P1 != P2,
               @get_digit(P1,2) != @get_digit(P2,2),
               Id = @concat("sc13",C1,G1).