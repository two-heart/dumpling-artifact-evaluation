#!/usr/bin/fish

mkdir /data/1/
mkdir /data/2/
mkdir /data/3/
mkdir /data/4/
mkdir /data/5/

swift run -c release FuzzilliCli --dumpling-depth=0 --dumpling-prop-count=0 --storagePath=/data/1/0-0 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=0 --dumpling-prop-count=0 --storagePath=/data/2/0-0 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=0 --dumpling-prop-count=0 --storagePath=/data/3/0-0 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=0 --dumpling-prop-count=0 --storagePath=/data/4/0-0 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=0 --dumpling-prop-count=0 --storagePath=/data/5/0-0 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=5 --storagePath=/data/1/3-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=10 --storagePath=/data/1/3-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=50 --storagePath=/data/1/3-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=5 --storagePath=/data/1/5-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=10 --storagePath=/data/1/5-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=50 --storagePath=/data/1/5-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=5 --storagePath=/data/1/10-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=10 --storagePath=/data/1/10-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=50 --storagePath=/data/1/10-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

wait

swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=5 --storagePath=/data/2/3-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=10 --storagePath=/data/2/3-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=50 --storagePath=/data/2/3-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=5 --storagePath=/data/2/5-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=10 --storagePath=/data/2/5-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=50 --storagePath=/data/2/5-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=5 --storagePath=/data/2/10-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=10 --storagePath=/data/2/10-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=50 --storagePath=/data/2/10-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

wait

swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=5 --storagePath=/data/3/3-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=10 --storagePath=/data/3/3-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=50 --storagePath=/data/3/3-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=5 --storagePath=/data/3/5-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=10 --storagePath=/data/3/5-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=50 --storagePath=/data/3/5-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=5 --storagePath=/data/3/10-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=10 --storagePath=/data/3/10-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=50 --storagePath=/data/3/10-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

wait

swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=5 --storagePath=/data/4/3-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=10 --storagePath=/data/4/3-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=50 --storagePath=/data/4/3-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=5 --storagePath=/data/4/5-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=10 --storagePath=/data/4/5-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=50 --storagePath=/data/4/5-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=5 --storagePath=/data/4/10-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=10 --storagePath=/data/4/10-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=50 --storagePath=/data/4/10-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

wait

swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=5 --storagePath=/data/5/3-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=10 --storagePath=/data/5/3-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=3 --dumpling-prop-count=50 --storagePath=/data/5/3-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=5 --storagePath=/data/5/5-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=10 --storagePath=/data/5/5-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=5 --dumpling-prop-count=50 --storagePath=/data/5/5-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=5 --storagePath=/data/5/10-5 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=10 --storagePath=/data/5/10-10 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&
swift run -c release FuzzilliCli --dumpling-depth=10 --dumpling-prop-count=50 --storagePath=/data/5/10-50 --profile=v8 --jobs=1 --exportStatistics ~/localTools/v8/out/fuzzbuild/d8&

wait

python3 eval_hyperparameters.py
