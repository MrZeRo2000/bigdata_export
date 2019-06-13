
import pandas as pd
import os
import matplotlib.pyplot as plt


def plot_parallel(size, num):
    script_dir = os.path.dirname(__file__)
    parallel_stats_file_name = os.path.join(script_dir, "../data", "stats_{}_{}.txt".format(size, num))
    parallel_result_pic_file_name = os.path.join(script_dir, "../data", "stats_{}_{}.png".format(size, num))
    df = pd.read_csv(parallel_stats_file_name, sep=",", parse_dates=True)

    plt.clf()
    plt.plot(df[["WORKERS"]], df[["TIME_IN_SECONDS"]])
    plt.xlabel("Number of workers")
    plt.ylabel("Elapsed time in seconds")
    plt.title("Parallel load stats of {} rows split into {} parts".format(size * num, num))

    plt.savefig(parallel_result_pic_file_name)

    plt.show()


def plot_single():
    script_dir = os.path.dirname(__file__)

    stats_file_name = os.path.join(script_dir, "../data", "stats.txt")
    result_pic_file_name = os.path.join(script_dir, "../data", "stats.png")
    df = pd.read_csv(stats_file_name, sep=",", parse_dates=True)

    plt.clf()
    plt.plot(df[["ROWS"]], df[["TIME_IN_SECONDS"]])
    plt.xlabel("Number of rows to load")
    plt.ylabel("Elapsed time in seconds")
    plt.title("Schema load stats")

    plt.savefig(result_pic_file_name)

    plt.show()


plot_single()
plot_parallel(100, 10)
plot_parallel(20, 100)
plot_parallel(10, 200)
