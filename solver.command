#!/bin/bash

for((j=10;j<200;j+=10)); do
	for i in {0..29}; do
		python randomPuzzle.py $j > $j-$i;
		echo '[' > $j-$i-results.txt;		
		(gringo $j-$i wire1.lp | clasp --time-limit=60 --outf=2) >> $j-$i-results.txt;
		echo $',\n{\n"Blocks":' >> $j-$i-results.txt;
		echo "$j" >> $j-$i-results.txt;
		echo $'\n} \n]' >> $j-$i-results.txt; 
	done;
done;
