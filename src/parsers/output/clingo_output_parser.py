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

from clingo_output_support import *

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
