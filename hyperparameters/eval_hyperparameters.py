import glob
import json
from scipy.stats import entropy
import statistics


def get_folder_name(depth, props, run):
    return f"/data/{run}/{depth}-{props}"

def parse_stats(depth, props, run):
    files = glob.glob(f"{get_folder_name(depth, props, run)}/stats/*.json")
    stats = []
    for f in files:
        jd = json.loads(open(f, "r").read())
        stats.append((int(jd["totalExecs"]), float(jd["execsPerSecond"]), float(jd["avgDumpSizeUnOpt"]), float(jd["avgDumpSizeOpt"])))

    return sorted(stats, key=lambda a: a[0])

def get_mean_stdev(l):
    return statistics.mean(l), statistics.stdev(l)

def get_entropy(depth, props, run):
    d = [int(a) for a in open(f"{get_folder_name(depth, props, run)}/execHashes10000.csv", "r")]
    return entropy(d)

def parse_run(depth, props):
    execs_per_second = []
    unopt_dump_sizes = []
    opt_dump_sizes = []
    entropies = []

    for i in range(1, 6):
        try:
            entropy = get_entropy(depth, props, i)
            stats = parse_stats(depth, props, i)
        except:
            continue

        execs_per_second += [a[1] for a in stats]
        unopt_dump_sizes += [a[2] for a in stats]
        opt_dump_sizes += [a[3] for a in stats]
        entropies.append(entropy)

    exec_mean, exec_std = get_mean_stdev(execs_per_second)
    unopt_dump_mean, unopt_dump_std = get_mean_stdev(unopt_dump_sizes)
    opt_dump_mean, opt_dump_std = get_mean_stdev(opt_dump_sizes)
    entropy_mean, entropy_std = get_mean_stdev(entropies)

    return round(entropy_mean, 3), round(exec_mean, 1), round(exec_std, 1), int(round(unopt_dump_mean, 0)), int(round(unopt_dump_std, 0)), int(round(opt_dump_mean, 0)), int(round(opt_dump_std, 0))


def generate_latex_table(params):
    def num(x):
        if x >= 1000:
            return "\\num{" + str(x) + "}"
        else:
            return str(x)

    table = "\\begin{table}[htbp]\n"
    table += "\\centering\n"
    table += "\\begin{tabular}{c c c c c c c c c}\n"
    table += "\\toprule\n"
    table += "\\bf{depth $\\times$} & \\bf{Entropy} & \\bf{Execs/s} & \\bf{Dump Size (opt)} & \\bf{Dump Size (unopt)} \\\\\n"
    table += "\\bf{\\#properties} & & & \\bf{(Bytes)} & \\bf{(Bytes)}\\\\\n"
    table += "\\midrule\n"

    for p in params:
        depth, props = p
        params_str = f"{p[0]} & {p[1]}"
        entropy, execs_mean, execs_std, opt_dump_mean, opt_size_std, unopt_dump_mean, unopt_dump_std = parse_run(depth, props)

        execs_str = f"{num(execs_mean)} $\\pm$ {num(execs_std)}"
        opt_dump_str = f"{num(opt_dump_mean)} $\\pm$ {num(opt_size_std)}"
        unopt_dump_str = f"{num(unopt_dump_mean)} $\\pm$ {num(unopt_dump_std)}"

        table += f"\t{params_str} & {entropy} & {execs_str} & {opt_dump_str} & {unopt_dump_str} \\\\\n"

    table += "\\bottomrule\n"
    table += "\\end{tabular}\n"
    table += "\\caption{TODO}\n"
    table += "\\label{tab:hyperparam_eval}\n"
    table += "\\end{table}\n"

    return table

params = [(0, 0)]
for i in [3, 5, 10]:
    for j in [5, 10, 50]:
        params.append((i, j))

open("/data/hyperparam_eval.tex", "w").write(generate_latex_table(params))
