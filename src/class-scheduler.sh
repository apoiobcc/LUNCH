#!/bin/bash

# This script runs the class scheduler using all available constraints and
# returns a nicely formatted output for the user.

BASE_DIR=$(dirname $0)
CONSTRAINTS_DIR="${BASE_DIR}/constraints"
OUTPUT_PARSER=$(find "$BASE_DIR" -name "clingo_output_parser.py")

BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp")
INPUT="$BASE_DIR/input.lp"

# Print usage
usage() {
	cat <<EOF
USAGE:
    class-scheduler [OPTIONS]         Run the class scheduler POC

OPTIONS:
    -h | --help: print this help message
    -n | --num-models <number>: number of models to be generated, defaults to 1
EOF
}

# Parse CLI args
num_models=1

while [[ $# -gt 0 ]]; do
	case "$1" in
	-h | --help)
		usage
		exit 0
		;;
	-n | --num-models)
		num_models="$2"
		shift
		shift
		;;
	-* | --*)
		echo "WARN: unknown option $1"
		shift
		;;
	*)
		echo default
		exit 1
		;;
	esac
done

# Runs the clingo interpreter
clingo $num_models \
	$BASIC_CONSTRAINTS \
	$HARD_CONSTRAINTS \
	$INPUT | python3 $OUTPUT_PARSER
