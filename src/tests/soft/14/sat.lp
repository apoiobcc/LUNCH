
%*
course/3(course id, group_id, teacher name)
------------------------------------------------------------
*%

course(macFFF, 45, profFFF).
course(macMMM, 46, profMMM).


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

available(profFFF, 111, 1).
available(profFFF, 321, 0).
available(profFFF, 411, 1).
available(profFFF, 121, 0).
available(profFFF, 311, 0).

available(profMMM, 111, 1).
available(profMMM, 321, 0).
available(profMMM, 411, 0).
available(profMMM, 121, 1).
available(profMMM, 312, 1).
