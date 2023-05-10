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
course(mac333,45,profCCC).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA,211,0).
available(profAAA,311,0).
available(profAAA,411,0).

available(profBBB,211,0).

available(profCCC,411,0).

%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111,2).
num_classes(mac222,1).
num_classes(mac333,1).

%*
obligatory/2(course id, ideal period)
-------------------------------------
*%
obligatory(mac111,4).

%*
requiredElective/2(course id, curriculum)
----------------------------------
*%
requiredElective(mac222,statistics).
requiredElective(mac333,statistics).