#!/bin/bash

BASE_DIR=$(dirname $0)
CONSTRAINTS_DIR="${BASE_DIR}/constraints"
OUTPUT_PARSER=$(find "$BASE_DIR" -name "clingo-output-parser.py")

BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp")
INPUT="$BASE_DIR/input.lp"

python3 -m clingo 1 \
	$BASIC_CONSTRAINTS \
	$HARD_CONSTRAINTS \
	$INPUT | python3 $OUTPUT_PARSER
