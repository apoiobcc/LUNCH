%*
Restriction #10
-------------------------------------
If two classes are joint and taught by the same professor,
they have to be lectured at the same periods.
*%

:- class(C1, G1, T, P1), class(C2, G2, T, P2),
   not conflict(C1, G1, C2, G2, P1),
   joint(C1,C2).