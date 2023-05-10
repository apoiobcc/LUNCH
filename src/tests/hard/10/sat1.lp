%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(macAAA, 1, profAAA, 1).
course(macBBB, 1, profAAA, 1).

%*
joint/2(first course id, second course id)
------------------------------------------------------------
*%
joint(macAAA, macBBB).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA, 111, 0).