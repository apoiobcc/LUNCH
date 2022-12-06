%*
Defines a specific number of classes per week
*%
#const n = 3.

%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).

%*
course/3(course id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(macAAA, 1, profAAA, n).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA, 111, 0).
available(profAAA, 211, 0).
available(profAAA, 311, 0).
