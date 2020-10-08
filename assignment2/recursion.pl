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

/*
polMult([2,2,1], [1,2,3], X).
1) [2,2,1], [1,2,3], X
2) [2,1], [1,2,3], X
3) [1], [1,2,3], X
4) [], _, X = []
5) GO BACK
6) [1], [1,2,3], X ->
    a) constMult([1,2,3], 1, Value)
    b) polAdd(Value = [1,2,3], X = [0 | []], RESULT)
    c) RESULT = [1,2,3]
7) GO BACK
8) [2,1], [1,2,3], RESULT = [1,2,3]
    a) constMult([1,2,3], 2, Value)
    b) polAdd(Value = [2,4,6], X = [0 | RESULT]/[0,1,2,3], RESULT)
    c) RESULT = [2,5,8,3]
9) GO BACK
10) [2,2,1], [1,2,3], RESULT = [2,5,8,3]
    a) constMult([1,2,3], 2, Value)
    b) polAdd(Value = [2,4,6], X = [0 | RESULT]/[0,2,5,8,3], RESULT)
    c) RESULT = [2,6,11,8,3]
*/

/*
append ([ ], List, List).
append ([ X | List1], List2, [X | Result]) :- append(List1, List2, Result).

sum1([], 0).
sum1([Head | Tail], S) :- sum(Tail, M), S is Head + M.

list_sum( []     , [Y|Ys] , [Z|Zs] ) :- Z is 0+Y , list_sum( [] , Ys , Zs ) .
list_sum( [X|Xs] , []     , [Z|Zs] ) :- Z is X+0 , list_sum( Xs , [] , Zs ) .
list_sum( [X|Xs] , [Y|Ys] , [Z|Zs] ) :- Z is X+Y , list_sum( Xs , Ys , Zs ) .
*/

/*
length([Head | Tail], L) :- length(Tail, M), L is M+1

min_in_list([Min],Min).                 % We've found the minimum

min_in_list([H,K|T],M) :-
    H =< K,                             % H is less than or equal to K
    min_in_list([H|T],M).               % so use H

min_in_list([H,K|T],M) :-
    H > K,                              % H is greater than K
    min_in_list([K|T],M).               % so use K
*/