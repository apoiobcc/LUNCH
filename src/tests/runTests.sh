#!/bin/bash

# This script runs SAT and UNSAT tests for all the constraints.

hc_quantity=8

for number in $(seq 1 $hc_quantity)
do

	hc_file="hc$number.lp"

	input_sat_file="hc$number\_input_sat.lp"
	input_unsat_file="hc$number\_input_unsat.lp"
	
	sat_exp_file="hc$number\_sat_exp.txt"

	output_unsat_file="/tmp/hc$number\_out_unsat.txt"
	output_sat_file="/tmp/clingo_hc$number_out_sat.txt"


	# Test if all files needed exist

	if ! [ -f $hc_file -a -f $input_unsat_file -a -f  $input_sat_file -a -f  $sat_exp_file ]; then
	    echo "Hard constraint $number does not have all files needed... Aborting its tests"
	    continue
	fi

	# UNSAT tests

	clingo basic_constraints.lp $hc_file $input_unsat_file 0 > $output_unsat_file  2>/dev/null

	if ! grep -q "UNSATISFIABLE" $output_unsat_file; then
		echo "Error UNSAT constraint $number"
	fi

	rm $output_unsat_file

	# SAT tests

	clingo basic_constraints.lp $hc_file $input_sat_file 0 > $output_sat_file  2>/dev/null

	answer=$(python sat-answers-comparator.py $sat_exp_file < $output_sat_file)

	if [ $answer != "True" ]; then
		echo "Error SAT constraint $number"
	fi

	rm $output_sat_file

	echo "Tests completed for hc$number"

done

echo "Done"