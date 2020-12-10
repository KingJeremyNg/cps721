solve_problem(L) :-
    reachable(S, L),
    goal_state(S).

reachable(S, []) :-
    initial_state(S).
reachable(S1, [M | L]) :-
    reachable(S, L), legal_move(S1, M, S).

/* Initial state */
full(1, [ ]). full(3, [ ]). full(5, [ ]).
empty(2, [ ]). empty(4, [ ]). empty(6, [ ]).

/* Goal state */
goal_state(S) :-  full(1, S), full(2, S), full(3, S), empty(4, S), empty(5, S), empty(6, S).

/* Precondition Axioms */
poss(swap(P1, P2), S) :-
    full(P1, S),
    empty(P2, S),
    P2 =:= P1 + 1.

poss(swap(P1, P2), S) :-
    full(P2, S),
    empty(P1, S),
    P2 =:= P1 + 1.

/* SSA */
full(P1, [A | S]) :-
    A = swap(P1, P2),
    full(P2, S).

full(P2, [A | S]) :-
    A = swap(P1, P2),
    full(P1, S).

full(P1, [A | S]) :-
    not (A = swap(P1, P2)),
    not (A = swap(P2, P1)),
    full(P1, S).

empty(P, S) :- not full(P, S).
