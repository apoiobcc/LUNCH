%*
Defines a specific number of classes per week 
*%
#const n = 3.

%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).


%*
course/3(course id, teacher name, number of weekly courses)
------------------------------------------------------------
Identifies a course by name and number of weekly classes.
*%
course(macAAA, 1, profAAA, n).


%*
available/2(teacher name, period)
---------------------------------
Indicates a teacher's available lecturing periods.vailable on tuesday's second period of the
                         morning.
*%
available(profAAA, 111).
available(profAAA, 211).
available(profAAA, 311).
