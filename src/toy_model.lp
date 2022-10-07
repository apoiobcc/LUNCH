%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).
teacher(profBBB).

%*
course/4(course id, group id, teacher name, number of weekly courses)
---------------------------------------------------------------------
Identifies a course by a discipline id, a group id, a number of weekly classes
and the responsible teacher.
*%
course(macAAA, 1, profAAA, 2).
course(macBBB, 1, profBBB, 3).
course(macCCC, 1, profAAA, 2).

%*
course/1(course id)
-------------------
Alias to course/4.
*%
course(X) :- course(X, _, _, _).

%*
postgrad/1(course id)
---------------------
Identifies a course as part of the postgraduate curriculum.
*%
postgrad(macBBB).

%*
curriculum/2(course id, curriculum)
-----------------------------------
Identifies a course as part of a curriculum.
*%
curriculum(macCCC, systems).
curriculum(macCCC, ai).

%*
obligatory/1(course id)
-----------------------
Identifies a course as obligatory.
*%
obligatory(macAAA).

%*
Restriction #(restriction identifier)
-------------------------------------
A class cannot be defined with two different number of weekly classes.
NOTE: we maybe could expand this to contemplate all cases were two courses have
the same course id.
NOTE: discuss about two teachers lecturing the same subject
*%
:- course(C, _, _,  H1), course(C, _, _, H2), H1 != H2.

%*
available/2(teacher name, period)
---------------------------------
Indicates a teacher's available lecturing periods.

A period is represented by a three digits number in which:
- The most significant bit represents the day of the week (1 to 5, monday to friday)
- The middle bit represents the period of the day (1 = morning, 2 = afternoon)
- The last bit represents the hour in the period

Examples:

available(profAAA, 121): profAAA is available on monday's first period of the
                         afternoon.

available(profAAA, 212): profAAA is available on tuesday's second period of the
                         morning.
*%
available(profAAA, 111).
available(profAAA, 112).
available(profAAA, 121).
available(profAAA, 122).

available(profBBB, 111).
available(profBBB, 212).
available(profBBB, 412).

%*
class/4(course id, group id, teacher, period)
---------------------------------------------
Schedule N classes of a given course, considering the teachers available
periods. A class represents a cell in the schedule.
*%
{ class(C, G, T, P) : available(T, P) } == N :- course(C, G, T, N).

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
Restriction #(restriction identifier)
-------------------------------------
No classes can be scheduled on friday in the afternoon.
TODO: considerar que é só a graduação
*%
:- class(_, _, _, 521).
:- class(_, _, _, 522).

%*
Restriction #(restriction identifier)
-------------------------------------
Two classes lectured by the same teacher cannot conflict.
*%
:- course(C1, G1, T, _), course(C2, G2, T, _), conflict(C1, G1, C2, G2, _).

#show class/4.
