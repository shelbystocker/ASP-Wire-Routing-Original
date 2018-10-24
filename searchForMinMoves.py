#!/usr/bin/python
import random
import sys
import subprocess
import json

numMoves = 20;
lastNumChecked = numMoves;
currentNumChecked = numMoves;
minFound = False;
numBlocks = sys.argv[1];
numBoard = sys.argv[2];

while not minFound:
        print(numMoves);
        subprocess.call(["./solver.command", "%s" %numMoves, "%s" %numBlocks, "%s" %numBoard]);
        filename = "%s-%s-result.txt" %(numBlocks,numBoard);
        with open(filename) as f:
                data = json.load(f)
        print(data["Result"]);
        if data["Result"] == "SATISFIABLE":
                if currentNumChecked-lastNumChecked==1:
                        minFound=True
                else:
                        numMoves/=2;
                        lastNumChecked = currentNumChecked;
                        currentNumChecked = numMoves;
        else:
                numMoves*=2-(.5*numMoves);
                lastNumChecked = currentNumChecked;
                currentNumChecked = numMoves;
