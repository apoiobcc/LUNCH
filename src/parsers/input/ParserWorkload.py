'''
Clingo Input Workload Parser (Semestral)
----------------------
This object can parse a given csv files containing the semester workload.

Columns expected in the csv file: 
Cours code|Group|Teacher Username|Should Be Scheduled (1-Yes, 0-No)|Time Scheduled (Should Be Scheduled = 0)

Clasules generated:
- course/3(course id, group id, teacher id)
For the courses that should be scheduled
- :- not class/4(course id, group id, teacher, period)
For the courses with fixed time
'''

import csv
from InputParser import InputParser

class ParserWorkload(InputParser):
    def getGroup(self, course):
        if course[3] != '0': return "BCC-pos"
        return "BCC"


    def parse(self):
        with open(self.csv_file) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            info = dict()
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
                    group = row[2] if row[2] else self.getGroup(course)
                    teacher = self.getUsername(row[7])
                    fixed_time = row[5]
                    if (fixed_time == ''):
                        notFixed.append([course, group, teacher])
                    else:
                        for time in fixed_time.split('e'):
                            time = time.strip().split(' ')
                            day = self.timecoder.getDayCode(time[0])
                            if day != 0:
                                period = self.timecoder.getPeriodCode(time[1].split('-')[0])
                                for p in period:
                                    fixed.append([course, group, teacher, day+p])
            info['course'] = notFixed
            info[':- not class'] = fixed
            return info

p = ParserWorkload("test_input_file/test_workload.csv")
info = p.parse()
t = p.assemble(info)
for i in t.keys():
    print(i)
    print(t[i])
    print()