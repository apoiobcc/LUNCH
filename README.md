# Class Scheduler

## Introduction

This project aims to facilitate the process of scheduling classes. Given the classes that must be taught that semester, their frequency, the professors who lectures each class and the professors' availability the program generates timetables that follow the restrictions. In addition, we seek to improve the program by giving weak restrictions that can be used to decide which are the best schedules generated. The program uses [Potassco Clingo ASP language](https://potassco.org/) to resolve the problem by satisfiability. We also provide parsers (between CSV tables and clingo language) to facilitate the use of our program.

### Table of Content:
- [Running the code](#how-run)
- [Logic](#logic)
- [Constrains Indexes](#index)
    - [Hard Constraints](#index-hard)
    - [Soft Constraints](#index-soft)
- [Parsers](#parser)
    - [Fixed Input](#parser-input-fixed)
    - [Semestral Input](#parser-input-semestral)
    - [Output](#parser-output)
- [Tests](#tests)
    - [Hard Constraints](#tests-hard)
    - [Soft Constraints](#tests-soft)
- [Model](#model)
    - [Input Hard Constraints](#model-input-hard)
    - [Input Soft Constraints](#model-input-soft)
    - [Output](#model-output)
    - [Supporting](#model-supporting)
- [About Us](#about-us)


## Running the code <a name="how-run"/>

A [docker](https://www.docker.com/) image as well as a [docker-compose](https://docs.docker.com/compose/) configuration are available to facilitate the process of running and testing the project in multiple platforms. This is the preferred way of running if you are in a non Linux platform. The compose configuration exposes two commands: `dev` and `test`. The former can be used to create a bash terminal inside the dockerized environment, while the latter can be used to test the project's code. To run each command, use:

```
docker compose run --rm dev
docker compose run --rm test
```

It is also possible to run the scheduler outside of a Docker image, by installing the [clingo](https://potassco.org/clingo/) CLI tool:

```
# Using pip
pip install clingo

# Debian/Ubuntu
sudo apt install gringo
```

With the solver installed, either manually or using the docker commands, the scheduler can be ran via the `class_scheduler.sh` script. The scheduler expect two tables as inputs:

1. `schedule-csv`: teachers preferred periods per day of the week
2. `workload-csv`: information about the courses that should be offered in the semester, including information about the course name, id, teacher, etc.

Examples of each expected input CSV can be found in the `src/` directory.

The program will run for about 8 minutes, so don't be scared if it seems like it has frozen!

Options and help for the `class-scheduler` CLI app can be listed via the `-h` flag.

## Logic <a name="logic"/>

The project was divided in two main parts:

### Writing restriction rules

The restriction rules, or "hard constraints " of out model, are the clauses that define if a model is Satisfiable or not. If one rule is not true, than the model is unsatisfiable, if all rules are true, then we have a satisfiable solution.

These constraints can be divided into:

- basic constraints: general rules used for the logic environment preparation

- specific hard constraints: rules that need to be true for the Computer Science program (ex: two obligatory classes for the same year can't be given at the same time).

### Writing decisions rules

The decision rules, or "soft constraints", are used to score the satisfiable responses. A soft constraint will never discard a model, but if not true, will give a negative score for the schedule generated. This rules aims to facilitate the decision of which schedule should be chosen.

These rules and their weights were discussed between the students and represents what would make an ideal schedule for a semester in the CS course.


## Constraints Indexes <a name="index"/>

### Hard Constraints <a name="index-hard"/>

file | Constraint
---|---
hc1|Two classes lectured by the same teacher cannot conflict, unless they are the same courses but with 2 initials.
hc2|All courses defined for the semester must be given.
hc3 |Each courses assigned for the semester must have a defined number of classes per week.
hc4 | The classes must be given in the avaliable schedule for each teacher.
hc5 | No graduation classes can be scheduled on friday in the afternoon.
hc6 | Required courses offered in the same ideal period must not conflict.
hc7 | There are constant periods for obligatory courses from 1st and 2nd year .
hc8 | Some courses have practical class right after the theoretical class (double).
hc9 | Classes of the same course and group cannot be given on the same day.
hc10| If two classes are joint and taught by the same professor, they have to be lectured at the same periods.

### Soft Constraints <a name="index-soft"/>

file | Constraint
---|---
sc01 | Required courses should not conflict with electives of close periods.
sc02 | Required courses should not conflict with required courses of differents periods.
sc03 | Mandatory courses to complete a curriculum should not conflict with other courses in this curriculum, mandatory or not.
sc04 | Non-mandatory courses in a curriculum should not conflict with other non-mandatory courses in this curriculum.
sc05 | Science courses  should not conflict with other obligatory.
sc06 | Statistics courses and mandatory classes from 2nd year onwards should not conflict.
sc07 | Courses should not conflict with other courses of the same postgraduate curriculum.
sc08 | High demand post grad courses should not conflict.
sc09 | Post graduate courses should not conflict with other post graduate courses of the same scope.
sc10| Courses should be given on teachers' preferred days.
sc11| Classes should not be given in consecutive days.
sc12| Classes should not be given in different times of the day (morning/afternoon).
sc13| Avoid all kinds of conflicts.

## Parsers <a name="parser"/>

To facilitate the usage of our program, we provided three parsers:

### Fixed Input Parser <a name="parser-input-fixed"/>

For the names, classes per week, curriculum, obligatoriness and other fixed characteristics of a course we created a table containing these informations. We then used a parser to transform the table in ASP clausules. These clausules only need to be generated once, and are specific for the Computer Science program. For using this parser, consult the parser documentation in the parser directory.

### Semestral Input Parser <a name="parser-input-semestral"/>

The information regarding the teacher availability, preferable time, workload and the courses that will be given that semester is given as a table by the Computer Science’s Commission, the semestral parser aims to transform the table given in ASP clausules. This parser will be used every semester and supposes that the tables are patronized.
For using this parser, consult the parser documentation in the parser directory.


### Output Parser <a name="parser-output"/>

After running clingo, the output will be given in ASP clausules. To help read and transport the results, we created a parser that can transform these clausules into CSV tables. The user can choose to print this table in the terminal (uses python [tabule](https://pypi.org/project/tabulate/) ) or save in a CSV file.

## Tests <a name="tests"/>

### Hard Constraints <a name="tests-hard"/>

For each constraint we wrote an individual test set that can identify if the satisfiability and unsatisfiability are being corrected recognized. All tests can be run in the development environment with the command:

```
docker compose run --rm test
```

### Soft Constraints <a name="tests-soft"/>

For each soft constraint we wrote an example of a schedule that would be chosen by that decision rule. This test aims to manually verify if the constraint written will give more weight for the desired schedule.

## Model <a name="model"/>

- The *Input*'s predicates are used to populate the model.

- The *Output*'s predicate reveals the time table schedule.

- The *Supporting*'s predicates are used to describe some restrictions or as alias to other predicates.

### Input - Hard Constrains Input Predicates <a name="model-input-hard"/>

####  **course/3(course id, group id, teacher id)**:

Identifies a course offering by a discipline id and a group id that should be taught by a specific teacher.

Example:
```
course(macAAA, 1, profAAA).
course(macAAA, 2, profAAA).
course(macBBB, 1, profBBB).
```

####  **num_classes/2(class_id, number_of_weekly classes)**:

Assign the frequency for a given class (or how many time it should be taught in a week).

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
- The most significant bit represents the day of the week (1 to 5, Monday to Friday)
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

####  **obligatory/2(course id, ideal period)**:

Identifies a course as obligatory, each obligatory course has its own ideal period.

Example:
```
obligatory(macAAA, 1).
```

####  **double/1(course id)**:

Identifies that the course's classes should be consecutive.

Example:
```
double(macAAA).
```

####  **joint/1(teacher_id)**:

Indicates courses that are lectured together, normally one from graduation and other from post graduation.
Example:
```
joint(macAAA, macBBB).
```

### Input - Soft Constrains Input Predicates <a name="model-input-soft"/>

####  **curriculum/2(course id, curriculum, required)**:

Identifies a course as part of a curriculum. If the course is required for the conclusion of the curriculum, the last parameter is 1, else 0.

Example:
```
curriculum(macCCC, systems, 1).
curriculum(macCCC, ai, 0).
```
####  **preferable/2(teacher name, period)**

Indicates a teacher's available preferable period.

Example:
```
preferable(profAAA, 121). % profAAA prefers to lecture classes on monday's first period of the afternoon

preferable(profAAA, 212). % profAAA prefers to lecture classes on tuesday's second period of the morning
```

### Output <a name="model-output"/>

####  **class/4(course id, group id, teacher, period)**:

A class represents a cell in the schedule timetable.

It assigns a course and group to a teacher who will lecture it in a period.

It is generated so N classes of a given course are scheduled, considering the teachers available periods.
```
{ class(C, G, T, P) : available(T, P) } == N :- course(C, G, T, N).
```

### Supporting <a name="model-supporting"/>

####  **course/4(course id, group id, teacher id, number of weekly classes)**:

Identifies a course offering by its discipline id, a group id, a number of weekly classes and the responsible teacher.

This predicate is generated as following:
```
course(C, G, T, N) :- course(C, G, T), num_classes(C, N).
```

####  **conflict/5(first course id, first course group, second course id, second course group, period)**:

Indicates a conflict between 2 classes of different courses or groups.

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

<a name="about-us"/>

## About Us
We are a group of undergraduate and postgraduate Computer Science students from the Institute of Mathematics and Statistics - University of São Paulo. This project was developed during the MAC0472 course in the second semester of 2022.
