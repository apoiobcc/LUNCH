%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).
teacher(profBBB).

%*
num_classes/2(class id, number of weelky classes)
-------------------------------------------------
Assign a number of weekly classes for a given class.
*%
num_classes(macAAA, 2).
num_classes(macBBB, 2).

%*
Restriction #(restriction identifier)
-------------------------------------
A class cannot be defined with two different number of weekly classes.
*%
:- num_classes(C, H1), num_classes(C, H2), H1 != H2.

%*
course/3(course id, group id, teacher id)
-----------------------------------------
Identifies a course offering by a discipline id and a group id.
*%
course(macAAA, 1, profAAA).
course(macAAA, 2, profAAA).
course(macBBB, 1, profBBB).

%*
course/4(course id, group id, teacher id, number of weekly classes)
-------------------------------------------------------------------
Identifies a course offering by a discipline id, a group id, a number of weekly
classes and the responsible teacher.
*%
course(C, G, T, N) :- course(C, G, T), num_classes(C, N).

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
obligatory/2(course id, ideal period)
-------------------------------------
Identifies a course as obligatory.
*%
obligatory(macAAA, 1).

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
available(profBBB, 112).

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
