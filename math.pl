addition(X, Y, Sum) :-
    Sum is X + Y.

subtractMY(X, Y, N) :-
    N is X - Y.

factorial(N, Result) :- N = 0, Result is Result.
factorial(N, Result) :- N > 0, factorial(N - 1, Result * N).
/* this wrong rn */

sum1([], 0).
/*
Analysis:
    sum([X1], X1).
    sum([X1, X2], S) :- S is X1+X2.
    sum([X1, X2, X3], S) :- sum([X1, X2], M), S is X3+M.
*/
sum1([Head | Tail], S) :- sum(Tail, M), S is Head + M.