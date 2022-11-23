%*
Restriction #8
-------------------------------------
Some courses have practical class right after the theoretical class
*%

:- class(C, G, _, P1), class(C, G, _, P2),
   double(C),
   P1 != P2, P2 > P1, P2 - P1 != 1.
