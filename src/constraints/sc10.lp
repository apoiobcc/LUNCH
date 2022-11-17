%*
Soft #10
-------------------------------------
Courses regarded as easy should not conflict with other courses
*%
weak(2, 1) :- easy(C), conflict(C, _, _, _, _), conflict(_, _, C, _, _).


