import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from hashlib import sha256
import random
import numpy as np

num_colors = 15

def shuffle_colors(colors):
    for i in range(len(colors) - 1, 0, -1):
        j = random.randint(0, i)
        colors[i], colors[j] = colors[j], colors[i]

random.seed(0)
colors = list(range(num_colors))

# # Shuffle the colors
# shuffle_colors(colors)


def shuffle(i: int) -> int:
    return colors[i]


def hash_series(series: pd.DataFrame) -> pd.DataFrame:
    # hash every execHash with sha256 as int
    series['execHash'] = series['execHash'].apply(lambda x: int(sha256(str(x).encode()).hexdigest(), 16))
    return series


def apply_rainbow(series: pd.DataFrame) -> pd.DataFrame:
    series['color'] = series.execHash % num_colors
    # series['color'] = series['color'].apply(shuffle)
    series['color'] = series['color'].astype(str)
    return series


def index(series: pd.DataFrame) -> pd.DataFrame:
    series['input no.'] = series.index
    return series


def draw_scatterplot(series: pd.DataFrame, fuzzer_name: str) -> None:
    _colors = [str(i) for i in range(0, num_colors)]
    print(_colors)
    fg = sns.FacetGrid(data=series, hue='color', hue_order=_colors, aspect=1.61)
    fg.map(plt.scatter, 'input no.', 'execHash', s=.7)
    ax = fg.ax
    # set y axis title
    ax.set_ylabel('Observed State Hash')
    ax.set_xlabel('Bug Oracle Invocation')
    ax.set_title(fuzzer_name)


def compute_entropy(series: pd.DataFrame) -> float:
    # compute entropy of the series
    return series['execHash'].value_counts(normalize=True).apply(lambda x: -x * np.log2(x)).sum()


def plot(file_path: str, fuzzer_name: str) -> None:
    # load execHashes as a pandas series
    series = pd.read_csv(file_path, header=None)
    series.columns = ['execHash']
    entory = compute_entropy(series)
    # name the one column as 'execHash'


    series = apply_rainbow(series)
    series = index(series)
    # hash sha256 every value in the series
    series = hash_series(series)

    # print max color value
    print(series['color'].max())
    fuzzer_name = fuzzer_name + ' – Entropy: ' + str(round(entory, 2))
    draw_scatterplot(series, fuzzer_name)
    output_path = '/data/sensitivity.pdf'
    plt.savefig(output_path)

plot('/data/fuzzout/execHashes10000.csv', 'Dumpling')
