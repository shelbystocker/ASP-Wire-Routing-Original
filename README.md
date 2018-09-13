# ASP-Wire-Routing-Original
My original solution to the wire routing problem. 

The wire routing problem is of a 20 x 20 grid that starts with 3 wires. The starting postions and goal positions
are randomly generated. Some of the squares on the grid can be blocked, meaning a wire can not be on that spot. I have
been running experiments where the number of blocks increases by 5 and running 30 instances for each number of blocks.
The file wire1.lp solves each board and outputs the moves that need to be made to get wires to their goal positions. 
Wires cannot cross. 
