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

TEMP_RESULTS_FILE=$(mktemp "/tmp/class-scheduler-tests.XXXXXXX")
TERMINAL_WIDTH=$(tput cols)

COLOR_RED="\e[31m"
COLOR_GREEN="\e[32m"
COLOR_YELLOW="\e[33m"
COLOR_CLEAR="\e[0m"

# Repeat a string n times.
# Args:
#   $1 -> string to repeat
#   $2 -> number of times to repeat
print_repeat() {
    for _ in $(seq 1 "$2"); do echo -n "$1"; done
}

# Pretty print SAT test failure
# Args:
#   $1 -> constraint number
#   $2 -> test number
#   $3 -> expected output file
print_SAT_fail() {
    echo -e "${COLOR_RED}FAIL: HC$1 SAT test $2 ${COLOR_CLEAR}"
    echo "--- expected ---"
    cat "$3"
    echo "--- received ---"
    # Print received without ASP header and footer
    sed '1,3d' "$TEMP_RESULTS_FILE" | head -n -5
    echo
}

# Pretty print UNSAT test failure
# Args:
#   $1 -> constraint number
#   $2 -> test number
print_UNSAT_fail() {
    echo -e "${COLOR_RED}FAIL: HC$1 UNSAT test $2 ${COLOR_CLEAR}"
    echo "--- clingo output ---"
    cat "$TEMP_RESULTS_FILE"
    echo
}

# Pretty print warnings
# Args:
#   $1 -> warning message
warn() {
    echo -e "${COLOR_YELLOW}WARN: $1${COLOR_CLEAR}"
}

########################
##     START TESTS    ##
########################
HEADER_TEXT=" starting test session "
print_repeat "=" $(((TERMINAL_WIDTH - ${#HEADER_TEXT}) / 2))
echo -n "$HEADER_TEXT"
print_repeat "=" $(((TERMINAL_WIDTH - ${#HEADER_TEXT}) / 2))
echo

########################
##  HARD CONSTRAINTS  ##
########################
hc_num_tests=0
hc_num_failures=0
hc_num_warns=0

for hc_file in $HARD_CONSTRAINTS; do
    constraint_num=$(echo "$hc_file" | grep -o '[0-9]\+')
    test_dir="$HC_TEST_DIR/$constraint_num"

    #  Run all SAT tests
    sat_tests=$(find "$test_dir" -regex '[^u]*sat[0-9]*\.lp')

    if [[ -z "$sat_tests" ]]; then
        warn "no SAT test found for HC${constraint_num}."
    fi

    for sat_test in $sat_tests; do
        hc_num_tests=$((hc_num_tests + 1))
        test_filename=$(basename "$sat_test")
        sat_test_num=$(echo "$test_filename" | grep -o '[0-9]\+')
        expected_output="${test_dir}/sat_exp${sat_test_num}.txt"
        if ! [[ -f "$expected_output" ]]; then
            warn "no expected output file for SAT test of HC${constraint_num}."
            hc_num_warns=$((hc_num_warns + 1))
            continue
        fi

        # BUG: cannot detect when file is missing if one test is labeled sat.lp
        # and other test is labeled sat1.lp
        clingo 0 "$BASIC_CONSTRAINTS" "$hc_file" "$sat_test" >"$TEMP_RESULTS_FILE" 2>/dev/null

        python3 "$SAT_VERIFICATION_PROG" --expected "$expected_output" --clingo "$TEMP_RESULTS_FILE" --operation equal |
            grep -v "True" &&
            hc_num_failures=$((hc_num_failures + 1)) &&
            print_SAT_fail "$constraint_num" "$sat_test_num" "$expected_output"
    done

    #  Run all UNSAT tests
    unsat_tests=$(find "$test_dir" -regex '.*unsat[0-9]*\.lp')

    if [[ -z "$unsat_tests" ]]; then
        warn "no UNSAT test found for HC${constraint_num}."
    fi

    for unsat_test in $unsat_tests; do
        hc_num_tests=$((hc_num_tests + 1))
        test_filename=$(basename "$unsat_test")
        clingo 0 "$BASIC_CONSTRAINTS" "$hc_file" "$unsat_test" 2>/dev/null |
            grep -q '^SATISFIABLE$' &&
            hc_num_failures=$((hc_num_failures + 1)) &&
            print_UNSAT_fail "$constraint_num" "$sat_test_num"
    done
done

########################
##    TESTS RESULTS   ##
########################
if [[ $hc_num_failures -eq 0 ]]; then
    STATUS="${COLOR_GREEN}ok${COLOR_CLEAR}"
else
    STATUS="${COLOR_RED}fail${COLOR_CLEAR}"
fi

printf "test result: %b. %d total; %d passed; %d failed; %d malformed.\n" \
    "$STATUS" $hc_num_tests $((hc_num_tests - hc_num_failures - hc_num_warns)) $hc_num_failures $hc_num_warns

########################
##      END TESTS     ##
########################
FOOTER_TEXT=" ending test session "
print_repeat "=" $(((TERMINAL_WIDTH - ${#FOOTER_TEXT}) / 2))
echo -n "$FOOTER_TEXT"
print_repeat "=" $(((TERMINAL_WIDTH - ${#FOOTER_TEXT}) / 2))
echo
