#!/bin/bash

# This script runs SAT and UNSAT tests for all the constraints.

hc_quantity=8

ABS_PATH=$(dirname "$0")
CONSTRAINTS_DIR="$ABS_PATH/../constraints"

sat_answers_comparator_path="$ABS_PATH/sat-answers-comparator.py"

for number in $(seq 1 $hc_quantity)
do

	# Files paths used in the execution

	hc_file="$CONSTRAINTS_DIR/hc$number.lp"

	basic_hc_file="$CONSTRAINTS_DIR/basic_constraints.lp"

	input_sat_file="$ABS_PATH/hc${number}_input_sat.lp"
	input_unsat_file="$ABS_PATH/hc${number}_input_unsat.lp"

	sat_exp_file="$ABS_PATH/hc${number}_sat_exp.txt"

	output_unsat_file="/tmp/hc${number}_out_unsat.txt"
	output_sat_file="/tmp/clingo_hc${number}_out_sat.txt"

	# Test if all files needed exist

	if ! [ -f $hc_file -a -f $input_unsat_file -a -f  $input_sat_file -a -f  $sat_exp_file ]; then
	    echo "Hard constraint $number does not have all files needed... Aborting its tests"
	    continue
	fi

	# UNSAT tests

	clingo $basic_hc_file $hc_file $input_unsat_file 0 > $output_unsat_file  2>/dev/null

	if ! grep -q "UNSATISFIABLE" $output_unsat_file; then
		echo "Error UNSAT constraint $number"
	fi

	rm $output_unsat_file

	# SAT tests

	clingo $basic_hc_file $hc_file $input_sat_file 0 > $output_sat_file  2>/dev/null

	answer=$(python $sat_answers_comparator_path $sat_exp_file < $output_sat_file)

	if [ $answer != "True" ]; then
		echo "Error SAT constraint $number"
	fi

	rm $output_sat_file

	echo "Tests completed for hc$number"

done

echo "Done"