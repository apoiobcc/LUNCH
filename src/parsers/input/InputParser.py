"""
    Abstract Class for Input Parser
    ---------------------------------
    The Input Parser classes are used to transform .csv files
    into clingo input .txt files
"""

from abc import ABC, abstractmethod
from Clausule import Clausule
from Timecode import Timecode

class InputParser(ABC):
    def __init__(self, file):
        self.csv_file = file
        self.timecoder = Timecode()

    def getUsername(self, email):
        return email.split('@')[0].strip()
    
    @abstractmethod
    def parse(self):
        """
            Using the csv file received during init
            Return a dictionary where:
            - keys are the desireable clingo predicates
            - values are a list of lists containing the arguments

        """
        pass

    def assemble(self, info):
        """
            Receives the dictionary from parse function
            Returns a dictionary where:
            - keys are the desireable clingo predicates
            - values are a full string containing all clingo clausules
        """
        clausules = dict()
        for k in info.keys():
            text = ""
            for args in info[k]:
                text = text + Clausule(k, args).assembleClausule() + '\n'
            clausules[k] = text[:-1]
        return clausules

    