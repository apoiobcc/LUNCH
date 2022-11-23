"""
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

"""

from Clausule import clausule 
import csv
import sys


def parser(predicate, n_args, file_name):
    """
    Given the predicate name, number of arguments and file containing the information (csv),
    this function returns a long string containing all the clausules assembled
    """
    with open(file_name) as csv_file:
        headers = next(csv_file)
        csv_reader = csv.reader(csv_file, delimiter=",")
        clingo_input = ""
        for row in csv_reader:
            cl = clausule(predicate, row[:n_args])
            clingo_input += cl.assembleClausule() + "\n"
    return clingo_input[:-1]
	        
def main():	
    arqs = [
            {   'predicate' : "curriculum",
                'n_args' : 3,
                'file_name' : "csv_input/Disciplinas - Trilhas.csv",
            },
            {   'predicate' : "curriculum",
                'n_args' : 3,
                'file_name' : "csv_input/Disciplinas - (Pos-Grad) Blocos.csv",
            },
            {   'predicate' : "highDemand",
                'n_args' : 1,
                'file_name' : "csv_input/Disciplinas - (Pos-Grad)Alta Demanda.csv",
            },
            {   'predicate' : "double",
                'n_args' : 1,
                'file_name' : "csv_input/Disciplinas - Dupla.csv",
            },
            {   'predicate' : "elective",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Eletivas.csv",
            },
            {   'predicate' : "joint",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Joint.csv",
            },
            {   'predicate' : "obligatory",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Obrigatorias.csv",
            },
            {   'predicate' : "requiredElective",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - Optativas-Estat_Ciencia.csv",
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
            {   'predicate' : "scope",
                'n_args' : 2,
                'file_name' : "csv_input/Disciplinas - (Pos-Grad) Areas.csv",
            }]

    for arq in arqs:
        clingo_input = parser(arq["predicate"], arq["n_args"], arq["file_name"])
        with open(
            f"clingo_input_files/{arq['predicate']}.txt", "a"
        ) as clingo_input_file:
            clingo_input_file.write(clingo_input)


main()
