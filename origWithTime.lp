#const f = 35.
time(0..f).

%nextTo if valid option to move to
nextTo(X,Y,X+1,Y) :- x(X;X+1), y(Y), not block(X,Y), not block(X+1,Y).
nextTo(X,Y,X-1,Y) :- x(X;X-1), y(Y), not block(X,Y), not block(X-1,Y).
nextTo(X,Y,X,Y+1) :- x(X), y(Y;Y+1), not block(X,Y), not block(X,Y+1).
nextTo(X,Y,X,Y-1) :- x(X), y(Y;Y-1), not block(X,Y), not block(X,Y-1).

wire(X,Y,W,0) :- start(X,Y,W).

% move from X,Y to X1,Y1
1{move(X,Y,X1,Y1,W,T): nextTo(X,Y,X1,Y1)}1 :- wire(X,Y,W,T), not goal(X,Y,W), time(T).

% if you move, you have a new wire
wire(X1,Y1,W,T+1):- move(X,Y,X1,Y1,W,T), nextTo(X,Y,X1,Y1), time(T).

% you can't move in squares/rectangles
:- wire(X,Y,W,T), wire(X+1,Y,W,T), wire(X-1,Y,W,T), wire(X,Y+1,W,T), time(T).
:- wire(X,Y,W,T), wire(X+1,Y,W,T), wire(X-1,Y,W,T), wire(X,Y-1,W,T), time(T).
:- wire(X,Y,W,T), wire(X,Y+1,W,T), wire(X,Y-1,W,T), wire(X+1,Y,W,T), time(T).
:- wire(X,Y,W,T), wire(X,Y+1,W,T), wire(X,Y-1,W,T), wire(X-1,Y,W,T), time(T).

% you can't have 2 different wires on the same spot
:- wire(X,Y,W), wire(X,Y,S), W<S.

% you can't move back to where you just were
:- move(X,Y,X1,Y1,W,T), move(X1,Y1,X,Y,W,T1), nextTo(X,Y,X1,Y1), nextTo(X1,Y1,X,Y), time(T), time(T1).

wire(X,Y,W) :- wire(X,Y,W,T).

% you must reach the goal
:- goal(X,Y,W), not wire(X,Y,W).

#show move/6.
