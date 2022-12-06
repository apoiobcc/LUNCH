%*
teacher/1(teacher name)
*%
teacher(profAAA).
teacher(profBBB).

%*
available/3(teacher name, period, is preferable)
*%
available(profAAA, 111, 0).
available(profAAA, 122, 0).

available(profBBB, 111, 0).
available(profBBB, 122, 0).

%*
obligatory/2(course id, ideal period):
*%
obligatory(macAAA, 1).
obligatory(macBBB, 1).

%*
num_classes/2(class_id, number_of_weelky classes):
*%
num_classes(macAAA, 2).
num_classes(macBBB, 2).

%*
course/3(course id, group id, teacher name)
*%
course(macAAA, 1, profAAA).
course(macBBB, 2, profBBB).
