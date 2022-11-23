'''
Clingo Input Workload Parser (Semestral)
----------------------
This program can parse a given csv files containing the years workload (teacher-course relation).
Input: path to csv file containing the information.
Output: file containing asp clausules for the course predicate  
The names of each file will be the predicate name and semester/year.
(Ex: input file = 2023.csv, output file = course1s22.txt and course2s22.txt)
If the file already exists, it will append the new information.

Running: 

Create a directory named clingo_input_files 

$ python3 parser-input-workload.py <file_name>

'''

import csv
from Clausule import clausule

PTIMESTAMP = ["08:00", "10:00", "14:00", "16:00"]
PCODES = [11,12,21,22]
PMAX = "18:00"

def getDay(day):
    return (100 * (int(day[0]) - 1))

def getPeriod(period):
    if not period[:2].isdigit():
        period = '0' + period
    if period in PTIMESTAMP:
        return [PCODES[PTIMESTAMP.index(period)]]
    for i in range(len(PTIMESTAMP)-1):
        if PTIMESTAMP[i] < period and period < PTIMESTAMP[i+1]:
            return [PCODES[i], PCODES[i+1]]
    if period > PTIMESTAMP[-1] and period < PMAX:
        return [PCODES[-1]]
    return []



def getWorkload(file_name):
    '''
        Receives the workload csv table 
        Returns two list of clausules
            The first one contains the "course" clausules
            The second one contains the "class" claules
    '''
    with open(file_name) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        notFixed = list()
        fixed = list()
        # get header
        for row in csv_reader:
            headers = row
            break
        for row in csv_reader:
            if (row[0] == ""): continue
            courses = row[0].split('/')
            for course in courses:
                # if course[0].isdigit(): atom['course'] = 'mac'+ course
                # course = course
                group = row[1]
                teacher = row[2]
                # semeste = int(row[2][0])
                if (int(row[3]) == 1):
                    notFixed.append(clausule("course", [course, group, teacher]))
                else:
                    for time in row[4].split('e'):
                        time = time.strip().split(' ')
                        day = getDay(time[0])
                        period = getPeriod(time[1])
                        for p in period:
                            fixed.append(clausule("class", [course, group, teacher, day+p]))
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

