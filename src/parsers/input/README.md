# Input Parser

## Courses Information

To use courses-input-parser.py, add your csv tables information to the csv_input directory and change the `arqs` dictionary in the code to yours files names.

The output will be generated in the clingo_input _files directory

## Semestral Information

For parsing the teacher's schedule and workload information for the semester, the program `python3 parser-input-semestral.py` expects the path for two files (in order):

- Teacher Schedule:

|timestamp|username|(columns 2-6): preference [day of the week]|(columns 7-12): restriction [day of the week]|...
|---|---|---|---|---|
|2021/08/13 1:54:28 AM GMT-3|gold@ime.usp.br|8:00-10:00;10:00-12:00|16:00-18:00|

- WorkLoad:

|Course code|Group|Teacher Username|Should Be Scheduled (1-Yes, 0-No)|Time Scheduled (Should Be Scheduled = 0)
|---|---|---|---|---|
|MAC0110|45-BCC|gold|1||
|MAC0110|1-POLI|gold|0|2a 8:00 e 4a 10:00|

Run:

```
python3 parser-input-semestral.py <teacher_schedule_file.csv> <workload_file.csv>
```

