'''
Search predicates
----------------------
This program receives 2 main inputs: clingo answer output and predicates to be searched.
The clingo input can come from a file or from stdin.
The output is a list of answers that contain all the searched predicates.

Input: clingo from file or stdin and file with searched predicates
Output:

Searched predicates file format:
	$ cat searched_predicates.txt
	class(a,b,c) class(a,d,c) teacher(e)

Running Examples:
$ python3 search-predicates.py --clingo clingo_out.txt --search search_file.txt --visual --verbose
$ cat clingo_out.txt | python3 search-predicates.py --search search_file.txt
$ clingo a.lp b.lp c.lp | python3 search-predicates.py --search seach_file.txt --visual

To run the tests
$ python3 search-predicates.py --test

'''

import sys
import unittest
import argparse
import fileinput

# Output parser import
sys.path.append('../parsers/output')
from clingo_output_support import *

def parse_clingo_input(raw):
	'''
		Function that receives answers from clingo return the
		parsed structure that represents this answers.
		The structure is a list of dicts. Each dict represents one clingo answer:
			[
				{
				 "Number":(answer number),
				 "Answer":(list of predicates),
				 "Optimization":(optimization number)
				},
			]
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
		opt = ""
		if answer[2][0:14] == "Optimization: ":
			opt = answer[2][14:] 
		answers_list.append({"Number":answer[0],"Answer":answer[1].split(" "),"Optimization":opt})
	return answers_list

def parse_to_clingo(answers):
	'''
		Function that does the oposite operation of parse_clingo_input.
		Receives the answer structure and returns the answers
		miming clingo.
		Args:
			answers: list of dict structure that represents the answers
	'''
	fake_clingo = "..\n"
	for i in answers:
		fake_clingo+="Answer: " + i["Number"] +"\n" + " ".join(i["Answer"]) + "\n" + "Optimization: " + i["Optimization"]
	return fake_clingo

def is_subset(predicates,answer):
	'''
		Function that returns true if
		predicates are a subset of answer.
		Args:
			predicates: predicates list to be searched
			answer: clingo answers list
	'''
	return set(predicates).issubset(set(answer))

def search(from_clingo,to_search):
	'''
		Function that returns the clingo answers that contain the searched predicates.
		Args:
			from_clingo: answer list from clingo
			to_search: predicates list to be searched
	'''
	if len(from_clingo) == 0 or len(to_search) == 0: return []
	answers_found = []
	for answer in from_clingo:
		if is_subset(to_search,answer["Answer"]):
			answers_found.append(answer)
	return answers_found

def parse_search_input(raw):
	'''
		Function that receives the search predicates and transform them
		into a list.
		Search structure (spaced predicates):
			predicate_to_search1(a,b) predicate_to_search2(c,d)
		Args:
			raw: input from searched predicates file
	'''
	parsed = raw.replace("\n","").rstrip().split(" ")
	return parsed

def color(string):
	'''
		Function that colorizes a string into light blue
		Args:
			string: any python string
	'''
	colored = "\033[96m"+string+"\033[00m"
	return colored

def join_predicates(search_predicates,answer_predicates):
	'''
		Function that converts the predicates from the answer list
		into a string, changing colors if the predicate is searched.
		Args:
			search_predicates: searched predicates list
			answer_predicates: clingo answer predicates list
	'''
	answer_colored = ""
	for i in answer_predicates:
		if i in search_predicates:
			answer_colored += color(i) + " "
		else:
			answer_colored += i + " "
	return answer_colored

def visualize_answer(raw):
	'''
		Function that prints the table
		representing the schedule
		(uses clingo_output_support module)
		Args:
			raw: clingo raw output
	'''
	answers_list = parse_input(raw)
	i = 0
	for a in answers_list:
		sched = make_sched(a)
		head, body = make_table(sched)
		print_table(f"", head, body)
		i += 1

def manage_stdin_input(search_predicates,VERBOSE,VISUAL):
	'''
		Function that deals with input from.
		The function supports continuous stdin,
		processing each answer before the input is finished
		Args:
			search_predicates: search predicates list
			VERBOSE: bool to print predicates in the output
			VISUAL: bool to print schedule table in the output
	'''

	# Variable to count answers. Must be global to be printed even with KeyboardInterrupt.
	global global_ans_qty
	global_ans_qty = 0	
	raw = ""
	first = True
	ans_quantity = 0
	for line in fileinput.input([]):
		raw+=line
		if "Answer: " in line:
			if first == True:
				first = False
				continue
			fake_raw = "...\n"+raw[0:-len(line)-1] 
			clingo_answers_list = parse_clingo_input(fake_raw)
			answers = search(clingo_answers_list,search_predicates)
			if len(answers) > 0:
				ans_quantity +=1
				# Global variable change
				global_ans_qty = ans_quantity
				print_answer(search_predicates,answers[0],fake_raw,VERBOSE,VISUAL)
			raw = line
	fake_raw = "...\n"+raw
	clingo_answers_list = parse_clingo_input(fake_raw)
	answers = search(clingo_answers_list,search_predicates)
	print_answers(search_predicates,answers,ans_quantity,fake_raw,VERBOSE,VISUAL)
	# Global variable change
	stdin_finished = True
	return

def print_answer(search_predicates,answer,raw,VERBOSE,VISUAL):
	'''
		Function that receives an answer dict and print its info
		Args:
			search_predicates: search predicates list
			answer: a clingo answer structure
			raw: clingo output representing the answer
			VERBOSE: bool to print predicates in the output
			VISUAL: bool to print schedule table in the output
	'''
	if VERBOSE == False and VISUAL == False:
		return
	print("Answer:",answer["Number"])
	if VERBOSE:
		answer_colored = join_predicates(search_predicates,answer["Answer"])
		print(answer_colored[:-1])
	if VISUAL:
		visualize_answer(raw)
	print("Optimization:",answer["Optimization"])
	print("-------------------------")
	return


def print_answers(search_predicates,answers,ans_quantity,raw,VERBOSE,VISUAL):
	'''
		Function that receives the set of answers to be printed and mangage
		their prints along with the quantity of answers found.
		Args:
			search_predicates: search predicates list
			answers: list of clingo answer structure
			ans_quantity: current answer count
			raw: clingo output representing the answer
			VERBOSE: bool to print predicates in the output
			VISUAL: bool to print schedule table in the output			
	'''
	for answer in answers:
		ans_quantity +=1
		print_answer(search_predicates,answer,raw,VERBOSE,VISUAL)
	if ans_quantity == 0:
		print("No answer was found")
	elif ans_quantity == 1:
		print(ans_quantity,"answer was found")
	else:
		print(ans_quantity,"answers were found")

def print_usage():
	'''
		Usage print
	'''
	print("Usage: python sat-answers-comparator.py --search {SEARCH FILE} --clingo {CLINGO ANSWERS FILE} --test {to run the tests}")
	sys.exit(2)


class MyParser():
    '''
    	Arguments parser
    '''
    def __init__(self):
        if len(sys.argv) == 1:
            self.error()
        parser = argparse.ArgumentParser()
        parser.add_argument('--search',help='search predicates file')
        parser.add_argument('--clingo',help='clingo answer file')
        parser.add_argument('--verbose',action='store_true',default=False,help='show each answer that has been found')
        parser.add_argument('--stdin',action='store_true',default=False,help='input clingo from stdin')
        parser.add_argument('--visual',action='store_true',default=False,help='show a table for each answer')
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
	#  Both variables must be global to support answers quantity print even with KeyboardInterrupt.
	global is_stdin 
	global stdin_finished 
	is_stdin = False
	stdin_finished = False

	p = MyParser()
	args = p.args
	CLINGO_FILE = args.clingo
	SEARCH_FILE = args.search
	VERBOSE = args.verbose
	STDIN = args.stdin
	TEST = args.test
	VISUAL = args.visual
	# Global variable change
	is_stdin = STDIN

	# Arguments managing
	if TEST == True:
		sys.argv = [sys.argv[0]]
		unittest.main(__name__,exit=False)
		quit()

	if CLINGO_FILE != None and STDIN:
		print_usage()

	if (CLINGO_FILE == None and STDIN == False) or SEARCH_FILE == None:
		print_usage()

	# Input read
	try:
		file = open(SEARCH_FILE, "r")
	except:
		print("Error reading file \"",file,"\"",sep='')
		quit()

	search_predicates = parse_search_input(file.read())

	if STDIN == False:
		try:
			raw = open(CLINGO_FILE,"r").read()
		except:
			print("Error reading file \"",raw,"\"",sep='')
			quit()
	else:
		# From stdin manager
		manage_stdin_input(search_predicates,VERBOSE,VISUAL)
		return

	# From file manager
	clingo_answers_list = parse_clingo_input(raw)
	if (not clingo_answers_list): 	
		print("UNSAT or empty")
		return
	answers = search(clingo_answers_list,search_predicates)
	print_answers(search_predicates,answers,0,parse_to_clingo(answers),VERBOSE,VISUAL)
	return


class TestClassSearch(unittest.TestCase):
	'''
		Test class to test the search
	'''	
	## Tests inputs
	out = [{"Number":0,"Answer":[],"Optimization":0}] 
	exp = [{"Number":0,"Answer":[],"Optimization":0}]

	out1 = out.copy()
	exp1 = exp.copy()
	out1[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]
	sea1 = ["class(A,11:00)","class(B,12:00)"]
	exp1[0]["Answer"] = out1[0]["Answer"]

	out2 = out.copy()
	exp2 = exp.copy()
	out2[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]
	sea2 = ["class(A,11:00)"]
	exp2[0]["Answer"] = out2[0]["Answer"]

	out3 = out.copy()
	out3[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]
	sea3 = ["class(E,11:00)"]

	out4 = out.copy()
	exp4 = exp.copy()
	out4[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]
	out4.append({"Number":0,"Answer":["class(A,11:00)","class(C,13:00)"],"Optimization":0})
	sea4 = ["class(B,12:00)"]
	exp4[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]

	out5 = out4.copy()
	exp5 = exp.copy()
	sea5 = ["class(A,11:00)"]
	exp5[0]["Answer"] = ["class(A,11:00)","class(B,12:00)"]
	exp5.append({"Number":0,"Answer":["class(A,11:00)","class(C,13:00)"],"Optimization":0})

	def test_empty_search(self):
		self.assertEqual(search(self.out,[]),[],"Error in the empty test")

	def test_trivial_answers(self):
		self.assertEqual(search(self.out1,self.sea1),self.exp1,"Error in the trivial test")

	def test_simple_search_found(self):
		self.assertEqual(search(self.out2,self.sea2),self.exp2,"Error in the simple search found test")

	def test_simple_search_fail(self):
		self.assertEqual(search(self.out3,self.sea3),[],"Error in the simple search fail test")

	def test_advanced_search_found_1(self):
		self.assertEqual(search(self.out4,self.sea4),self.exp4,"Error in the advanced search found 1 test")

	def test_advanced_search_found_2(self):
		self.assertEqual(search(self.out5,self.sea5),self.exp5,"Error in the advanced search found 2 test")


if __name__ == "__main__":
	'''
		Since the program supports continuous input from stdin
		it must allow user to KeyboardInterrupt without any problems
		and still be able to print answer count results.
	'''
	try:
		main()
	except KeyboardInterrupt:
		if is_stdin and stdin_finished == False:
			print("---------------------")
			try: global_ans_qty 
			except :
				print("No answer was found")
				quit()
			if global_ans_qty == 0:
				print("No answer was found")
			elif global_ans_qty == 1:
				print(global_ans_qty,"answer was found")
			else:
				print(global_ans_qty,"answers were found")


