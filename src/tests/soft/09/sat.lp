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
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA,211,0).
available(profAAA,411,0).

available(profBBB,211,0).
available(profBBB,311,0).
available(profBBB,411,0).

available(profCCC,311,0).
available(profCCC,411,0).


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
scope/2(course id, scope)
-------------------------------------
*%

scope(mac111, systems).
scope(mac333, systems).
scope(mac555, systems).
