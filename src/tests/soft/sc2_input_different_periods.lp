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
course(mac444,57,profBBB).
course(mac555,76,profCCC).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA,111).
available(profAAA,211).
available(profAAA,311).

available(profBBB,211).
available(profBBB,411).

available(profCCC,311).
available(profCCC,511).


%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%

num_classes(mac444,2).
num_classes(mac555,2).
num_classes(mac111,2).


%*
obligatory/2(course id, ideal period)
-------------------------------------
*%
obligatory(mac111,4).

obligatory(mac444,5).

obligatory(mac555,6).
