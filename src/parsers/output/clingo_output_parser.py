"""
Clingo Output Parser
----------------------
This program can parse the clingo output of the scheduling problem
Input: clingo output
Output: Print the schedule grid in the terminal and save each answer in a csv file

Running Example

Print table in terminal
$ python3 clingo-output-parser.py 0 < clingo-output-sat.txt

Export table to csv
$ python3 clingo-output-parser.py 1 < clingo-output-sat.txt

Print and export table
$ python3 clingo-output-parser.py 2 < clingo-output-sat.txt

Dependencies: tabulate

"""

import sys

from clingo_output_support import *


def main():
    arg = 0
    if len(sys.argv) > 1:
        arg = int(sys.argv[1])
    raw = sys.stdin.read()
    answers_list = parse_input(raw)
    if not answers_list:
        print("UNSAT")
        return
    i = 1
    for a in answers_list:
        sched = make_sched(a)
        head, body = make_table(sched)
        if arg % 2 == 0:
            print_table(f"Answer {i}", head, body)
        if arg > 0:
            make_csv_file(f"clingo-output{i}.csv", head, body)
        i += 1


main()
