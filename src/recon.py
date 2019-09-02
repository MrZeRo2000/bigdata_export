
if __name__ == "__main__":
    import sys
    import os
    import logging
    import pandas as pd
    import re

    SERVER_LOG_PATH = "log_server"
    LOCAL_LOG_PATH = "log"
    LOGGER = logging.getLogger("Recon")
    LOGGER.setLevel(logging.DEBUG)
    LOGGER.addHandler(logging.StreamHandler())


    def get_full_path(path: str, file_name: str) -> str:
        return os.path.abspath(os.path.join(
            os.path.dirname(__file__),
            os.pardir + os.path.sep +
            path +
            os.path.sep +
            file_name)
        )


    LOGGER.info("Reconciliation")

    server_file_name_1 = get_full_path(SERVER_LOG_PATH, sys.argv[1])
    server_file_name_2 = get_full_path(SERVER_LOG_PATH, sys.argv[2])
#    local_file_name = get_full_path(LOCAL_LOG_PATH, sys.argv[3])
    local_file_names = [get_full_path(LOCAL_LOG_PATH, s) for s in sys.argv[3].split(",")]
    recon_file_name = get_full_path(SERVER_LOG_PATH, "recon_{}_{}".format(sys.argv[1], sys.argv[2]))

    df1 = pd.read_csv(server_file_name_1, sep=',')
    df2 = pd.read_csv(server_file_name_2, sep=',')

    df12 = df1.set_index('value').join(df2.set_index('value'), rsuffix='_2')[["number_of_rows", "number_of_rows_2"]]
    df12["rows"] = df12["number_of_rows_2"] - df12["number_of_rows"]

    lines = []

    for local_file_name in local_file_names:
        with open(local_file_name, mode='r') as f:
            lines.extend(f.readlines())

    lines = [f for local_file_name in local_file_names for f in open(local_file_name, mode='r')]

    local_names = [re.search(r"\'name\': \'(\S+)\'", line)[1]
                   for line in lines if re.search(r'rows:(\d+)', line) is not None]
    local_rows = [re.search(r'rows:(\d+)', line)[1]
                  for line in lines if re.search(r'rows:(\d+)', line) is not None]

    df3 = pd.DataFrame({'name': local_names, 'rows': local_rows})

    df123 = df12.join(df3.set_index('name'), how='inner', rsuffix='_transferred')
    df123.index.name = 'table_name'

    df123.to_csv(recon_file_name, sep=',', index=True)
