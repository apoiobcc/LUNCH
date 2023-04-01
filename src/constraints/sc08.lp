%*
Soft #08
-------------------------------------
High demand post grad courses should not conflict
*%

weak(W, Pr, Id) :- class(C1, _, _, P), class(C2, _, _, P),
              highDemand(C1), highDemand(C2),
              W = @get_weight("sc08"),
              Pr = @get_priority("sc08"),
              Id = @concat("sc08", C1, C2).
