#!/bin/bash

# This script runs SAT and UNSAT tests for all the constraints.

hc_quantity=8

for number in $(seq 1 $hc_quantity)
do

	# Test if all files needed exist

	if ! [ -f hc$number.lp -a -f hc$number\_input_unsat.lp -a -f hc$number\_input_sat.lp -a -f hc$number\_sat_exp.txt  ]; then
	    echo "Hard constraint $number does not have all files needed... Aborting its tests"
	    continue
	fi

	# UNSAT tests

	clingo basic_constraints.lp hc$number.lp hc$number\_input_unsat.lp > /tmp/hc$number\_out_unsat.txt 0 2>/dev/null

	if ! grep -q "UNSATISFIABLE" /tmp/hc$number\_out_unsat.txt; then
		echo "Error UNSAT constraint $number"
	fi

	rm /tmp/hc$number\_out_unsat.txt

	# SAT tests

	clingo basic_constraints.lp hc$number.lp hc$number\_input_sat.lp 0 > /tmp/clingo_hc$number_out_sat.txt 2>/dev/null

	answer=$(python sat-answers-comparator.py hc$number\_sat_exp.txt < /tmp/clingo_hc$number_out_sat.txt)

	if [ $answer != "True" ]; then
		echo "Error SAT constraint $number"
	fi

	rm /tmp/clingo_hc$number_out_sat.txt

	echo "Tests completed for hc$number"

done

echo "Done"