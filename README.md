# ASP-Wire-Routing

The wire routing problem is of a 20 x 20 grid that starts with 3 wires. The starting postions and goal positions
are randomly generated. Some of the squares on the grid can be blocked, meaning a wire can not be on that spot. I have
been running experiments where the number of blocks increases by 5 and running 30 instances for each number of blocks.
The file wire1.lp solves each board and outputs the moves that need to be made to get wires to their goal positions. 
Wires cannot cross. The file randomPuzzle.py generates the wires, goals, and blocks. The file solver.command is a bash script
that calls the generator (randomPuzzle.py) and the solver (wire1.lp). The outer for loop of solver.command is the number
of blocks and the inner for loop is the number of instances. 
