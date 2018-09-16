% if you start at X,Y then you have a wire at X,Y
wire(X,Y,W) :- start(X,Y,W).

% possible directions to move from spot X,Y
direction(X,Y,up) :- x(X), y(Y;Y+1), not block(X,Y), not block(X,Y+1).
direction(X,Y,down) :- x(X), y(Y;Y-1), not block(X,Y), not block(X,Y-1).
direction(X,Y,left) :- x(X;X-1), y(Y), not block(X,Y), not block(X-1,Y).
direction(X,Y,right) :- x(X;X+1), y(Y), not block(X,Y), not block(X+1,Y).

% for every wire, pick a direction to move
1{move(X,Y,D,W): direction(X,Y,D)}1 :- wire(X,Y,W), not goal(X,Y,W).

% if you move a wire, you have a wire at the new spot
wire(X,Y-1,W) :- wire(X,Y,W), move(X,Y,D,W), direction(X,Y,D), D=down.
wire(X,Y+1,W) :- wire(X,Y,W), move(X,Y,D,W), direction(X,Y,D), D=up.
wire(X+1,Y,W) :- wire(X,Y,W), move(X,Y,D,W), direction(X,Y,D), D=right.
wire(X-1,Y,W) :- wire(X,Y,W), move(X,Y,D,W), direction(X,Y,D), D=left.

% can't move back to where you just were
:- move(X,Y,D,W), D=down, move(X,Y-1,D1,W), D1=up.
:- move(X,Y,D,W), D=up, move(X,Y+1,D1,W), D1=down.
:- move(X,Y,D,W), D=right, move(X+1,Y,D1,W), D1=left.
:- move(X,Y,D,W), D=left, move(X-1,Y,D1,W), D1=right.

% can't move in squares/rectangles (no 3 neighbors)
:- wire(X,Y,W), wire(X+1,Y,W), wire(X-1,Y,W), wire(X,Y+1,W).
:- wire(X,Y,W), wire(X+1,Y,W), wire(X-1,Y,W), wire(X,Y-1,W).
:- wire(X,Y,W), wire(X,Y+1,W), wire(X,Y-1,W), wire(X+1,Y,W).
:- wire(X,Y,W), wire(X,Y+1,W), wire(X,Y-1,W), wire(X-1,Y,W).

% you can't have 2 wires on the same spot
:- wire(X,Y,W), wire(X,Y,W1), W<W1.

% you can't have a goal and not have the wire reach it
:- goal(X,Y,W), not wire(X,Y,W).

% you can't have a wire reach the goal and move again
:- wire(X,Y,W), goal(X,Y,W), move(X,Y,D,W).

#show move/4.
