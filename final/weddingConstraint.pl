day(1).
day(2).
day(3).
day(4).
day(5).

solve([P, R, S, V, W, A, C, E, F, I]) :-
    /* Ann was married on Monday, but not with Wally */
    A = 1,
    day(W), W \= A,

    /* Stan's wedding was on Wednesday */
    S = 3,

    /* Rob was married on Friday, but not to Ida */
    R = 5,
    day(I), I \= R,

    /* Vern (who married Fran) was married the day after Eve */
    day(E),
    day(V),
    day(F),
    V is E + 1,
    F is E + 1,
    V = F,

    day(P),
    day(C),

    all_diff([P, R, S, V, W]),
    all_diff([A, C, E, F, I]).

all_diff([]).
all_diff([N | L]) :- not member(N, L), all_diff(L).