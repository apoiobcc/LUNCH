%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).

teacher(profCCC).
teacher(profDDD).


%*
course/4(course id, group_id, teacher name)
-------------------------------------------
*%
course(mac111,45,profAAA).
course(mac222,45,profBBB).

course(mac333,66,profCCC).
course(mac444,66,profDDD).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA,211).
available(profBBB,211).

available(profCCC,311).
available(profDDD,311).


%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111,1).
num_classes(mac222,1).

num_classes(mac333,1).
num_classes(mac444,1).


%*
obligatory/2(course id, ideal period)
-------------------------------------
*%
obligatory(mac111,4).

obligatory(mac333,1).

%*
curriculum/2(course id, curriculum)
----------------------------------
*%
curriculum(mac222,statistics).

curriculum(mac444,statistics).