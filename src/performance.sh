#!/bin/bash

# Script that runs class-schedulcer in parallel mode with different time limits
# and store the result of each execution in a csv. The script also run a few commands
# to get basic hardware info.

usage() {
    cat <<EOF
USAGE:
    performance.sh -o <output-file>  [OPTIONS]

    -o <path>: output csv file

To run:
    performance.sh needs to be inside class-scheduler/src
    $ docker compose run --rm dev
    $ ./performance -o output.csv
EOF
}

WORKLOAD_PATH="./perf_measure/our_workload/"
SCHEDULE_PATH="./perf_measure/"


years=(2019 2020 2021 2022 2023)
semesters=(1 2)
times=(15 30 60 120 240 480 960 1920 3840)
modo="nosso"

OUTPUT_FILE=""
HARDWARE_INFO="$(lscpu | grep 'Model name:\|CPU MHz:\|CPU(s):' | uniq ; cat /proc/meminfo | grep MemTotal)"

CPU_CORES="$(grep -c ^processor /proc/cpuinfo)"

echo "Running with $CPU_CORES cores..."

while [[ $# -gt 0 ]]; do
    case "$1" in
    -h | --help)
        usage
        exit 0
        ;;
    -o | --output)
        OUTPUT_FILE="$2"
        shift
        shift
        ;;
    -*)
        echo "unknown option '$1'."
        shift
        ;;
    *)
        exit 1
        ;;
    esac
done

if [ -z "$OUTPUT_FILE" ]; then
    echo "missing output file"
    usage
    exit 1
fi

csv_out=$'Year,Time,Priority 1,Priority 0,Priority -1,Sum\n'

for semester in ${semesters[@]}; do
    for y in ${years[@]}; do
        for t in ${times[@]}; do

        	csv_line="$y"'_'"$semester""_""$modo"','"$t"','
        	
            resultado=$(./class-scheduler.sh -w "$WORKLOAD_PATH""/workload_"$y"_"$semester".csv" -s "$SCHEDULE_PATH""/schedule_"$y"_"$semester".csv" -t $t -c $CPU_CORES 2>/dev/null)
        	otimizacao=$(echo "$resultado" | grep -Pzo 'Optimization:(.*\n)' | tr -d '\0' )

        	valores=($otimizacao)
        	soma=0
        	for v in ${valores[@]:1}; do
        		csv_line="$csv_line""$v",
        		soma=$((soma+$v))
        	done
        	csv_line="$csv_line""$soma"$'\n'

        	csv_out="$csv_out""$csv_line"
        done
        echo "Finished measures for $y $semester"
    done
done
csv_out="$csv_out"$'Hardware\n'"\"$HARDWARE_INFO\""

echo "$csv_out" > $OUTPUT_FILE

