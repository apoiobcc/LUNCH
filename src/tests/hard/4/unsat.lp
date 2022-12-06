%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).

%*
%*
course/3(course id, group id, teacher name)
------------------------------------------------------------
*%
course(macAAA, 1, profAAA)

%*
num_classes/2(class_id, number_of_weelky classes)
------------------------------------------------------------
*%
num_classes(macAAA,2).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA,112,0).

class(macAAA,1,profAAA,111).
