addition(X, Y, Sum) :-
    Sum is X + Y.

subtractMY(X, Y, N) :-
    N is X - Y.

factorial(N, Result) :- N = 0, Result is Result.
factorial(N, Result) :- N > 0, factorial(N - 1, Result * N).
/* this wrong rn */