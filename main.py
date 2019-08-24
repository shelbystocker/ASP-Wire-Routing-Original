#!/usr/bin/python
import os

os.chdir("/Users/Shelby/Research/wire/experiments/recent/exp11")
# os.system("gringo theirEncoding.lp test18.lp | clasp --time-limit=300 --outf=2 > 18-0-result")

numWires = 4
for j in range(19, 20, 1):  # for each blocks
    for k in range(0, 30, 1):  # for each instance
        temp_board = str(j) + "-" + str(k)
        os.system("python3 randomPuzzly.py " + str(numWires) + " " + str(j) + " > " + temp_board)
        os.system("gringo wire1.lp " + temp_board + " | clasp --time-limit=1200 --outf=2 > " + temp_board + "-result1")
        os.system("gringo time.lp " + "../exp9/" + temp_board + " | clasp --time-limit=1200 --outf=2 > " + temp_board + "-result2")
