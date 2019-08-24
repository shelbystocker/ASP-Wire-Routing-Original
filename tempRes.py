#!/usr/bin/python
import random
import sys
import os
import json


os.chdir("/Users/Shelby/Research/wire/experiments/recent/exp11")
numWires = int(4)

for i in range(10, 20, 1):
    board_size = i

    csv_file = 'temp1.csv'
    for j in range(0, 30, 1):
        file_to_open = str(i) + "-" + str(j) + "-result1"
        with open(file_to_open) as f:
            data = json.load(f)
        time = data["Time"]["Total"]
        satisfiable = data["Result"]
        if satisfiable == "SATISFIABLE":
            sat = 1
        elif satisfiable == "UNKNOWN":
            sat = 2
            with open(csv_file, 'a') as p:
                csv_row = f'{i}, {j}, {time}, {sat}\n'
                p.write(csv_row)
                p.close()
        else:
            sat = 0

    csv_file = 'temp2.csv'
    for j in range(0, 30, 1):
        file_to_open = str(i) + "-" + str(j) + "-result2"
        with open(file_to_open) as f:
            data = json.load(f)
        time = data["Time"]["Total"]
        satisfiable = data["Result"]
        if satisfiable == "SATISFIABLE":
            sat = 1
        elif satisfiable == "UNKNOWN":
            sat = 2
            with open(csv_file, 'a') as p:
                csv_row = f'{i}, {j}, {time}, {sat}\n'
                p.write(csv_row)
                p.close()
        else:
            sat = 0



