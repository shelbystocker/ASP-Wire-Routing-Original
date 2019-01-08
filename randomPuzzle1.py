#!/usr/bin/python
import random
import sys

size = 5

print("x(1..%d).") % (size)
print("y(1..%d).") % (size)

# generate wires
rx1 = random.randint(1,size)
ry1 = random.randint(1,size)
R1 = str(rx1) + str(ry1)
rx2 = random.randint(1,size)
ry2 = random.randint(1,size)
R2 = str(rx2) + str(ry2)

# make sure wires 1 & 2 don't start on same spot
condition = True
while condition:
        if R1==R2:
                rx2 = random.randint(1,size)
                ry2 = random.randint(1,size)
                R2 = str(rx2) + str(ry2)
        else:
                condition = False

rx3 = random.randint(1,size)
ry3 = random.randint(1,size)
R3 = str(rx3) + str(ry3)

# make sure wires 3 & 1, 3 & 2 don't start on same spot
condition1 = True
while condition1:
        if R1==R3 or R3==R2:
                rx3 = random.randint(1,size)
                ry3 = random.randint(1,size)
                R3 = str(rx3) + str(ry3)
        else:
                condition1 = False

# print wire starting positions
print 'start(',rx1,',',ry1,',1).'
print 'start(',rx2,',',ry2,',2).'
print 'start(',rx3,',',ry3,',3).'

# generate goals for wire 1
gx1 = random.randint(1,size)
gy1 = random.randint(1,size)
G1 = str(gx1) + str(gy1)

# make sure goal 1 doesn't start on a wire spot
condition2 = True
while condition2:
        if G1==R1 or G1==R2 or G1==R3:
                gx1 = random.randint(1,size)
                gy1 = random.randint(1,size)
                G1 = str(gx1) + str(gy1)
        else:
                condition2 = False

# generate goals for wire 2
gx2 = random.randint(1,size)
gy2 = random.randint(1,size)
G2 = str(gx2) + str(gy2)

# make sure goals 1 & 2 don't start on same spot
# make sure goal 2 doesn't start on a wire spot
condition3 = True
while condition3:
        if G1==G2 or G2==R1 or G2==R2 or G2==R3:
                gx2 = random.randint(1,size)
                gy2 = random.randint(1,size)
                G2 = str(gx2) + str(gy2)
        else:
                condition3 = False

# generate goals for wire 3
gx3 = random.randint(1,size)
gy3 = random.randint(1,size)
G3 = str(gx3) + str(gy3)

# make sure goals 3 & 1, 3 & 2 aren't on same spot
# make sure goal 3 isn't on a wire spot
condition4 = True
while condition4:
        if G1==G3 or G3==G2 or G3==R1 or G3==R2 or G3==R3:
                gx3 = random.randint(1,size)
                gy3 = random.randint(1,size)
                G3 = str(gx3) + str(gy3)
        else:
                condition4 = False

# print goal positions
print 'goal(', gx1, ',', gy1,',1).'
print 'goal(', gx2, ',', gy2,',2).'
print 'goal(', gx3, ',', gy3,',3).'

# generate blocks
numBlocks = int(sys.argv[1])
for i in range(numBlocks):
        condition5 = True
        while condition5:
                blockX = random.randint(1,size)
                blockY = random.randint(1,size)
                Block = str(blockX) + str(blockY)
                # make sure blocks aren't on robot inital spots or goals
                if Block != R1 and Block != R2 and Block != R3 and Block != G1 and Block != G2 and Block != G3:
                        condition5 = False
        print 'block(', blockX, ',', blockY, ').'
