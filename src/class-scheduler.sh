#!/bin/bash

# This script runs the class scheduler using all available constraints and
# returns a nicely formatted output for the user.

BASE_DIR=$(dirname "$0")
CONSTRAINTS_DIR="${BASE_DIR}/constraints"
INPUTS_DIR="${BASE_DIR}/input"
OUTPUT_PARSER=$(find "$BASE_DIR" -name "clingo_output_parser.py")

BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
MINIMIZE_SC="$CONSTRAINTS_DIR/minimize_sc.lp"
PYTHON_OPS="$CONSTRAINTS_DIR/python_utils.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp")
SOFT_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "sc*[0-9].lp")
SC_METRICS="$CONSTRAINTS_DIR/sc_metrics.lp"
WEIGHT_CONFIG="$BASE_DIR/weight_config.lp"
INPUT=$(find "$INPUTS_DIR" -name "*.lp")

CLINGO_FLAGS=("--quiet=1" "--opt-mode=optN" "--time-limit=120")

# Output type option values
OUTPUT_TABLE=0
OUTPUT_CSV=1
OUTPUT_BOTH=2

# Colors
COLOR_RED="\e[31m"
COLOR_YELLOW="\e[33m"
COLOR_CLEAR="\e[0m"

# Print program's usage
usage() {
    cat <<EOF
USAGE:
    class-scheduler [OPTIONS]         Run the class scheduler POC

OPTIONS:
    -h | --help: print this help message
    -n | --num-models <number>: number of models to be generated, defaults to 1
    -o | --output-type <table|csv|both>: output style for the generated schedules
EOF
}

# Pretty print errors
# Args:
#   $1 -> error message
err() {
    echo -e "${COLOR_RED}ERR: $1${COLOR_CLEAR}"
}

# Pretty print warnings
# Args:
#   $1 -> warning message
warn() {
    echo -e "${COLOR_YELLOW}WARN: $1${COLOR_CLEAR}"
}

# Parse CLI args
num_models=1
output_type=$OUTPUT_TABLE

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
    -o | --output-type)
        case "$2" in
        csv) output_type=$OUTPUT_CSV ;;
        table) output_type=$OUTPUT_TABLE ;;
        both) output_type=$OUTPUT_BOTH ;;
        *)
            err "bad option for flag --output-type (-o). Expected one of 'csv', 'table' or 'both'"
            exit 1
            ;;
        esac
        shift
        shift
        ;;
    -*)
        warn "unknown option '$1'."
        shift
        ;;
    *)
        echo default
        exit 1
        ;;
    esac
done

# Runs the clingo interpreter
clingo "${CLINGO_FLAGS[@]}" "$num_models" \
    "$MINIMIZE_SC" \
    "$PYTHON_OPS" \
    "$WEIGHT_CONFIG" \
    "$BASIC_CONSTRAINTS" \
    $HARD_CONSTRAINTS \
    $SOFT_CONSTRAINTS \
    $SC_METRICS \
    $INPUT | python3 "$OUTPUT_PARSER" "$output_type"
