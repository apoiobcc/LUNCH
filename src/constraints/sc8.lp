%*
Soft #8
-------------------------------------
High demand post grad courses should not conflict
*%

%*
High demand post grad courses(course id):
*%

weak(W, Pr, Id) :- class(C1, _, _, P), class(C2, _, _, P),
              highDemand(C1), highDemand(C2),
              W = @get_weight("sc8"),
              Pr = @get_priority("sc8"),
              Id = @concat("sc8", C1, C2).
