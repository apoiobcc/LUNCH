#!/bin/bash

# This script runs the class scheduler using all available constraints and
# returns a nicely formatted output for the user.

set -eo pipefail

# Useful directories
BASE_DIR=$(dirname "$0")
CONSTRAINTS_DIR="${BASE_DIR}/constraints"
INPUTS_DIR="${BASE_DIR}/static-input"

# Parsers
OUTPUT_PARSER=$(find "$BASE_DIR" -name "clingo_output_parser.py")
INPUT_PARSER=$(find "$BASE_DIR" -name "parser-input-semestral.py")

# Clingo input
BASIC_CONSTRAINTS="$CONSTRAINTS_DIR/basic_constraints.lp"
HARD_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "hc*[0-9].lp")
SOFT_CONSTRAINTS=$(find "$CONSTRAINTS_DIR" -name "sc*[0-9].lp" | sort)
MINIMIZE_SC="$CONSTRAINTS_DIR/minimize_sc.lp"
PYTHON_OPS="$CONSTRAINTS_DIR/python_utils.lp"
SC_METRICS="$CONSTRAINTS_DIR/sc_metrics.lp"
WEIGHT_CONFIG="$BASE_DIR/weight_config.lp"
INPUT=$(find "$INPUTS_DIR" -name "*.lp")
SEMESTER_INPUT=$(mktemp "class-scheduler-semester-input-XXXXXXXX")

CLINGO_FLAGS=("--quiet=1" "--opt-mode=optN")

# Output type option values
OUTPUT_TABLE=0
OUTPUT_CSV=1
OUTPUT_BOTH=2

# Colors
COLOR_RED="\e[31m"
COLOR_YELLOW="\e[33m"
COLOR_CLEAR="\e[0m"

# Debug mode (0 = disabled, 1 = enabled)
DEBUG=0

# Print program's usage
usage() {
    cat <<EOF
USAGE:
    class-scheduler -w <workload-csv> -s <schedule-csv> [OPTIONS]

REQUIRED PARAMS:
    -s | --schedule-csv <path>: CSV with teacher's semestral schedule
    -w | --workload-csv <path>: CSV with current semester workload

OPTIONS:
    -h | --help: print this help message
    -d | --debug: enable debug mode
    -n | --num-models <number>: number of models to be generated, defaults to 1
    -o | --output-type <table|csv|both>: output style for the generated schedules
    -t | --time-limit <number>: limit execution time to <number> of seconds, defaults to 500
    -c | --num-cores <number>: number of cores to be used in parallel execution
EOF
}

# Checks if an input string is a number
# Args:
#   $1 -> input string
is_number() {
    [[ "$1" =~ ^[0-9]+$ ]]
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

# Callback function called before exiting the program
on_exit() {
    EXIT_CODE=$?
    if ! [ "$DEBUG" -eq 1 ]; then
        rm "$SEMESTER_INPUT" 2>/dev/null
    fi
    exit $EXIT_CODE
}

trap on_exit EXIT ERR

# Parse CLI args
num_models=1
time_limit=500
num_cores=1
output_type=$OUTPUT_TABLE
schedule_csv=""
workload_csv=""

while [[ $# -gt 0 ]]; do
    case "$1" in
    -h | --help)
        usage
        exit 0
        ;;
    -d | --debug)
        DEBUG=1
        shift
        ;;
    -n | --num-models)
        if is_number "$2"; then
            num_models="$2"
        else
            warn "bad value for flag --num-models (-n). Value is not a number."
        fi
        shift
        shift
        ;;
    -o | --output-type)
        case "$2" in
        csv) output_type=$OUTPUT_CSV ;;
        table) output_type=$OUTPUT_TABLE ;;
        both) output_type=$OUTPUT_BOTH ;;
        *) warn "bad value for flag --output-type (-o). Expected one of 'csv', 'table' or 'both'" ;;
        esac
        shift
        shift
        ;;
    -t | --time-limit)
        if is_number "$2"; then
            time_limit="$2"
        else
            warn "bad value for flag --time-limit (-t). Value is not a number."
        fi
        shift
        shift
        ;;
    -c | --num-cores)
        if is_number "$2";then
            num_cores="$2"
        else
            warn "bad value for flag --num-cores (-c). Value is not a number;"
        fi
        shift
        shift
        ;;
    -s | --schedule-csv)
        schedule_csv="$2"
        shift
        shift
        ;;
    -w | --workload-csv)
        workload_csv="$2"
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

# Asserts that both CSVs where received
if [ -z "$schedule_csv" ]; then
    err "missing CSV input with teacher's schedule."
    usage
    exit 1
fi

if [ -z "$workload_csv" ]; then
    err "missing CSV input with semester workload."
    usage
    exit 1
fi

# Parse semester input
python3 "$INPUT_PARSER" "$schedule_csv" "$workload_csv" stdout > "$SEMESTER_INPUT"

# Runs the clingo interpreter

clingo "${CLINGO_FLAGS[@]}" "$num_models" \
    --time-limit="$time_limit" \
    --parallel-mode="$num_cores" \
    "$MINIMIZE_SC" \
    "$PYTHON_OPS" \
    "$WEIGHT_CONFIG" \
    "$BASIC_CONSTRAINTS" \
    $HARD_CONSTRAINTS \
    $SOFT_CONSTRAINTS \
    $SC_METRICS \
    $INPUT \
    "$SEMESTER_INPUT" |
    python3 "$OUTPUT_PARSER" "$output_type"
    
    
    
    
    
    
    
