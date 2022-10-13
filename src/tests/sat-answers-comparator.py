'''
Sat Answers Comparator
----------------------
This program receives two files, one (from stdin) containing a clingo output and the other (from the argument) the expected output.
The program compares both and deciedes if they are equal, meaning the model is correct.
Input: clingo output and the expected output
Output: Pŕint true if both are equal and false if not

Running Example
$ python3 sat-answers-comparator.py hc1_expected_input_sat.txt < clingo_output_hc1.txt

To run the tests
$ python3 sat-answers-comparator.py tests

'''

import sys
import unittest

def parse_clingo_input(raw):
    '''
    Separate each answer (from clingo) and returns a list with all classes scheduled
    If no answer is found, returns False
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

def compare_answers(clingo,expected):
	'''
	Compare two set of answers. If the set is equal returns true
	If they are not equal, returns False
	'''
	clingo_set = set()
	expected_set = set()

	if len(clingo) != len(expected) or len(clingo) == 0:
		return False

	for i in range(0,len(clingo)):
		clingo_set.add(frozenset(set(clingo[i])))
		expected_set.add(frozenset(set(expected[i])))

	return clingo_set == expected_set

def parse_expected_input(raw):
    '''
    Separate each answer (from expected output) and returns a list with all classes scheduled
    If no answer is found, returns False
    '''
    parsed = raw.split("\n\n")
    if (not parsed): return False

    answers_list = list()
    for p in parsed:
    	answer = p.split(" ")
    	answers_list.append(answer)
    return answers_list


def main(args):
	FILE = args[1]

	raw = sys.stdin.read()
	clingo_answers_list = parse_clingo_input(raw)

	if (not clingo_answers_list): 	
		print("UNSAT")
		return

	try:
		file = open(FILE, "r")
	except:
		print("Error reading file \"",FILE,"\"",sep='')
		quit()

	expected_answers_list = parse_expected_input(file.read())

	print(compare_answers(clingo_answers_list,expected_answers_list))

	return


class TestClass(unittest.TestCase):
	
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
		self.assertTrue(compare_answers(self.out0,self.exp0),"Error in the trivial test")
	def test_true_different_predicates_order(self):
		self.assertTrue(compare_answers(self.out1,self.exp1),"Erro when changing predicates order")
	def test_true_different_answers_order(self):
		self.assertTrue(compare_answers(self.out2,self.exp2),"Error when changing answer order")
	def test_true_different_answers_predicates_order(self):
		self.assertTrue(compare_answers(self.out3,self.exp3),"Error when changing answers and predicates order")
	def test_false_different_predicate(self):
		self.assertFalse(compare_answers(self.out3,self.exp4),"Error when the predicate is different")
	def test_false_extra_answer(self):
		self.assertFalse(compare_answers(self.out3,self.exp5),"Error when the size of the answers sets doesn't match")
	def test_false_missing_predicate(self):
		self.assertFalse(compare_answers(self.out3,self.exp6),"Error when the size of the predicates set doesn't match")
	def test_false_missing_answer(self):
		self.assertFalse(compare_answers(self.out3,self.exp7),"Error when there is a missing answer")

if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Usage: python3 sat-answers-comparator.py {expected answers file} < {clingo output file}")
		print("To run the tests: python3 sat-answers-comparator.py test")
		quit()
	elif sys.argv[1] == "tests":
		sys.argv.pop()
		unittest.main()
	else:
		main(sys.argv)