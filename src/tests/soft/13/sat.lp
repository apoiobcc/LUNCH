%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).

teacher(profBBB).

%*
course/4(course id, group_id, teacher name)
-------------------------------------------
*%
course(mac111,45,profAAA).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA,211).
available(profAAA,321).
available(profAAA,312).

%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111,2).