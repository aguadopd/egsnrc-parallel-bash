# Bash egs parallel - Running EGSnrc codes on multiple cores without a queuing system.
# https://plus.google.com/+FredericTessierPlus/posts/hRS9Rjztsy3

#!/bin/bash

#####################################################################################
#
#  usage:
#
#  egs-parallel <n> <command>
#  n: number of jobs
#  command: EGSnrc command you want to run in parallel
#
#####################################################################################

# parse command-line arguments for number of jobs and command to run
n=$1
shift
command="$@"

# launch EGSnrc jobs in parallel, in the background
echo
echo "egs-parallel ($n jobs): $command"
echo --------------------------------------------------------------------------------

for j in `seq $n`; do
    $command -b -P $n -j $j >/dev/null 2>&1 &
    processid=`printf %5d $!`
    echo "LAUNCHED $processid: $command -b -P $n -j $j &"
    sleep 10
done

# wait for completion and report
wait
echo --------------------------------------------------------------------------------
echo "SIMULATION COMPLETED ($command)"
echo
