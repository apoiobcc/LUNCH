%*
Soft #5
-------------------------------------
Statistics courses and mandatory classes from 2nd year onwards should not conflict
*%

weak(W, Pr, Id) :- requiredElective(Cstat,statistics), obligatory(C2,X), X >= 3,
                 conflict(Cstat,Gstat,C2,G2,_),
                 W = @get_weight("sc5"),
                 Pr = @get_priority("sc5"),
                 Id = @concat("sc5",Cstat,Gstat,C2,G2).
