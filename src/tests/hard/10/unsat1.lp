%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).

%*
course/4(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(macAAA, 1, profAAA, 2).
course(macBBB, 1, profAAA, 2).

%*
joint/2(first course id, second course id)
------------------------------------------------------------
*%
joint(macAAA, macBBB).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA, 111, 0).
available(profAAA, 211, 0).
available(profAAA, 311, 0).
available(profAAA, 411, 0).

class(macAAA, 1, profAAA, 111).
class(macAAA, 1, profAAA, 311).
class(macBBB, 1, profAAA, 111).
class(macBBB, 1, profAAA, 211).