%*
Soft #6
-------------------------------------
Statistics courses and mandatory classes from 2nd year onwards should not conflict
*%

weak(W, Pr, Id) :- requiredElective(Cstat,statistics), obligatory(C2,X), X >= 3,
                 conflict(Cstat,Gstat,C2,G2,_),
                 W = @get_weight("sc6"),
                 Pr = @get_priority("sc6"),
                 Id = @concat("sc6",Cstat,Gstat,C2,G2).
