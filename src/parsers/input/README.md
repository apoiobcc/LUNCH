# Input Parser

## Courses Information

To use courses-input-parser.py, add your csv tables information to the csv_input directory and change the `arqs` dictionary in the code to yours files names.

The output will be generated in the clingo_input _files directory

## Semestral Information

For parsing the teacher's schedule and workload information for the semester, the program `python3 parser-input-semestral.py` expects the path for two files (in order):

- Teacher Schedule:

<a name="teacher_table"/>

|timestamp|username|(columns 2-6): preference [day of the week]|(columns 7-12): restriction [day of the week]|...
|---|---|---|---|---|
|2021/08/13 1:54:28 AM GMT-3|gold@ime.usp.br|8:00-10:00;10:00-12:00|16:00-18:00|

- WorkLoad:

<a name="workload_table"/>

|Course|Course's name|Group|Group of Permutation|Semester|Fixed Time|Teacher's name|Teacger's email|
|---|---|---|---|---|---|---|---|
|MAC0110|Introduction of Computer Science|BCC| |1| |Alfredo Goldman|gold@ime.usp|
|MAC0110|Introduction of Computer Science|Poli 1|Poli Web Classes|1|2a 8:00 e 4a 9:00|Alfredo Goldman|gold@ime.usp|

Run:

```
python3 parser-input-semestral.py <teacher_schedule_file.csv> <workload_file.csv>
```

## Parsers Objects
### Clausule

This object handles the transformation of lists into clingo input format. For transforming it is important to verify the text that are given as arguments of a certain clausule, for that we use the "verify" function. For printing we use the "assembleClausule" function

### Timecode

As our model uses codes for each class periods available in the institute, the Timecode object handles the transformation and stamps of times.

### Input Parser
The InputParser is an abstract class that have the assemble function responsable for "stringfying" the information into clingo clausules. The abstract method parse needs to be implementate for the specific file that the parser will be used.

#### Workload Parser
This parser implements the parse function to the [workload table](#workload_table) and returns the clausules for the "course" and "class" predicates

#### Teacher's Schedule Parser
This parser implements the parse function to the [teacher's schedule table](#teacher_table) and returns the clausule for the "available" predicate.

There are some supporting function to help parsing this file. The noAnswer function will receive a file name and a column with teachers name and return the names of all the teachers in that file that are not in the schedule file, giving for theses teachers availability in all periods (preferable argument = 0)
