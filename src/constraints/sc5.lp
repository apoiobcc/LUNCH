%*
Soft #5
-------------------------------------
Statistics courses and mandatory classes from 2nd year onwards should not conflict
*%

weak(10, 1,Id) :- requiredElective(Cstat,statistics),obligatory(C2,X), X >= 3,
                 conflict(Cstat,Gstat,C2,G2,_),
                 Id = @concat("sc5",Cstat,Gstat,C2,G2).
