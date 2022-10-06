%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).
teacher(profBBB).

%*
course/3(course id, teacher name, number of weekly courses)
------------------------------------------------------------
Identifies a course by name and number of weekly classes.
*%
course(macAAA, profAAA, 2).
course(macBBB, profBBB, 3).
course(macCCC, profAAA, 2).

%*
course/1(course id)
-------------------
Alias to course/3.
*%
course(X) :- course(X, _, _).

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
:- course(C, _,  H1), course(C, _, H2), H1 != H2.

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

%*
Restriction #(restriction identifier)
-------------------------------------
No classes can be scheduled on friday in the afternoon.
TODO: considerar que é só a graduação
*%
:- class(_, _, 521).
:- class(_, _, 522).


%*
Restriction #(restriction identifier)
-------------------------------------
Two classes lectured by the same teacher cannot conflict.
*%
:- course(C1, T, _), course(C2, T, _), conflict(C1, C2, _).

#show class/3.
