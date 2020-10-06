minim([Min | []], Min).
minim([Head, Body | Tail], Min) :-
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
polMult([Head1 | Tail1], Poly, Product) :-

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