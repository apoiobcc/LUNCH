'''
Sat Answers Comparator
----------------------
This program receives two files and one operation (equal or contains). One file is the clingo output and the other the expected output.
If the operation is "equal", the program compares both and decides if they are completely equal.
If the operation is "contains", the program compares both and decides if the expected answer is contained in the clingo answer.
Input: clingo output and the expected output
Output: True or false

Expected file format:
	$ cat soft/5/sat_exp.txt
	class(mac111,45,profAAA,211) class(mac111,45,profAAA,311) class(mac222,45,profBBB,211) class(mac333,45,profCCC,411)

	class(mac111,45,profAAA,311) class(mac111,45,profAAA,411) class(mac222,45,profBBB,211) class(mac333,45,profCCC,411)  
	$

Running Example:
$ python sat-answers-comparator.py --expected hc1_expected_input_sat.txt --clingo clingo_output_hc1.txt --operation equal
To run the tests
$ python3 sat-answers-comparator.py --test

'''

import sys
import unittest
import argparse

def parse_clingo_input(raw):
    '''
    Separate each answer (from clingo) and returns a list with all classes scheduled
    If no answer is found, returns False
    Args:
    	raw: input directly from clingo output
    '''
    
    parsed = raw.split("Answer: ")
    parsed.pop(0)
    # no answers
    if(not parsed): return False

    answers_list = list()
    for p in parsed:
        answer = p.split("\n")
        answers_list.append(answer[1].split(" "))
    return answers_list

def equal_answers(clingo,expected):
	'''
		Return true if answers are equal
		Args:
			clingo: clingo list of answers
			expected: expected list of answers
	'''
	clingo_set = create_set(clingo)
	expected_set = create_set(expected)
	return clingo_set == expected_set

def contains(clingo,expected):
	'''
		Return true if the clingo answer contains the expected answer
		Args:
			clingo: clingo list of answers
			expected: expected list of answers
	'''
	clingo_set = create_set(clingo)
	if len(expected) == 0 and len(clingo) != 0: return False
	for i in expected:
		if set(i) not in clingo_set:
			return False
	return True

def create_set(answer):
	'''
		Create the set representation of an answer
		Args:
			answer: list of predicates
	'''
	answer_set = set()
	for i in range(0,len(answer)):
		answer_set.add(frozenset(set(answer[i])))
	return answer_set

def parse_expected_input(raw):
    '''
    Separate each answer (from expected output) and return a list with all classes scheduled
    If no answer is found, return False
    Args:
    	raw: input directly from expected answers file
    '''
    parsed = raw.split("\n\n")
    if (not parsed): return False

    answers_list = list()
    for p in parsed:
    	answer = p.replace("\n","").rstrip().split(" ")
    	if answer == [""]:
    		continue
    	answers_list.append(answer)
    return answers_list

class TestClassEqualOp(unittest.TestCase):
	'''
		Test class to test the equal operation
	'''	
	## Tests inputs
	out0 = [["class(A,11:00)","class(B,12:00)"]]
	exp0 = [["class(A,11:00)","class(B,12:00)"]]

	out1 = [["class(A,11:00)","class(B,12:00)"]]
	exp1 = [["class(B,12:00)","class(A,11:00)"]] 

	out2 = [["class(A,11:00)"],["class(B,12:00)"],["class(C,11:00)"]]
	exp2 = [["class(C,11:00)"],["class(B,12:00)"],["class(A,11:00)"]]

	out3 = [["class(A,11:00)","class(B,12:00)","class(C,13:00)"],["class(D,11:00)","class(E,12:00)"],["class(F,11:00)","class(G,13:00)"]]
	exp3 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(A,11:00)","class(C,13:00)"],["class(E,12:00)","class(D,11:00)"]] 

	exp4 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(ZZZZZZZ,11:00)","class(C,13:00)"],["class(E,12:00)","class(D,11:00)"]]

	exp5 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(A,11:00)","class(C,13:00)"],["class(E,12:00)","class(D,11:00)"],["class(A,11:00)"]]

	exp6 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(A,11:00)","class(C,13:00)"],["class(E,12:00)"]]

	exp7 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(A,11:00)","class(C,13:00)"]]

	
	def test_true_trivial_answers(self):
		self.assertTrue(equal_answers(self.out0,self.exp0),"Error in the trivial test")
	def test_true_different_predicates_order(self):
		self.assertTrue(equal_answers(self.out1,self.exp1),"Erro when changing predicates order")
	def test_true_different_answers_order(self):
		self.assertTrue(equal_answers(self.out2,self.exp2),"Error when changing answer order")
	def test_true_different_answers_predicates_order(self):
		self.assertTrue(equal_answers(self.out3,self.exp3),"Error when changing answers and predicates order")
	def test_false_different_predicate(self):
		self.assertFalse(equal_answers(self.out3,self.exp4),"Error when the predicate is different")
	def test_false_extra_answer(self):
		self.assertFalse(equal_answers(self.out3,self.exp5),"Error when the size of the answers sets doesn't match")
	def test_false_missing_predicate(self):
		self.assertFalse(equal_answers(self.out3,self.exp6),"Error when the size of the predicates set doesn't match")
	def test_false_missing_answer(self):
		self.assertFalse(equal_answers(self.out3,self.exp7),"Error when there is a missing answer")

class TestClassContainsOp(unittest.TestCase):
	'''
		Test class to test the contains operation
	'''	
	## Tests inputs
	out0 = [["class(A,11:00)","class(B,12:00)"]]
	exp0 = [["class(A,11:00)","class(B,12:00)"]]

	out1 = [["class(A,11:00)","class(B,12:00)"]]
	exp1 = [["class(B,12:00)","class(A,11:00)"]] 

	out2 = [["class(A,11:00)"],["class(B,12:00)"],["class(C,11:00)"]]
	exp2 = [["class(C,11:00)"]]

	out3 = [["class(A,11:00)","class(B,12:00)","class(C,13:00)"],["class(D,11:00)","class(E,12:00)"],["class(F,11:00)","class(G,13:00)"]]
	exp3 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(A,11:00)","class(C,13:00)"]] 

	exp4 = [["class(G,13:00)","class(F,11:00)"],["class(B,12:00)","class(ZZZZZZZ,11:00)","class(C,13:00)"],["class(E,12:00)","class(D,11:00)"]]

	exp5 = []

	exp6 = [["class(G,13:00)","class(F,11:00)"],["class(Z,12:00)"]]

	exp7 = [["class(G,13:00)","class(Z,11:00)"],["class(B,12:00)","class(Z,11:00)","class(C,13:00)"]]

	
	def test_true_trivial_answers(self):
		self.assertTrue(contains(self.out0,self.exp0),"Error in the trivial test (contains)")
	def test_true_different_predicates_order(self):
		self.assertTrue(contains(self.out1,self.exp1),"Erro when changing predicates order (contains)")
	def test_true_one_equal_answer(self):
		self.assertTrue(contains(self.out2,self.exp2),"Error when one answer is contained in the output")
	def test_true_two_equal_answers(self):
		self.assertTrue(contains(self.out3,self.exp3),"Error when two answers are contained in the output")
	def test_false_different_predicate(self):
		self.assertFalse(contains(self.out3,self.exp4),"Error when the predicate is different (contains)")
	def test_false_empty_set(self):
		self.assertFalse(contains(self.out3,self.exp5),"Error when the expected set is empty")
	def test_false_one_answer_wrong(self):
		self.assertFalse(contains(self.out3,self.exp6),"Error when one is not contained")
	def test_false_all_wrong(self):
		self.assertFalse(contains(self.out3,self.exp7),"Error when none is contained")

def print_usage():
	print("Usage: python sat-answers-comparator.py --expected {EXPECTED ANSWERS FILE} --clingo {CLINGO ANSWERS FILE} --operation {equal,contains} --test {to run the tests}")
	sys.exit(2)

class MyParser():
    '''
    	Arguments parser
    '''
    def __init__(self):
        if len(sys.argv) == 1:
            self.error()
        parser = argparse.ArgumentParser()
        parser.add_argument('--expected',help='expected answer file')
        parser.add_argument('--clingo',help='clingo answer file')
        parser.add_argument('--operation',help='operations possible: equals,contains')
        parser.add_argument('--test',action='store_true',default=False,help='run the tests')
        self.args = ''
        try:
            self.args = parser.parse_args()
        except:
            self.error()

    def args(self):
        return self.args
    def error(self):
        print_usage()
        sys.exit(2)

def unittestTrigger():
	unittest.main()
	quit()

def main():
	p = MyParser()
	args = p.args
	CLINGO_FILE = args.clingo
	EXPECTED_FILE = args.expected
	OPERATION = args.operation
	TEST = args.test

	if TEST == True:
		sys.argv = [sys.argv[0]]
		unittest.main(__name__,exit=False)
		quit()

	if CLINGO_FILE == None or EXPECTED_FILE == None or OPERATION == None:
		print_usage()

	try:
		raw = open(CLINGO_FILE,"r").read()
	except:
		print("Error reading file \"",raw,"\"",sep='')
		quit()

	clingo_answers_list = parse_clingo_input(raw)

	if (not clingo_answers_list): 	
		print("UNSAT")
		return

	try:
		file = open(EXPECTED_FILE, "r")
	except:
		print("Error reading file \"",file,"\"",sep='')
		quit()

	expected_answers_list = parse_expected_input(file.read())

	if OPERATION == "equal":
		print(equal_answers(clingo_answers_list,expected_answers_list))
	elif OPERATION == "contains":
		c = contains(clingo_answers_list,expected_answers_list)
		print(c)
	else:
		print("OPERAÇÃO INVÁLIDA")

	return


if __name__ == "__main__":
	main()

