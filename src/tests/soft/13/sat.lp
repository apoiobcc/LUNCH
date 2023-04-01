

%*
course/3(course id, group_id, teacher name)
------------------------------------------------------------
*%
course(macFFF, 45, profZZZ).
course(macMMM, 46, profZZZ).

%*
num_classes/2(course id, number of weekly courses)
------------------------------------------------------------
*%

num_classes(macFFF, 2).
num_classes(macMMM, 2).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%

available(profZZZ, 111, 1).
available(profZZZ, 311, 1).
available(profZZZ, 411, 1).
available(profXXX, 111, 1).
available(profXXX, 511, 1).

%*
joint/2(first course, second course)
---------------------------------
*%
joint(macMMM, macFFF).


#show class/4.