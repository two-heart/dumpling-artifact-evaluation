import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from glob import glob
import json
import pathlib
import datetime


"""
Json format
```json
{
     "totalSamples": "49556908",
     "validSamples": "30950490",
     "interestingSamples": "14596",
     "timedOutSamples": "3048150",
     "crashingSamples": "62",
     "totalExecs": "65792733",
     "avgProgramSize": 23.942666666666675,
     "avgCorpusProgramSize": 15.259,
     "execsPerSecond": 280.0025133225189,
     "fuzzerOverhead": 0.03056732209471079,
     "numWorkers": "29",
     "coverage": 0.14376711086363195,
     "correctnessRate": 0.5105000000000001,
     "timeoutRate": 0.039000000000000014
```
}
"""
eval_folders = glob('/data/*-?/stats/*.json')


def to_unix_timestamp(path: str) -> int:
    """
    Given a path of the format 'yyyyMMddHHmmss.json'
    return the unix timestamp
    """
    yyyy = int(path[:4])
    MM = int(path[4:6])
    dd = int(path[6:8])
    HH = int(path[8:10])
    mm = int(path[10:12])
    # sometimes it saves it like a second or two later
    # ss = 0 # int(path[12:14])
    ss = int(path[12:14])
    date_time = datetime.datetime(yyyy, MM, dd, HH, mm, ss)
    return int(date_time.timestamp())


def parse_stats() -> pd.DataFrame:
    """
    Parse the stats folders containing the json files the multiple runs of the
    multiple fuzzers in a pandas Dataframe of the format:
    | fuzzer: str | run: int | runtime: int | totalSamples: int | ...
    """
    dataframe = pd.DataFrame()
    last_stats_file = None
    for stats_file in sorted(eval_folders):
        path = pathlib.Path(stats_file)
        fuzzer, run = path.parts[2].split('-', 1)
        run = int(run)
        runtime = to_unix_timestamp(path.stem)
        json_data = json.loads(path.read_text())
        last_runtime = None
        if last_runtime is not None:
            if last_runtime > runtime:
                print('runtime', path)
        last_runtime = runtime
        if last_stats_file is not None:
            if 'coverage' not in json_data:
                continue
        last_stats_file = json_data
        dataframe = dataframe._append({
            "Fuzzer": fuzzer,
            "run": run,
            "runtime": runtime,
            "coverage": json_data['coverage'],
            "path": path.stem
        }, ignore_index=True)
    return dataframe


def zero_based_runtime(df: pd.DataFrame):
    """
    Given a dataframe with a column 'runtime' containing unix timestamps
    return a new dataframe with the 'runtime' column zero-based for each run
    """
    for run in df['run'].unique():
        for fuzzer in df['Fuzzer'].unique():
            mask = (df['Fuzzer'] == fuzzer) & (df['run'] == run)
            df.loc[mask, 'runtime'] -= df.loc[mask, 'runtime'].min()


def cut_of_runtime(df: pd.DataFrame):
    """
    Given a dataframe with a column 'runtime' containing unix timestamps
    return a new dataframe with all rows removed where runtime is later than
    three days
    """
    # sometimes the runtime report is like two seconds late
    df['runtime'] = df['runtime'].apply(lambda x: round(x/60) * 60)
    df.drop(df[df.runtime > 24 * 3 * 60 * 60].index, inplace=True)


def fill_missing_rows(df: pd.DataFrame):
    """
    If a run does not have a row at a runtime, create it with the
    most recent coverage value of this run
    """
    for fuzzer in df['Fuzzer'].unique():
        for runtime in df['runtime'].unique():
            for run in df['run'].unique():
                # if a fuzzer doesn't have this run => continue
                if not run in df[df['Fuzzer'] == fuzzer]['run'].unique():
                    continue
                # if this fuzzer run does not have row at this runtime create
                # it and use the most recent runtime
                mask = (df['Fuzzer'] == fuzzer) & (df['run'] == run) & (df['runtime'] == runtime)
                if not mask.any():
                    most_recent_cov = df[(df['Fuzzer'] == fuzzer) & (df['run'] == run) & (df['runtime'] < runtime)]['coverage'].max()
                    df = df._append({
                        'Fuzzer': fuzzer,
                        'run': run,
                        'runtime': runtime,
                        'coverage': most_recent_cov
                        }, ignore_index=True)
    return df


def plot_coverage(df: pd.DataFrame):
    """
    Given a dataframe with a column 'coverage' containing floats
    and a column 'runtime' containing unix timestamps
    return a seaborn plot of the coverage over time the runtime shown in hours
    and the coverage in percent

    """
    df = df.copy()
    df['runtime'] = df['runtime'] / 60 / 60
    # round every runtime to multiple of 60
    df['coverage'] *= 100
    sns.set_style("whitegrid", {"grid.color": ".8", "grid.linestyle": ":"})
    # set colorblind color palette
    sns.set_palette("colorblind")
    plot = sns.lineplot(data=df.to_dict(),
                        x='runtime',
                        y='coverage',
                        # style='run',
                        hue='Fuzzer',
                        )
    plt.ylim(0)
    plot.set_xlabel("Runtime (hours)")
    plot.set_ylabel("Coverage (%)")
    ax = plt.gca()
    handles, labels = ax.get_legend_handles_labels()
    ax.legend(handles=handles, labels=labels)
    return plot

def print_end_coverages(df: pd.DataFrame):
    """
    Print the end coverages of the fuzzers.
    Average and standard over the runs
    """
    for fuzzer in df['Fuzzer'].unique():
        mask = df['Fuzzer'] == fuzzer
        end_coverage = df[mask].groupby('run').last()['coverage'].mean()
        end_coverage_std = df[mask].groupby('run').last()['coverage'].std()
        print(fuzzer, end_coverage, end_coverage_std)

if __name__ == '__main__':
    stats = parse_stats()
    zero_based_runtime(stats)
    cut_of_runtime(stats)
    print_end_coverages(stats)
    stats.sort_values(by=['Fuzzer', 'run', 'runtime'], inplace=True)
    stats = fill_missing_rows(stats)
    plot = plot_coverage(stats)
    plot.get_figure().savefig('/data/coverage.pdf', dpi=500)
    # show the plot
    # plt.show()
