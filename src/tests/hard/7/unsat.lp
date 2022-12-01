%*
teacher/1(teacher name)
*%
teacher(profAAA).

%*
available/3(teacher name, period, is preferable)
*%
available(profAAA,111,0).


%*
course/3(course id, group id, teacher name)
*%
course(macAAA, 1, profAAA).

:- not class(macAAA,1,profAAA,112).
