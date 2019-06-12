
import pandas as pd
import os
import matplotlib.pyplot as plt

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
