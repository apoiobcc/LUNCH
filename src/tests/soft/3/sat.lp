%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).
teacher(profCCC).
teacher(profDDD).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(macAAA, 1, profAAA, 1).
course(macBBB, 1, profAAA, 1).
course(macCCC, 1, profBBB, 1).
course(macDDD, 1, profBBB, 1).
course(macEEE, 1, profCCC, 1).
course(macFFF, 1, profDDD, 1).

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA, 111).
available(profAAA, 211).
available(profBBB, 111).
available(profBBB, 211).
available(profCCC, 211).
available(profDDD, 211).

%*
curriculum/3(course id, curriculum, isRequired)
-----------------------------------
Identifies a course as part of a curriculum.
*%
curriculum(macAAA,systems,1).
curriculum(macCCC,systems,1).
curriculum(macBBB,ai,1).
curriculum(macDDD,ai,1).
curriculum(macEEE,ai,0).
curriculum(macFFF,ai,1).
