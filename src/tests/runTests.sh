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
#
# Tests for hard and soft constraints should be placed in the "hard" and "soft"
# directories, respectively. The naming convention for the test files is as
# follows:
#
# - "unsat.lp" -> UNSAT test
# - "sat.lp" -> SAT test
# - "sat_exp.txt" -> SAT test expected output
#
# If more than one tests exists for a same constraint, append a number to the
# filename. Example: "unsat1.lp", "sat1.lp" and "sat_exp1.txt".

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
	constraint_num=$(echo "$hc_file" | grep -o '[0-9]\+')
	test_dir="$HC_TEST_DIR/$constraint_num"

	echo "Testing HC$constraint_num:"

	#  Run all SAT tests
	sat_tests=$(find "$test_dir" -regex '[^u]*sat[0-9]*\.lp')

	if [[ -z "$sat_tests" ]]; then
		echo "  [WARN] no SAT test found"
	fi

	for sat_test in $sat_tests; do
		test_filename=$(basename "$sat_test")
		sat_test_num=$(echo "$test_filename" | grep -o '[0-9]\+')
		expected_output="${test_dir}/sat_exp${sat_test_num}.txt"
		if ! [[ -f "$expected_output" ]]; then
			echo "  [WARN] no expected output file for SAT test ${sat_test_num}"
			continue
		fi

		# NOTE: cannot detect when file is missing if one test is labeled sat.lp
		# and other test is labeled sat1.lp
		clingo 0 "$BASIC_CONSTRAINTS" "$hc_file" "$sat_test" 2>/dev/null |
			python3 "$SAT_VERIFICATION_PROG" "$expected_output" |
			grep -q "True" &&
			echo "  $test_filename [OK]" ||
			echo "  $test_filename [FAIL]"
	done

	#  Run all UNSAT tests
	unsat_tests=$(find "$test_dir" -regex '.*unsat[0-9]*\.lp')

	if [[ -z "$unsat_tests" ]]; then
		echo "  [WARN] no UNSAT test found"
	fi

	for unsat_test in $unsat_tests; do
		test_filename=$(basename "$unsat_test")
		clingo 0 "$BASIC_CONSTRAINTS" "$hc_file" "$unsat_test" 2>/dev/null |
			grep -q "UNSATISFIABLE" &&
			echo "  $test_filename [OK]" ||
			echo "  $test_filename [FAIL]"
	done
done
