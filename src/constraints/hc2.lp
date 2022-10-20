%* HC2: All courses defined for the semester must be given
This constrain is already defined in the following restriction at basic_constraints.lp:

class/4(course id, group id, teacher, period)
---------------------------------------------
Schedule N classes of a given course, considering the teachers available
periods. A class represents a cell in the schedule.

{ class(C, G, T, P) : available(T, P) } == N :- course(C, G, T, N).
*%