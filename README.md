# Class Scheduler

## Introduction

This project aims to facilitate the process of scheduling classes. Given the classes that must be taught that semester, their frequency, the professors who lectures each class and the professors' availability the program generates timetables that follow the restrictions. In addition, we seek to improve the program by giving weak restrictions that can be used to decide which are the best schedules generated. 

It will be using Potassco Clingo ASP language to resolve the problem by satisfability.

## Model
- The *Input*'s predicates are used to populate the model.

- The *Output*'s predicate reveals the time table schedule.

- The *Support*'s predicates are used to describe some restrictions or as alias to other predicates.

### Input

####  **course/3(course id, group id, teacher id)**: 

Identifies a course offering by a discipline id and a group id that should be tought by a especific teacher.

Example:
```
course(macAAA, 1, profAAA).
course(macAAA, 2, profAAA).
course(macBBB, 1, profBBB).
```

####  **num_classes/2(class_id, number_of_weelky classes)**: 

Assign the frenquency for a given class (or how many time it should be tought in a week).

A class cannot be defined with two different frequencies.

Example:
```
num_classes(macAAA, 2).
num_classes(macBBB, 2).

% restriction
:- num_classes(C, H1), num_classes(C, H2), H1 != H2.
```

####  **available/2(teacher name, period)** 

Indicates a teacher's available lecturing periods.

A period is represented by a three digits number in which:
- The most significant bit represents the day of the week (1 to 5, monday to friday)
- The middle bit represents the period of the day (1 = morning, 2 = afternoon)
- The last bit represents the hour in the period

Example:
```
available(profAAA, 121). % profAAA is available on monday's first period of the afternoon

available(profAAA, 212). % profAAA is available on tuesday's second period of the morning
```

####  **postgrad/1(course id)**: 

Identifies a course as part of the postgraduate curriculum. If it is not part of the postgraduate curriculum than the course is automatically part of the graduate curriculum.

Example:
```
postgrad(macBBB).
```

####  **curriculum/2(course id, curriculum)**: 

Identifies a course as part of a curriculum.

Example:
```
curriculum(macCCC, systems).
curriculum(macCCC, ai).
```

####  **obligatory/2(course id, ideal period)**: 

Identifies a course as obligatory, each obligatory course has its own ideal period.

Example:
```
obligatory(macAAA, 1).
```

####  **double/1(course id)**: 

Identifies that the course's classes should be consecutives.

Example:
```
double(macAAA).
```

### Output
####  **class/4(course id, group id, teacher, period)**: 

A class represents a cell in the schedule timetable.

It assigns a course and group to a teacher who will lecture it in a period.

It is genarated so N classes of a given course are scheduled, considering the teachers available periods. 
```
{ class(C, G, T, P) :- available(T, P) } == N :- course(C, G, T, N).
```

### Support

####  **course/4(course id, group id, teacher id, number of weekly classes)**: 

Identifies a course offering by its discipline id, a group id, a number of weekly classes and the responsible teacher. 

This predicate is generated as following:
```
course(C, G, T, N) :- course(C, G, T), num_classes(C, N).
```

####  **conflict/5(first course id, first course group, second course id, second course grouyp, period)**: 

Indicates a conflict between 2 classes of diferent courses or groups.

```
% class conflict
conflict(C1, G1, C2, G2, P) :-
    class(C1, G1, _, P),
    class(C2, G2, _, P),
    C1 != C2.

% group conflict
conflict(C1, G1, C2, G2, P) :-
    class(C1, G1, _, P),
    class(C2, G2, _, P),
    C1 == C2, G1 != G2.
```

####  **course/1(course id)**: 

Alias to course/4. Identifies a course.

This predicate is generated as following:
```
course(X) :- course(X, _, _, _).
```

####  **teacher/1(teacher_id)**: 

Identifies a teacher by id.

Example:
```
teacher(profAAA).
teacher(profBBB).
```
####  **joint/1(teacher_id)**:

Indicates classes that are lectured together, normally one from graduation and other from postgraduation.

Example:

```
joint(macAAA, macBBB).
```
