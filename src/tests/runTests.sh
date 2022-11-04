#!/bin/bash

# This script runs SAT and UNSAT tests for all the constraints.
#
# UNSAT tests are defined by instanciating a small set of predicates that lead
# to a unsatisfatible model when considering the tested constraint. This
# means that the model should be satisfatible without the tested constraint and
# unsatisfatible otherwise.
#
# On the other hand, SAT tests are defined by a set of predicates and the
# expected set of answers. The test suit runs the predicates with the tested
# constraint and checks if the given output matches the expected output. The
# expected output file should contain ALL of the expected resulting predicates
# and is agnostic to ordering of the answers. The comparison between expected
# and resulting output is done by the script `sat-answers-comparator.py`

BASE_DIR=$(dirname "$0")
CONSTRAINTS_DIR="$BASE_DIR/../constraints"
HC_TEST_DIR="$BASE_DIR/hard/"

SAT_VERIFICATION_PROG="$BASE_DIR/sat-answers-comparator.py"

BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp" | sort)

########################
##  HARD CONSTRAINTS  ##
########################
for hc_file in $HARD_CONSTRAINTS; do
	# Files paths used in the execution
	constraint_num=$(echo "$hc_file" | grep -o '[0-9]\+')
	test_dir="$HC_TEST_DIR/$constraint_num"

	echo "Testing HC$constraint_num:"

	# TODO: Run all SAT tests

	#  Run all UNSAT tests
	unsat_tests=$(find "$test_dir" -regex '.*unsat[0-9]*\.lp')

	if [[ -z "$unsat_tests" ]]; then
		echo "  [WARN] no UNSAT test found"
	fi

	for unsat_test in $unsat_tests; do
		test_filename=$(basename "$unsat_test")
		clingo "$BASIC_CONSTRAINTS" "$hc_file" "$unsat_test" 2>/dev/null |
			grep -q "UNSATISFIABLE" &&
			echo "  $test_filename [OK]" ||
			echo "  $test_filename [FAIL]"
	done

	# input_sat_file="$ABS_PATH/hc${number}_input_sat.lp"
	# input_unsat_file="$ABS_PATH/hc${number}_input_unsat.lp"
	#
	# sat_exp_file="$ABS_PATH/hc${number}_sat_exp.txt"
	#
	# output_unsat_file="/tmp/hc${number}_out_unsat.txt"
	# output_sat_file="/tmp/clingo_hc${number}_out_sat.txt"
	#
	# # Test if all files needed exist
	#
	# if ! [ -f $hc_file -a -f $input_unsat_file -a -f $input_sat_file -a -f $sat_exp_file ]; then
	# 	echo "Hard constraint $number does not have all files needed... Aborting its tests"
	# 	continue
	# fi
	#
	# # UNSAT tests
	#
	# clingo $basic_hc_file $hc_file $input_unsat_file 0 >$output_unsat_file 2>/dev/null
	#
	# if ! grep -q "UNSATISFIABLE" $output_unsat_file; then
	# 	echo "Error UNSAT constraint $number"
	# fi
	#
	# rm $output_unsat_file
	#
	# # SAT tests
	#
	# clingo $basic_hc_file $hc_file $input_sat_file 0 >$output_sat_file 2>/dev/null
	#
	# answer=$(python $sat_answers_comparator_path $sat_exp_file <$output_sat_file)
	#
	# if [ $answer != "True" ]; then
	# 	echo "Error SAT constraint $number"
	# fi
	#
	# rm $output_sat_file
	#
	# echo "Tests completed for hc$number"
	#
done

# echo "Done"
