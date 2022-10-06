%*
Restriction #(restriction identifier)
-------------------------------------
Two classes lectured by the same teacher cannot conflict.
*%
:- course(C1, T, _), course(C2, T, _), conflict(C1, C2, _).