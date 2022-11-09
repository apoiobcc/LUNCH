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

course(mac222,45,profBBB).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA,211).
available(profAAA,311).

available(profBBB,211).
available(profBBB,411).

%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111,2).

num_classes(mac222,2).