%*
course/1(course id)
-------------------
Alias to course/3.
*%
course(X) :- course(X, _, _).

%*
Restriction #(restriction identifier)
-------------------------------------
A class cannot be defined with two different number of weekly classes.
NOTE: we maybe could expand this to contemplate all cases were two courses have
the same course id.
NOTE: discuss about two teachers lecturing the same subject
*%
:- course(C, _,  H1), course(C, _, H2), H1 != H2.

%*
class/3(course id, teacher name, day of week, period)
-----------------------------------------------------
Schedule N classes of a given course, considering the teachers available
periods. A class represents a cell in the schedule.
*%
{ class(C, T, P) : available(T, P) } == N :- course(C, T, N).

%*
conflict/3(course id 1, course id 2, period)
--------------------------------------------
Indicates a conflict between 2 classes of diferent courses.
*%
conflict(C1, C2, P) :- class(C1, _, P), class(C2, _, P), C1 != C2.