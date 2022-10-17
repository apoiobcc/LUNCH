%*
teacher/1(teacher name)
*%
teacher(profAAA).

%*
available/2(teacher name, period)
*%
available(profAAA,111).


%*
course/3(course id, group id, teacher name)
*%
course(macAAA, 1, profAAA).


:- not class(macAAA,1,profAAA,112).