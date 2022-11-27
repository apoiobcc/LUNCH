%*
This test assumes that the weight for conflicting with a mandatory course in a
curriculum is greater than the weight for conflicting with a non-mandatory one.
*%


%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).
teacher(profCCC).

%*
course/4(course id, group_id, teacher name)
-------------------------------------------
*%
course(mac111,45,profAAA).
course(mac333,66,profBBB).
course(mac555,66,profCCC).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA,211).
available(profAAA,411).

available(profBBB,211).
available(profBBB,311).
available(profBBB,511).

available(profCCC,311).
available(profCCC,111).


%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%

num_classes(mac111,2).
num_classes(mac333,2).
num_classes(mac555,2).


%*
postgrad/1(course id)
-------------------------------------
*%
postgrad(mac111).
postgrad(mac333).
postgrad(mac555).

%*
curriculum/3(course id, curriculum, isRequired)
-------------------------------------
*%

curriculum(mac111, pos_systems, 1).
curriculum(mac333, pos_systems, 1).
curriculum(mac555, pos_systems, 0).