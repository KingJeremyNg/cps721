/*
https://prnt.sc/vm7q70
https://prnt.sc/vm7u3p
https://prnt.sc/vm7vqb
*/

solve_problem(L) :-
    reachable(S, L),
    goal_state(S).

reachable(S, []) :-
    initial_state(S).

reachable(S1, [M | L]) :-
    reachable(S, L), legal_move(S1, M, S).

/* modification here */
initial_state([]).
legal_move([A | S], A, S) :- poss(A, S).

/* Precondition axioms */
poss(board(F, P), S) :- passenger(P), origin(P, F), floor(F), liftAt(F, S).
poss(depart(F, P), S) :- passenger(P), destin(P, F), floor(F), liftAt(F, S), boarded(P, S).
poss(up(F1, F2), S) :- liftAt(F1, S), floor(F1), floor(F2), F2 > F1.
poss(down(F1, F2), S) :- liftAt(F1, S), floor(F1), floor(F2), F1 > F2.

/* SSA */
boarded(P, [board(F, P) | S]).
boarded(P, [A | S]) :- not A = depart(P, F), boarded(P, S).

served(P, [depart(F, P) | S]).
served(P, [A | S]) :- served(P, S).

liftAt(F2, [up(F1, F2) | S]).
liftAt(F2, [down(F1, F2) | S]).
liftAt(F, [A | S]) :- not A = up(F, FU), not A = down(F, FD), lift(F, S).
liftAt(0, []).

passenger(p0).
passenger(p1).
passenger(p2).
passenger(p3).

floor(0).   floor(1).   floor(2).   floor(3).   floor(4).
floor(5).   floor(6).   floor(7).   floor(8).   floor(9).
floor(10).  floor(11).  floor(12).  floor(13).  floor(14).
floor(15).  floor(16).  floor(17).  floor(18).  floor(19).

goal_state(S) :- served(p0, S), served(p1, 5), served(p2, 5), served(p3, 5).

/*
HOMEWORK
https://prnt.sc/vm8cg8
*/