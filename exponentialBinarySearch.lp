#!/usr/bin/python
import random
import sys
import subprocess
import json
import time

start_time = time.time()
numMoves = 1
lastNumChecked = numMoves
lowerBound = numMoves
upperBound = numMoves
currentNumChecked = numMoves
minFound = False
numBlocks = sys.argv[1]
boardInstance = sys.argv[2]
startSearch = False

while not minFound and numMoves<65:
        groundFile = open("%s-%s-groundOpt" %(numBlocks,boardInstance), "w")
        resultFile = open("%s-%s-resultOpt.txt" %(numBlocks,boardInstance), "w");
        a = subprocess.Popen(('gringo', '../%s-%s' %(numBlocks,boardInstance), 'opt.lp', '-c f=%d' %numMoves), stdout=groundFile)
        a.wait()
        g = open("%s-%s-groundOpt" %(numBlocks,boardInstance))
        p = subprocess.Popen(('clasp', '-s', '--outf=2', '--configuration=handy', '--time-limit=200'), stdin=g, stdout=resultFile)
        p.wait()
        r = '%s-%s-resultOpt.txt' %(numBlocks,boardInstance)
        with open(r) as f:
                data = json.load(f)
        print(data["Result"])
        if data["Result"] == "OPTIMUM FOUND" and startSearch == True:
                if numMoves-lastNumChecked == 1 or numMoves-lowerBound == 1:
                        minFound = True
                        b = open("%s-boundOpt.txt" %numBlocks, "a+")
                        #tFile = open("%s-timesOpt.txt" %numBlocks, "a+")
                        t = time.time() - start_time
                        b.write("%s %s up \n" %(numMoves,boardInstance))
                        tFile.write("%s\n" %t)
                        b.close()
                        tFile.close()
                numMoves = (numMoves-lowerBound)/2+lowerBound
                upperBound = currentNumChecked
                lastNumChecked = currentNumChecked
                currentNumChecked = numMoves
        elif data["Result"] == "UNSATISFIABLE" and startSearch == True:
                if(upperBound-lowerBound == 2):
                        minFound = True
                        b = open("%s-boundOpt.txt" %numBlocks, "a+")
                        #tFile = open("%s-timesOpt.txt" %numBlocks, "a+")
                        #t = time.time() - start_time
                        #tFile.write("%s\n" %t)
                        numMoves+=1
                        b.write("%s %s down \n" %(numMoves,boardInstance))
                        b.close()
                        #tFile.close()

                        # reground with correct bound
                        a = subprocess.Popen(('gringo', '../%s-%s' %(numBlocks,boardInstance), 'opt.lp', '-c f=%d' %numMoves), stdout=groundFile)
                        a.wait()
                        g = open("%s-%s-groundOpt" %(numBlocks,boardInstance))
                        resultFile = open("%s-%s-resultOpt.txt" %(numBlocks,boardInstance), "w");

                        # export to json
                        data1 = {
                                'time': t,
                                'groundT': '45',
                                'sat': '1',
                                'groundF': '55'
                        }
                        with open('data-%s-%s' %(numBlocks,boardInstance), 'w') as outfile:
                                json.dump(data1,outfile)
                else:
                        numMoves = (upperBound-numMoves)/2+numMoves
                        lowerBound = currentNumChecked
                        lastNumChecked = currentNumChecked
                        currentNumChecked = numMoves
        if data["Result"] == "OPTIMUM FOUND" and startSearch == False:
                numMoves = (numMoves-lastNumChecked)/2+lastNumChecked
                startSearch = True
                lowerBound = lastNumChecked
                upperBound = currentNumChecked
                lastNumChecked = currentNumChecked
                currentNumChecked = numMoves
        elif data["Result"] == "UNSATISFIABLE" and startSearch == False:
                numMoves*=2
                lastNumChecked = currentNumChecked
                currentNumChecked = numMoves
        if data["Result"] != "OPTIMUM FOUND" and data["Result"] != "UNSATISFIABLE":
                minFound = True
                data1 = {
                                'time': 'TIME OUT',
                                'groundT': '45',
                                'sat': '0',
                                'groundF': '55'
                        }
                        with open('data-%s-%s' %(numBlocks,boardInstance), 'w') as outfile:
                                json.dump(data1,outfile)

                tFile = open("%s-timesOpt.txt" %numBlocks, "a+")
                tFile.write("TIME OUT%s\n" %boardInstance)
                tFile.close()
#print("--- %s seconds ---" % (time.time() - start_time))
~                                                              
