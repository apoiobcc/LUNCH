%*
Restriction #1
-------------------------------------
Two classes lectured by the same teacher cannot conflict.
*%
:- course(C1, G1, T, _), course(C2, G2, T, _), conflict(C1, G1, C2, G2, _).