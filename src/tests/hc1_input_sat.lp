%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
Identifies a course by name and number of weekly classes.
*%
course(macAAA, 1, profAAA, 1).
course(macBBB, 1, profAAA, 1).

%*
available/2(teacher name, period)
---------------------------------
Indicates a teacher's available lecturing periods.
*%
available(profAAA, 111).
available(profAAA, 211).