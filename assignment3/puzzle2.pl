/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

solve([S, A, N, T, C, L, U, X, M]) :-

    dig(A), dig(S), S > 0,
    S is (A - S) mod 10,
    C1 is div(A - S, 10),

    dig(T), dig(U),
    A is (T - U + C1) mod 10,
    C10 is div(T - U + C1, 10),

    dig(N), dig(A),
    M is (N - A + C10) mod 10,
    C100 is div(N - A + C10, 10),

    dig(A), dig(L),
    X is (A - L + C100) mod 10,
    C1000 is div(A - L + C100, 10),

    dig(S), dig(C), C > 0, S > 0,
    0 is S - C + C1000,

    all_diff([S, A, N, T, C, L, U, X, M]).

dig(0). dig(1). dig(2). dig(3). dig(4).
dig(5). dig(6). dig(7). dig(8). dig(9).

all_diff([]).
all_diff([N | L]) :- not member(N, L), all_diff(L).

print_solution :-
    StartTime is cputime,
    solve([S, A, N, T, C, L, U, X, M]),
    EndTime is cputime,
    Time is EndTime - StartTime,
    write('   '), write(S), write(A), write(N), write(T), write(A),nl,
    write('-  '), write(C), write(L), write(A), write(U), write(S),nl,
    write('    '), write(X), write(M), write(A), write(S), nl,
    write('Total Time taken is '),write(Time).

/*
member(N, [N | L]).
member(N, [M | L]) :- member(N, L).
*/