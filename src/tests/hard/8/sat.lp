%*
teacher/1(teacher name)
*%
teacher(profAAA).

%*
available/3(teacher name, period, is preferable)
*%
available(profAAA, 211, 0).
available(profAAA, 212, 0).
available(profAAA, 311, 0).

%*
num_classes/2(class_id, number_of_weelky classes):
*%
num_classes(macAAA, 2).

%*
double/1 (class_id):
*%
double(macAAA).

%*
course/3(course id, group id, teacher name)
*%
course(macAAA, 1, profAAA).
