import csv
from parser_teacher_schedule import * 
from parser_workload import * 

teacher_sched_file = "csv_input/2s22.csv"
TINDEX_SCHED = 1 # column containing teachers name in teachers schedule file
workload_file = "csv_input/carga_expl.csv"
TINDEX_WORKLOAD = 2 # column containing teachers name in workoad file

def getNoAnswerTeachers():
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
                teacher = row[TINDEX_SCHED].split('@')[0]
                teachers1.update((teacher,))

    with open(workload_file) as w_csv:
            teachers2 = set()
            csv_reader = csv.reader(w_csv, delimiter=',')
            # get header
            for row in csv_reader:
                headers = row
                break
            for row in csv_reader:
                teacher = row[TINDEX_WORKLOAD]
                teachers2.update((teacher,))
    return list(teachers2.difference(teachers1))

def teacherSched(file_name, noAnswer):
    info = getTeacherSched(file_name)
    available, preferable = getAvailablePreferable(info, noAnswer)
    with open(f"clingo_input_files/available{file_name[-8:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(available)
    with open(f"clingo_input_files/preferable{file_name[-8:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(preferable[:-1])

def workload(file_name):
    notFixed, fixed = getWorkload(file_name)
    s1 = assembleWorkload(notFixed)
    s2 = assembleWorkload(fixed)

    with open(f"clingo_input_files/course{file_name[-6:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s1)
    with open(f"clingo_input_files/class{file_name[-6:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s2)

def main():
    noAnswer = getNoAnswerTeachers()
    teacherSched(teacher_sched_file, noAnswer)
    workload(workload_file)

main()