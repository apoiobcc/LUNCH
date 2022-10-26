# Input Parser

## Courses Information

To use courses-input-parser.py, add your csv tables information to the csv_input directory and change the `arqs` dictionary in the code to yours files names.

The output will be generated in the clingo_input _files directory

## Teacher Schedule Information

For parsing the teacher's schedule information, the program `parser-input-teacher-schedule.py` expects the path for the csv file containing the information in the format:

|timestamp|username|(columns 2-6): preference [day of the week]|(columns 7-12): restriction [day of the week]|...
|---|---|---|---|---|
|2021/08/13 1:54:28 AM GMT-3|myusername@ime.usp.br|8:00-10:00;10:00-12:00|16:00-18:00|

Run: 

```
parser-input-teacher-schedule.py <file_name>
```

