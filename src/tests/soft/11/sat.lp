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
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA,211,0).
available(profAAA,311,0).
available(profAAA,411,0).

%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111,2).