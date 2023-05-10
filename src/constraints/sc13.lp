%*
Soft #13
-------------------------------------
Avoid all kinds of conflicts
*%
#const sc13W = @get_weight("sc13").
#const sc13P = @get_priority("sc13").

% case 1: C1 and C2 belong to some joint predicate
weak(sc13W, sc13P, Id) :- conflict(C1, G1, C2, G2,_),
                    C1 != C2, C1 > C2,
                    not joint(C1, C2),
                    joint(C1,X),
                    joint(C2,Y),
                    Id = @concat("sc13",@joint_id(C1,X),@joint_id(C2,Y)).

% case 2: C1 belongs to some joint predicate, but C2 does not
weak(sc13W, sc13P, Id) :- conflict(C1, G1, C2, G2,_),
                    C1 != C2, C1 > C2,
                    not joint(C1, C2),
                    joint(C1,X),
                    not joint(C2,_),
                    Id = @concat("sc13",@joint_id(C1,X),C2,G2).

% case 3: C2 belongs to some joint predicate, but C1 does not
weak(sc13W, sc13P, Id) :- conflict(C1, G1, C2, G2,_),
                    C1 != C2, C1 > C2,
                    not joint(C1, C2),
                    not joint(C1,_),
                    joint(C2,Y),
                    Id = @concat("sc13",C1,G1,@joint_id(C2,Y)).

% case 4: neither C1 nor C2 belong to some joint predicate
weak(sc13W, sc13P, Id) :- conflict(C1, G1, C2, G2,_),
                    C1 != C2, C1 > C2,
                    not joint(C1, C2),
                    not joint(C1,_),
                    not joint(C2,_),
                    Id = @concat("sc13",C1,G1,C2,G2).

