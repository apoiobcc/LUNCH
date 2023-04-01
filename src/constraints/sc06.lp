%*
Soft #06
-------------------------------------
Statistics courses and mandatory classes from 2nd year onwards should not conflict
*%

weak(W, Pr, Id) :- requiredElective(Cstat,statistics), obligatory(C2,X), X >= 3,
                 conflict(Cstat,Gstat,C2,G2,_),
                 W = @get_weight("sc06"),
                 Pr = @get_priority("sc06"),
                 Id = @concat("sc06",Cstat,Gstat,C2,G2).
