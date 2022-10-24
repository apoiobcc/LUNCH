%*
Restriction #1
-------------------------------------
Two classes lectured by the same teacher cannot conflict, unless they are the same
courses but with 2 initials.
*%
:- course(C1, G1, T, _), course(C2, G2, T, _), conflict(C1, G1, C2, G2, _), not joint(C1,C2).

