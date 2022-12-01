%*
course/1(course id)
-------------------
Alias to course/4.
*%
course(X) :- course(X, _, _, _).


%*
course/4(course id, group id, teacher id, number of weekly classes)
-------------------------------------------------------------------
Identifies a course offering by its discipline id, a group id,
a number of weekly classes and the responsible teacher.
*%
course(C, G, T, N) :- course(C, G, T), num_classes(C, N).

%*
-------------------------------------
A class cannot be defined with two different number of weekly classes.
NOTE: we maybe could expand this to contemplate all cases were two courses have
the same course id.
NOTE: discuss about two teachers lecturing the same subject
*%
:- course(C, _, _,  H1), course(C, _, _, H2), H1 != H2.

%*
class/4(course id, group id, teacher, period)
---------------------------------------------
Schedule N classes of a given course, considering the teachers available
periods. A class represents a cell in the schedule.
*%
{ class(C, G, T, P) : available(T, P,_) } == N :- course(C, G, T, N).

%*
conflict/5(first course id, first course group, second course id, second course grouyp, period)
-----------------------------------------------------------------------------------------------
Indicates a conflict between 2 classes of diferent courses or groups.
*%
% class conflict
conflict(C1, G1, C2, G2, P) :-
    class(C1, G1, _, P),
    class(C2, G2, _, P),
    C1 != C2.

% group conflict
conflict(C1, G1, C2, G2, P) :-
    class(C1, G1, _, P),
    class(C2, G2, _, P),
    C1 == C2, G1 != G2.


%*
joint/2(first course id, second course id)
------------------------------------------
Indicates classes that are lectured together, normally one from graduation and other from postgraduation
*%

joint(C1,C2) :- joint(C2,C1).