#!/usr/bin/fish
for i in (seq $EXP_NUM_RUNS); swift run -c release FuzzilliCli --jobs=$NUM_JOBS --storagePath=/data/Dumpling-$i --profile=v8 ~/localTools/v8/out/fuzzbuild/d8 --maxRuntimeInHours=$EXP_RUN_HOURS --exportStatistics; end
python3 eval_cov.py
