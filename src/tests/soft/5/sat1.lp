%*
teacher/1(teacher name)
-----------------------
*%
teacher(profCCC).
teacher(profDDD).

%*
course/4(course id, group_id, teacher name)
-------------------------------------------
*%
course(mac333,66,profCCC).
course(mac444,45,profDDD).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profCCC,311).
available(profDDD,311).
available(profDDD,411).


%*
num_classes/2(course id, number of weekly courses)
--------------------------------------------------
*%
num_classes(mac333,1).
num_classes(mac444,1).


%*
obligatory/2(course id, ideal period)
-------------------------------------
*%
obligatory(mac333,6).

%*
requiredElective/2(course id, curriculum)
----------------------------------
*%
requiredElective(mac444,statistics).