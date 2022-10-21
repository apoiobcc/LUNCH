%*
Restriction #6
-------------------------------------
Required courses offered in the same ideal period must not conflict
*%

:- class(C1, G1, _, P), class(C2, G2, _, P),
   obligatory(C1, IDEAL1), obligatory(C2, IDEAL2),
   C1 != C2, IDEAL1 == IDEAL2, G1 == G2.