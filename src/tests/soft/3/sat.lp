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
course(macAAA, 1, profAAA, 1).
course(macBBB, 1, profAAA, 1).
course(macCCC, 1, profBBB, 1).
course(macDDD, 1, profBBB, 1).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA, 111).
available(profAAA, 211).
available(profBBB, 111).
available(profBBB, 211).

%*
obligatory/2(course id, ideal period):
*%
obligatory(macAAA, 1).
obligatory(macBBB, 3).
obligatory(macCCC, 4).
obligatory(macDDD, 5).

%*
curriculum/2(course id, curriculum)
-----------------------------------
Identifies a course as part of a curriculum.
*%
curriculum(macAAA, systems,1).
curriculum(macCCC, systems,1).
curriculum(macBBB, ai,1).
curriculum(macDDD, ai,1).
