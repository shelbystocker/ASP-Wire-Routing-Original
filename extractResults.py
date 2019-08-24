#!/usr/bin/python
import random
import sys
import os
import json


os.chdir("/Users/Shelby/Research/wire/experiments/recent/exp10")
numWires = int(3)

for i in range(0, 50, 1):
    board_size = i

    time_total = 0
    sat_total = 0
    for j in range(0, 30, 1):
        file_to_open = str(i) + "-" + str(j) + "-result2"
        with open(file_to_open) as f:
            data = json.load(f)
        time = data["Time"]["Total"]
        satisfiable = data["Result"]
        if satisfiable == "SATISFIABLE":
            sat = 1
        else:
            sat = 0
        time_total += time
        sat_total += sat
    time_avg = time_total / 30
    sat_avg = sat_total / 30
    csv_file = 'data2.csv'
    with open(csv_file, 'a') as p:
        csv_row = f'{i}, {time_avg}, {sat_avg}\n'
        p.write(csv_row)
        p.close()



