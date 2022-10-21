'''
Clingo Output Parser
----------------------
This program can parse the clingo output of the scheduling problem
Input: clingo output
Output: Print the schedule grid in the terminal and save each answer in a csv file

Running Example
$ python3 clingo-output-parser.py < clingo-output-sat.txt

Dependencies: tabulate

'''

import sys
import csv
from tabulate import tabulate

def parse_input(raw):
    '''
    Separate each answer and returns a list with all classes scheduled
    If no answer is found, returns False
    '''
    
    parsed = raw.split("Answer: ")
    parsed.pop(0)

    # no answers
    if(not parsed): return False

    answers_list = list()
    for p in parsed:
        answer = p.split("\n")
        answers_list.append(answer[1])
    return answers_list

def make_sched(answer):
    '''
    Given a answer (list of classes in the schedule)
    Returns a dictionary where the keys are a tuple (day,time) and
    the value is a list of tuples (course, group, professor) of classes that 
    are scheduled in that time
    '''
    
    # classes schedule
    sched = dict()
    classes = answer.split("class(")
    for clas in classes[1:]:
        end = clas.find(")")
        clas = clas[:end]
        c = clas.split(",")
        course = c[0]
        group = c[1]
        professor = c[2]
        day = int(c[3][0])
        time = int(c[3][1:])

        # group classes by period
        if ((day,time) not in sched):
            sched[day,time] = list()
        sched[day, time].append((course, group, professor))

    return sched

def time_stamp(p):
    '''
    Converts time code to a real time for printing
    '''
    if(p == 11): return "08:00-09:40"
    if(p == 12): return "10:00-11:40"
    if(p == 21): return "14:00-15:40"
    if(p == 22): return "16:00-17:40"

def make_table(sched):
    '''
    Given a dictionary of the schedule,
    Returns a tuple head, body.
    Head are the columns name and body is a list of the rows in the table
    The elements of the table are only the courses
    '''
    head = ['Horário', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta']
    body = list()
    for time in [11, 12, 21, 22]: # time row
        row = list()
        row.append(time_stamp(time))
        for day in range(1,6):
            if ((day, time) not in sched): row.append("")
            else:
                classes = ""
                for c in sched[day, time]:
                    classes = classes + c[0] + "-" + c[1] + "\n"
                row.append(classes)
        body.append(row)
    return head,body

def make_csv_file(file_name, head, body):
    with open(file_name, mode='w') as output_file:
        output_writer = csv.writer(output_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        output_writer.writerow(head)
        for b in body:
            output_writer.writerow(b)
            
def print_table(name, head, body):
    print(name)
    print(tabulate(body, head,tablefmt="simple_grid"))
           
def main():
    raw = sys.stdin.read()
    answers_list = parse_input(raw)
    if (not answers_list): 
        print("UNSAT")
        return
    i = 1
    for a in answers_list:
        sched = make_sched(a)
        head,body = make_table(sched)
        # make_csv_file(f'clingo-output{i}.csv',head, body)
        print_table(f"Answer {i}", head,body)
        i += 1

main()
