/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

minim([Min | []], Min).
minim([Head, Body, | Tail], Min) :-
    Head =< Body,
    minim([Head | Tail], Min).
minim([Head, Body | Tail], Min) :-
    Head > Body,
    minim([Body | Tail], Min).

polAdd([], [], []).
polAdd([], [Head2 | Tail2], [HeadX | TailX]) :-
    HeadX is Head2 + 0,
    polAdd([], Tail2, TailX).
polAdd([Head1 | Tail1], [], [HeadX | TailX]) :-
    HeadX is Head1 + 0,
    polAdd(Tail1, [], TailX).
polAdd([Head1 | Tail1], [Head2 | Tail2], [HeadX | TailX]) :-
    HeadX is Head1 + Head2,
    polAdd(Tail1, Tail2, TailX).

constMult([], C, []).
constMult([Head | Tail], C, [HeadX | TailX]) :-
    HeadX is Head * C,
    constMult(Tail, C, TailX).

polMult([], Poly, []).
polMult([Head | Tail], Poly, Result) :-
    polMult(Tail, Poly, X),
    constMult(Poly, Head, MultResult),
    polAdd(MultResult, [0 | X], Result).
