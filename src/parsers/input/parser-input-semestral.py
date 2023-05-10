"""
Clingo Input Semestral Parser
----------------------
This program can parse a given csv files containing semestral information about the course.
Input:
- First argument is the path for the csv file with teachers schedule information
- Second argument is the path for the csv file with workload information

Output: clingo input files in the clingo_input_files directory.
The names of each file will be the predicate name.
If the file already exists, **it will append the new information**.

Running:

Create a directory named clingo_input_files

$ python3 parser-input-semestral.py <teacher_schedule_file.csv> <workload_file.csv>

"""

import sys

from ParserTeacherSchedule import *
from ParserWorkload import *


def main():
    teacher_sched_file = sys.argv[1]
    workload_file = sys.argv[2]

    wparser = ParserWorkload(workload_file)
    workload = wparser.assemble(wparser.parse())

    tparser = ParserTeacherSchedule(teacher_sched_file)
    tparser.setRestriction(wparser.service)
    teachers = tparser.assemble(tparser.parse())
    noAnswer = tparser.assemble(tparser.noAnswer(workload_file, 7))

    if len(sys.argv) > 3:
        for v in workload.values():
            print(v)
        for v in teachers.values():
            print(v)
        for v in noAnswer.values():
            print(v)
    else:
        for k, v in workload.items():
            with open(f"clingo_input_files/{k}.txt", "a") as clingo_input_file:
                clingo_input_file.write(v)
        for k, v in teachers.items():
            with open(f"clingo_input_files/{k}.txt", "a") as clingo_input_file:
                clingo_input_file.write(v)
        for k, v in noAnswer.items():
            with open(f"clingo_input_files/{k}.txt", "a") as clingo_input_file:
                clingo_input_file.write(v)


main()
