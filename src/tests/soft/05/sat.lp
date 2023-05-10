%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(macObligatory1, 1, profAAA, 1).
course(macNotScience1, 1, profAAA, 1).
course(macNotScience2, 1, profBBB, 1).
course(macSciences1, 1, profBBB, 1).

%*
available/3(teacher name, period, is preferable)
---------------------------------
*%
available(profAAA, 111, 0).
available(profAAA, 211, 0).
available(profBBB, 111, 0).
available(profBBB, 211, 0).

%*
obligatory/2(course id, ideal period):
*%
obligatory(macObligatory1, 1).

%*
curriculum/2(course id, curriculum)
-----------------------------------
Identifies a course as part of a curriculum.
*%
curriculum(macSciences1, sciences, 1).