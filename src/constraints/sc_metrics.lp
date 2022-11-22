%*
	Count each occurence of a soft constraint.
	Eg: weak(-4,1,sc4.ab).
		weak(-4,1,sc4.ac).
		------------------
		scCount("sc4",2)
*%

%*
weak/4(weight, priority, id, soft name)
-------------------------------------------
*%
weak(W, P, Id, Soft) :- weak(W, P, Id), Soft = @get_soft_name(Id).


%*
scCount/2(soft name, quantity)
-------------------------------------------
*%
scCount(Soft,C) :- C = #count{ W,P,Id : weak(W,P,Id,Soft)}, weak(_,_,_,Soft).
