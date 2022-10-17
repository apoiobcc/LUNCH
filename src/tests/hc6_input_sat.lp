%*
teacher/1(teacher name)
*%
teacher(profAAA).
teacher(profBBB).

%*
available/2(teacher name, period)
*%
available(profAAA, 111).
available(profAAA, 122).

available(profBBB, 311).
available(profBBB, 211).

%*
obligatory/2(course id, ideal period):
*%
obrigatory(macAAA, 1).
obrigatory(macBBB, 1).

%*
num_classes/2(class_id, number_of_weelky classes):
*%
num_classes(macAAA, 2).
num_classes(macBBB, 2).

%*
course/3(course id, group id, teacher name)
*%
course(macAAA, 1, profAAA).
course(macBBB, 1, profBBB).
