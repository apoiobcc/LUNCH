'''
Clingo Input Courses Parser (Fixed)
----------------------
This program can parse a given csv files containing fixed information about the courses.
Input: csv table containing the course information of a certain predicate (fill up the dictionary).
Output: clingo input files in the clingo_input_files directory. 
The names of each file will be the predicate name.
If the file already exists, it will append the new information.

Running:

Complete the arqs dictionary with your tables information where:
- 'predicate' is the name of the predicate of the generated clausule
- 'n_args' is the number of arguments (or columns) that will be used to fill the clausule
- 'file_name' is the path to the file that will be used

Create a directory named clingo_input_files

$ python3 parser-input-courses.py

'''

import sys
import csv

def parser(predicate, n_args, file_name):
    '''
        Given the predicate name, number of arguments and file containing the information (csv),
        this function returns a long string containing all the clausules assembled
    '''
    with open(file_name) as csv_file:
        headers = next(csv_file)
        csv_reader = csv.reader(csv_file, delimiter=',')
        clingo_input = ""
        for row in csv_reader:
            atom = predicate + "("
            for i in range(n_args-1):
                atom += row[i].lower() + ","
            atom += row[n_args-1].lower() + ")."
            clingo_input += atom + "\n"
    return clingo_input
	        
def main():	
    arqs = [
            {   'predicate' : "curriculum",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Trilhas.csv",
            },
            {   'predicate' : "obligatory",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Obrigatorias.csv",
            },
            {   'predicate' : "num_classes",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Graduacao.csv",
            },
            {   'predicate' : "num_classes",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Pos-Graduacao.csv",
            },
            {   'predicate' : "postgrad",
                'n_args' : 1,
                'file_name' : "csv_input/Disciplinas - Pos-Graduacao.csv",
            },
            {   'predicate' : "curriculum",
                'n_args' : 3,
                'file_name' : "csv_input/Disciplinas - (Pos-Grad) Trilhas.csv",
            }]

    for arq in arqs:
        clingo_input = parser(arq['predicate'], arq['n_args'], arq['file_name'])
        with open(f"clingo_input_files/{arq['predicate']}.txt", 'a') as clingo_input_file:
            clingo_input_file.write(clingo_input)

main()
