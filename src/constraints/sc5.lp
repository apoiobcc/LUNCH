%*
Soft #5
-------------------------------------
Statistics courses and mandatory classes from 2nd year onwards should not conflict
*%

weak(4, 1,Id) :- requiredElective(Cstat,statistics),obligatory(C2,X), X >= 3,
				 conflict(Cstat,_,C2,_,_),
				 Id = @concat("sc5",Cstat,C2).