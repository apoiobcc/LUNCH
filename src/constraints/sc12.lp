%*
Soft #12
-------------------------------------
Classes should not be given in consecutive days
*%
weak(5, 1,Id) :- class(C1, G1, _, P1), class(C1, G1, _, P2),
               P1 != P2, @get_digit(P1,3) == @get_digit(P2,3)+1,
               Id = @concat("sc12",C1,G1).