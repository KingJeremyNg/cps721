/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

flr(1). flr(2). flr(3). flr(4). flr(5).
flr(6). flr(7). flr(8). flr(9). flr(10).
flr(11). flr(12). flr(13). flr(14). flr(15).
flr(16). flr(17). flr(18). flr(19). flr(20).

/*
  solve1(List)
  Interleaving of generate and test
  The ordering of the interleaving of generate and test was created so that the mistakes are caught earlier in the program.
  The variables generate values at the same time as testing, which allows the program to backtrack less.
*/
solve1([Peter, Romeo, Sam, Tom, Accountant, Businessman, CompSci, Dentist]) :-
    flr(Peter), flr(Sam), Peter > Sam, flr(Tom), Peter < Tom,
    flr(Romeo), flr(Dentist), Romeo < Dentist,
    flr(CompSci), Tom is CompSci * 5,
    Peter is Dentist - 3,
    CompSci > 3,
    flr(Businessman), flr(Accountant),
    Businessman - 2 - Accountant =:= (Dentist - Accountant)//2, 
    Peter = Businessman,
    Sam is Dentist // 2,
    Romeo * 2 =:= Accountant - 2,
    Dentist >= Tom,
    all_diff([Peter, Romeo, Sam, Tom]).

/*
  solve2(List)
  Generate and test
*/
solve2([Peter, Romeo, Sam, Tom, Accountant, Businessman, CompSci, Dentist]) :-
    flr(Peter), flr(Romeo), flr(Sam), flr(Tom),
    flr(Accountant), flr(Businessman), flr(CompSci), flr(Dentist),
    Peter > Sam, Peter < Tom,
    Romeo < Dentist,
    Tom is CompSci * 5,
    Peter is Dentist - 3,
    CompSci > 3,
    Businessman - 2 - Accountant =:= (Dentist - Accountant)//2,
    Peter = Businessman,
    Sam is Dentist // 2,
    Romeo * 2 =:= Accountant - 2,
    Dentist >= Tom,
    all_diff([Peter, Romeo, Sam, Tom]).

all_diff([]).
all_diff([N | L]) :- not member(N, L), all_diff(L).

print_solution(List) :-
    Start is cputime,
    solve1([Peter, Romeo, Sam, Tom, Accountant, Businessman, CompSci, Dentist]),
    End is cputime,
    Time is End - Start,
    write("Peter is on floor "), write(Peter), write("."), nl,
    write("Romeo is on floor "), write(Romeo), write("."), nl,
    write("Sam is on floor "), write(Sam), write("."), nl,
    write("Tom is on floor "), write(Tom), write("."), nl,
    write("Accountant is on floor "), write(Accountant), write("."), nl,
    write("Businessman is on floor "), write(Businessman), write("."), nl,
    write("Computer Scientist is on floor "), write(CompSci), write("."), nl,
    write("Dentist is on floor "), write(Dentist), write("."), nl,
    write("Computation time: "), write(Time), write("."), nl.
