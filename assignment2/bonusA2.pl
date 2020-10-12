/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

/*
union(List1, List2, U)
intersection(List, List2, Common)
*/

/* permutation(List1, List2) */
permutation(List1, List2) :-
    msort(List1, X),
    msort(List2, Y),
    X = Y.

/* myUnion(List1, List2, List3) */
myUnion(List1, List2, Union) :-
    append(List1, List2, Acc),
    sort(Acc, Result),
    permutation(Result, Union).

/* myIntersection(List1, List2, List3) */
myIntersection(List1, List2, Intersection) :-
    intersection(List1, List2, Acc),
    permutation(Acc, Intersection).