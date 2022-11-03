%*
Restriction #9
-------------------------------------
Classes of the same course and group cannot be given on the same day
*%

:- class(C, G, _, P1), class(C, G, _, P2),
   P1 != P2,
   P1/100 == P2/100,
   not double(C).