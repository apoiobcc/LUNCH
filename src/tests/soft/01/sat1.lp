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
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA,111,0).
available(profAAA,211,0).
available(profAAA,311,0).

available(profBBB,211,0).
available(profBBB,411,0).

available(profCCC,311,0).
available(profCCC,511,0).


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

%*
elective/2(course id, ideal period)
-------------------------------------
*%

elective(mac444,5).

elective(mac555,6).
