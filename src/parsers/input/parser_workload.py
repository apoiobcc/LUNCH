'''
Clingo Input Workload Parser (Semestral)
----------------------
This colection of functions can parse a given csv files containing the semester workload.

Columns expected in the csv file: 
Cours code|Group|Teacher Username|Should Be Scheduled (1-Yes, 0-No)|Time Scheduled (Should Be Scheduled = 0)

Clasules generated:
- course/3(course id, group id, teacher id)
For the courses that should be scheduled
- class/4(course id, group id, teacher, period)
For the courses with fixed time
'''

import csv
from Clausule import Clausule
from Timecode import Timecode

def getWorkload(file_name):
    '''
        Receives the workload csv table 
        Returns two list of clausules
            The first one contains the "course" clausules
            The second one contains the "class" claules
    '''
    with open(file_name) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        t = Timecode()
        # stores the courses without fixed class time (will be scheduled)
        notFixed = list()
        # stores the courses with fixed class time
        fixed = list()
        # get header
        for row in csv_reader:
            headers = row
            break
        for row in csv_reader:
            if (row[0] == ""): continue
            courses = row[0].split('/')
            for course in courses:
                group = row[1]
                teacher = row[2]
                if (int(row[3]) == 1):
                    notFixed.append(Clausule("course", [course, group, teacher]))
                else:
                    for time in row[4].split('e'):
                        time = time.strip().split(' ')
                        day = t.getDayCode(time[0])
                        period = t.getPeriodCode(time[1])
                        for p in period:
                            fixed.append(Clausule(":- not class", [course, group, teacher, day+p]))
        return notFixed, fixed

def assembleWorkload(list):
    '''
        Given the list of dictionary and semester,
        Assemble the asp input for the course predicate of the given semester
    '''
    workload = ""
    for atom in list:
        workload = workload + atom.assembleClausule() + '\n'
    return workload[:-1]

