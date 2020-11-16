solve_problem(L) :-
    reachable(S, L),
    goal_state(S).

reachable(S, []) :-
    initial_state(S).
reachable(S1, [M | L]) :-
    reachable(S, L), legal_move(S1, M, S).

/*
https://prnt.sc/vi1cvn
*/
initial_state([0, 0]).
goal_state([Anything, 2]).

/* [Next state of jug3, next state of jug 4], action, [current state of jug3, current state of jug 4] */
legal_move([3, Jug4], fill3, [0, Jug4]).

legal_move([Jug3, 4], fill4, [Jug3, 0]).

legal_move([0, Jug4], dump3, [Jug3, Jug4]) :-
    not Jug3 =:= 0.

legal_move([3, Final4], fill3from4, [Jug3, Jug4]) :-
    not Jug3 =:= 3, not Jug4 =:= 0,
    Fill is 3 - Jug3, Final4 is Jug4 - Fill.

legal_move([Final3, 4], fill4from3, [Jug3, Jug4]) :-
    not Jug4 =:= 4, not Jug3 =:= 0,
    Fill is 4 - Jug4, Final3 is Jug3 - Fill.

legal_move([0, Final4], empty3into4, [Jug3, Jug4]) :-
    Final4 is Jug3 + Jug4, Jug3 > 0, Final4 < 5.

legal_move([Final3, 0], empty4into3, [Jug3, Jug4]) :-
    Final3 is Jug3 + Jug4, Jug4 > 0, Final3 < 4.

/*
https://prnt.sc/vi1wrr
https://prnt.sc/vi1y5w
*/
