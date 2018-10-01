#const f = 50.
time(0..f).

% if you start at X,Y then you have a wire at X,Y
wire(X,Y,W,0) :- start(X,Y,W).

% possible directions to move from spot X,Y
direction(X,Y,up) :- x(X), y(Y;Y+1), not block(X,Y), not block(X,Y+1).
direction(X,Y,down) :- x(X), y(Y), y(Y-1), not block(X,Y), not block(X,Y-1).
direction(X,Y,left) :- x(X;X-1), y(Y), not block(X,Y), not block(X-1,Y).
direction(X,Y,right) :- x(X;X+1), y(Y), not block(X,Y), not block(X+1,Y).

% for every wire, pick a direction to move
1{move(W,D,T): direction(X,Y,D)}1 :- wire(X,Y,W,T), not goal(X,Y,W), time(T).

% if you move a wire, you have a wire at the new spot
wire(X,Y-1,W,T+1) :- wire(X,Y,W,T), move(W,down,T), time(T).
wire(X,Y+1,W,T+1) :- wire(X,Y,W,T), move(W,up,T), time(T).
wire(X+1,Y,W,T+1) :- wire(X,Y,W,T), move(W,right,T), time(T).
wire(X-1,Y,W,T+1) :- wire(X,Y,W,T), move(W,left,T), time(T).

% can't move back to where you just were
:- wire(X,Y,W,T), move(W,down,T), move(W,up,T+1), time(T).
:- wire(X,Y,W,T), move(W,up,T), move(W,down,T+1), time(T).
:- wire(X,Y,W,T), move(W,right,T), move(W,left,T+1), time(T).
:- wire(X,Y,W,T), move(W,left,T), move(W,right,T+1), time(T).

% can't move in squares/rectangles (no 3 neighbors)
:- wire(X,Y,W,T), wire(X+1,Y,W,T), wire(X-1,Y,W,T), wire(X,Y+1,W,T), time(T).
:- wire(X,Y,W,T), wire(X+1,Y,W,T), wire(X-1,Y,W,T), wire(X,Y-1,W,T), time(T).
:- wire(X,Y,W,T), wire(X,Y+1,W,T), wire(X,Y-1,W,T), wire(X+1,Y,W,T), time(T).
:- wire(X,Y,W,T), wire(X,Y+1,W,T), wire(X,Y-1,W,T), wire(X-1,Y,W,T), time(T).

% you can't have 2 wires on the same spot
:- wire(X,Y,W,T), wire(X,Y,W1,T), W<W1, time(T).

% you can't have a wire reach the goal and move again
:- wire(X,Y,W,T), goal(X,Y,W), move(W,D,T).

wire(X,Y,W) :- wire(X,Y,W,T).

% every wire must reach its goal
:- goal(X,Y,W), not wire(X,Y,W).

% you can't have a goal and have a different wire on it
:- goal(X,Y,W), wire(X,Y,W1), W<W1.
%wire(X,Y,W,T+1) :- wire(X,Y,W,T).
#show move/3.
