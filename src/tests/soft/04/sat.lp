%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).
teacher(profCCC).
teacher(profDDD).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(mac111, 1, profAAA).
course(mac222, 1, profAAA).
course(mac333, 1, profBBB).
course(mac444, 1, profBBB).
course(mac555, 1, profCCC).
course(mac666, 1, profDDD).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA, 111, 0).
available(profAAA, 211, 0).
available(profBBB, 111, 0).
available(profBBB, 211, 0).
available(profCCC, 211, 0).
available(profDDD, 211, 0).

%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac111, 1).
num_classes(mac222, 1).
num_classes(mac333, 1).
num_classes(mac444, 1).
num_classes(mac555, 1).
num_classes(mac666, 1).

%*
curriculum/3(course id, curriculum, isRequired)
-----------------------------------
*%
curriculum(mac111,systems,0).
curriculum(mac333,systems,0).
curriculum(mac222,ai,0).
curriculum(mac444,ai,0).
curriculum(mac555,ai,0).
curriculum(mac666,ai,0).
