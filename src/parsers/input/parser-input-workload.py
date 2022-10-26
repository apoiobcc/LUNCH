import csv
import sys
import re

file_name = sys.argv[1]
group_id = {"BCC" : 0} #stores the id for each group
group_count = 0        #stores the number of groups (0 represents only bcc)

def getGroupId(course_name):
    start = course_name.find('(')
    if (start == -1): return 0
    end = course_name.find(')')
    group = course_name[start+1:end]
    if (group not in group_id.keys()):
        global group_count
        group_count += 1
        group_id[group] = group_count
    return group_id[group]

def getWorkload(file_name):
    with open(file_name) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        info = list()
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
                atom['professor'] = row[4].lower().replace('.', '')
                atom['semester'] = int(row[2][0])
                info.append(atom)
        return info

def printWorkload(info, semester):
    for atom in info:
        if (atom['semester'] != semester): continue
        print(f"course({atom['course']},{atom['group']},{atom['professor']}).")


info = getWorkload(file_name)
printWorkload(info, 1)
