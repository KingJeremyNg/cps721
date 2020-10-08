/* https://prnt.sc/uvhjuv */
myReverse(L1, L2) :-
    helpRev(L1, [], L2).
helpRev([], Acc, Acc).
helpRev([Head | Tail], Stack, Output) :-
    helpRev(Tail, [Head | Stack], Output).

/*
https://prnt.sc/uvhzyg
Format: tree(Node, L, R).
*/
tree(a, nil, nil).
tree(c, tree(t, nil, nil), tree(b, nil, nil)).
tree(a, tree(b, nil, tree(d, nil, nil)), tree(c, nil, nil)).
/* Writing predicates: leaves(Tree, N) */
leaves(tree(A, nil, nil), 1).
leaves(nil, 0).
leaves(tree(Root, L, R), N) :-
    leaves(L, NL),
    leaves(R, NR),
    N is NL + NR.

/* A -> B -> C -> nil */
next(a, next(b, next(c, nil))).
/* Write predicate memberTerms(X, List). */

myLength(List, Length) :- accLength(List, 0, Length).
accLength([], Result, Result).
accLength([H | T], Acc, Result) :-
    Acc1 is Acc + 1, accLength(T, Acc1, Result).