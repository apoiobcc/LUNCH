%*
teacher/1(teacher name)
-----------------------
Identifies a teacher by name.
*%
teacher(profAAA).

%*
course/3(course id, teacher name, number of weekly courses)
------------------------------------------------------------
Identifies a course by name and number of weekly classes.
*%
course(macAAA, 1, profAAA, 1).

%*
available/2(teacher name, period)
---------------------------------
Indicates a teacher's available lecturing periods.

A period is represented by a three digits number in which:
- The most significant bit represents the day of the week (1 to 5, monday to friday)
- The middle bit represents the period of the day (1 = morning, 2 = afternoon)
- The last bit represents the hour in the period

Examples:

available(profAAA, 121): profAAA is available on monday's first period of the
                         afternoon.

available(profAAA, 212): profAAA is available on tuesday's second period of the
                         morning.
*%
available(profAAA, 111).