#!/bin/bash

# This script runs the class scheduler using all available constraints and
# returns a nicely formatted output for the user.

BASE_DIR=$(dirname $0)
CONSTRAINTS_DIR="${BASE_DIR}/constraints"
OUTPUT_PARSER=$(find "$BASE_DIR" -name "clingo-output-parser.py")

BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
MINIMIZE_SC="$CONSTRAINTS_DIR/minimize_sc.lp"
PYTHON_OPS="$CONSTRAINTS_DIR/python_utils.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp")
SOFT_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "sc*[0-9].lp")
INPUT="$BASE_DIR/input.lp"

clingo 0 \
	$MINIMIZE_SC \
	$PYTHON_OPS \
	$BASIC_CONSTRAINTS \
	$HARD_CONSTRAINTS \
	$SOFT_CONSTRAINTS \
	$INPUT # | python3 $OUTPUT_PARSER
