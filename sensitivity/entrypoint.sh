#!/usr/bin/fish
swift run -c release FuzzilliCli --jobs=1 --storagePath=/data/fuzzout --profile=v8 ~/localTools/v8/out/fuzzbuild/d8 --exportStatistics
python3 eval_sensitivity.py
