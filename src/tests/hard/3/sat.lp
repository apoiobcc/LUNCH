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
available/2(teacher name, period)
---------------------------------
*%
available(profAAA, 111).
available(profAAA, 211).
available(profAAA, 311).
