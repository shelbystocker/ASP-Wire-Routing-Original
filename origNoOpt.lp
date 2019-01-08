%nextTo if valid option to move to
nextTo(X,Y,X+1,Y) :- x(X;X+1), y(Y), not block(X,Y), not block(X+1,Y).
nextTo(X,Y,X-1,Y) :- x(X;X-1), y(Y), not block(X,Y), not block(X-1,Y).
nextTo(X,Y,X,Y+1) :- x(X), y(Y;Y+1), not block(X,Y), not block(X,Y+1).
nextTo(X,Y,X,Y-1) :- x(X), y(Y;Y-1), not block(X,Y), not block(X,Y-1).

wire(X,Y,W) :- start(X,Y,W).

% move from X,Y to X1,Y1
1{move(X,Y,X1,Y1,W): nextTo(X,Y,X1,Y1)}1 :- wire(X,Y,W), not goal(X,Y,W).

% if you move, you have a new wire
wire(X1,Y1,W):- move(X,Y,X1,Y1,W), nextTo(X,Y,X1,Y1).

% you can't move in squares/rectangles
:- wire(X,Y,W), wire(X+1,Y,W), wire(X-1,Y,W), wire(X,Y+1,W).
:- wire(X,Y,W), wire(X+1,Y,W), wire(X-1,Y,W), wire(X,Y-1,W).
:- wire(X,Y,W), wire(X,Y+1,W), wire(X,Y-1,W), wire(X+1,Y,W).
:- wire(X,Y,W), wire(X,Y+1,W), wire(X,Y-1,W), wire(X-1,Y,W).

% you can't have 2 different wires on the same spot
:- wire(X,Y,W), wire(X,Y,S), W<S.

% you can't move back to where you just were
:- move(X,Y,X1,Y1,W), move(X1,Y1,X,Y,W), nextTo(X,Y,X1,Y1), nextTo(X1,Y1,X,Y).

% you must reach the goal
:- goal(X,Y,W), not wire(X,Y,W).

#show move/5.
