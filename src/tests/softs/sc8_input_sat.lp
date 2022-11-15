%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(mac4722, 1, profAAA, 1). % High demand post grad course
course(macNotScience1, 1, profAAA, 1).
course(macNotScience2, 1, profBBB, 1).
course(mac5711, 1, profBBB, 1). % High demand post grad course

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA, 111).
available(profAAA, 211).
available(profBBB, 111).
available(profBBB, 211).
