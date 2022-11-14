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

$ python3 parser-input-workload.py

'''

import csv
import sys
import re

file_name = sys.argv[1]
group_id = {"BCC" : 0} #stores the id for each group
group_count = 0        #stores the number of groups (0 represents only bcc)

def getGroupId(course_name):
    # the group name is written between parenthesis
    start = course_name.find('(')
    if (start == -1): return 0
    end = course_name.find(')')
    group = course_name[start+1:end]
    # indexing groups
    if (group not in group_id.keys()):
        global group_count
        group_count += 1
        group_id[group] = group_count
    return group_id[group]

def getWorkload(file_name):
    '''
        Receives the workload csv table 
        Returns a list of dictionaries that have the keys: teacher, course, semester
    '''
    with open(file_name) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        info = list()
        # get header
        for row in csv_reader:
            headers = row
            break
        for row in csv_reader:
            if (row[0] == ""): continue
            courses = re.sub('[^0-9a-zA-Z/]+', '', row[0].lower()).split('/')
            for course in courses:
                atom = dict()
                if course[0].isdigit(): atom['course'] = 'mac'+ course
                else: atom['course'] = course
                atom['group'] = getGroupId(row[1])
                atom['teacher'] = row[4].lower().replace('.', '')
                atom['semester'] = int(row[2][0])
                info.append(atom)
        return info

def assembleWorkload(info, semester):
    '''
        Given the list of dictionary and semester,
        Assemble the asp input for the course predicate of the given semester
    '''
    workload = ""
    for atom in info:
        if (atom['semester'] != semester): continue
        workload = workload + f"course({atom['course']},{atom['group']},{atom['teacher']})." + '\n'
    return workload[:-1]

def main():
    info = getWorkload(file_name)
    s1 = assembleWorkload(info, 1)
    s2 = assembleWorkload(info, 2)
    with open(f"clingo_input_files/course1s{file_name[-6:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s1)
    with open(f"clingo_input_files/course2s{file_name[-6:-4]}.txt", 'a') as clingo_input_file:
        clingo_input_file.write(s2)

main()