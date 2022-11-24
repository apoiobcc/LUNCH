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

import csv, sys
from parser_teacher_schedule import * 
from parser_workload import * 

def getNoAnswerTeachers(teacher_sched_file, workload_file):
    """
        Return the names of the teachers who are not in the schedule file
        Before using this function, set the global variables
            teacher_sched_file : file with the teachers schedule
            TINDEX_SCHED : column containing teachers email in teachers schedule file
            workload_file : file containing the workload for the semester
            TINDEX_WORKLOAD : : column containing teachers username in teachers schedule file
    """
    with open(teacher_sched_file) as t_csv:
            teachers1 = set()
            csv_reader = csv.reader(t_csv, delimiter=',')
            # get header
            for row in csv_reader:
                headers = row
                break
            for row in csv_reader:
                teacher = row[1].split('@')[0]
                teachers1.update((teacher,))

    with open(workload_file) as w_csv:
            teachers2 = set()
            csv_reader = csv.reader(w_csv, delimiter=',')
            # get header
            for row in csv_reader:
                headers = row
                break
            for row in csv_reader:
                teacher = row[2]
                teachers2.update((teacher,))
    return list(teachers2.difference(teachers1))

def teacherSched(file_name, noAnswer):
    """
        Given the csv schedule file and list of no answer teachers,
        Creates the ASP clausules: available and preferable
    """
    info = getTeacherSched(file_name)
    available, preferable = getAvailablePreferable(info, noAnswer)
    with open(f"clingo_input_files/available.txt", 'a') as clingo_input_file:
        clingo_input_file.write(available)
    with open(f"clingo_input_files/preferable.txt", 'a') as clingo_input_file:
        clingo_input_file.write(preferable)

def workload(file_name):
    """
        Given the csv workload file,
        Creates the ASP clausules: course and class
    """
    notFixed, fixed = getWorkload(file_name)
    s1 = assembleWorkload(notFixed)
    s2 = assembleWorkload(fixed)

    with open(f"clingo_input_files/course.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s1)
    with open(f"clingo_input_files/class.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s2)

def main():
    teacher_sched_file = sys.argv[1]
    workload_file = sys.argv[2]

    noAnswer = getNoAnswerTeachers(teacher_sched_file, workload_file)
    teacherSched(teacher_sched_file, noAnswer)
    # workload(workload_file)

main()