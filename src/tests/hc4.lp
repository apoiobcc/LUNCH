%* HC4: The classes must be given in the avaliable schedule for each teacher.

This constrain is already defined in the following restriction at basic_constraints.lp:

class/3(course id, teacher name, day of week, period)
-----------------------------------------------------
Schedule N classes of a given course, considering the teachers available
periods. A class represents a cell in the schedule.

{ class(C, T, P) : available(T, P) } == N :- course(C, T, N).
*%