/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

taken([mon,12,r1]). taken([mon,1,r1]). taken([mon,1,r4]). taken([mon,2,r4]).
taken([tues,9,r2]). taken([tues,10,r2]). taken([tues,3,r1]). taken([tues,4,r1]).
taken([wed,10,r3]). taken([wed,11,r3]). taken([wed,12,r3]). taken([wed,1,r3]).
taken([thurs,12,r4]). taken([thurs,1,r4]).
taken([fri,3,r1]). taken([fri,4,r1]).

room(r1). room(r2). room(r3). room(r4).
day(mon). day(tues). day(wed). day(thurs). day(fri).
hour(9). hour(10). hour(11). hour(12).
hour(1). hour(2). hour(3). hour(4).

class([Day, Hour, Room]) :-
    day(Day), hour(Hour), room(Room).

/*
The task is to schedule classes for 6 courses:
artificial intelligence (2+2),
operating systems (2+1),
web design (3+0),
data structures (2+1),
algorithms (2+1),
networks (1+1).
There are a few constraints that have to be respected when we compute a timetable.
OS prof is Network prof.
Algorithm prof is data structures prof.
*/

solve([AI, OS, Net, DS, Alg, Web]) :-
    /* Same Prof DS/Alg */
    DS = [DS1, DS2, DS3],
    class(DS1), class(DS2), class(DS3), available(DS),
    two_consecutive_hours(DS1, DS2),
    not same_day(DS1, DS3),

    Alg = [Alg1, Alg2, Alg3],
    class(Alg1), class(Alg2), class(Alg3), available(Alg),
    two_consecutive_hours(Alg1, Alg2),
    not same_day(Alg1, Alg3),
    not in_conflict(DS, Alg),
    different_time([DS1, DS2, DS3, Alg1, Alg2, Alg3]),
    /* **************** */

    /* Same Prof OS/Net */
    OS = [OS1, OS2, OS3],
    class(OS1), class(OS2), class(OS3), available(OS),
    two_consecutive_hours(OS1, OS2),
    not same_day(OS1, OS3),
    not in_conflict(OS, DS), not in_conflict(OS, Alg),

    Net = [Net1, Net2],
    class(Net1), class(Net2), available(Net),
    not in_conflict(Net, DS), not in_conflict(Net, Alg),
    not in_conflict(OS, Net),
    not same_day(Net1, Net2),
    different_time([OS1, OS2, OS3, Net1, Net2]),
    /* **************** */

    AI = [AI1, AI2, AI3, AI4],
    class(AI1), class(AI2), class(AI3), class(AI4), available(Net),
    two_consecutive_hours(AI1, AI2),
    not same_day(AI1, AI3),
    two_consecutive_hours(AI3, AI4),
    not in_conflict(AI, DS), not in_conflict(AI, Alg),
    not in_conflict(AI, OS), not in_conflict(AI, Net),

    Web = [Web1, Web2, Web3],
    class(Web1), class(Web2), class(Web3), available(Web),
    two_consecutive_hours(Web1, Web2),
    two_consecutive_hours(Web2, Web3),
    not in_conflict(Web, DS), not in_conflict(Web, Alg),
    not in_conflict(Web, OS), not in_conflict(Web, Net),
    not in_conflict(Web, AI).

/* SOLUTION */
print_solution([AI, OS, Net, DS, Alg, Web]) :-
    cputime(StartTime),
    solve([AI, OS, Net, DS, Alg, Web]),
    cputime(EndTime),
    Time is EndTime - StartTime, nl,
    write('****************************************************************'), nl,
    write('AI course is scheduled on '), write(AI), nl,
    write('Operating Systems course is scheduled on '), write(OS), nl,
    write('Networks course is scheduled on '), write(Net), nl,
    write('Data structures course is scheduled on '), write(DS), nl,
    write('Algorithms course is scheduled on '), write(Alg), nl,
    write('Web design course is scheduled on '), write(Web), nl,
    write('Program runtime: '), write(Time), nl.

/* Check if all time slots in list are different */
different_time([[Day, Hour, Room]]).
different_time([[Day1, Hour1, Room1] | Tail]) :-
    not (member([Day2, Hour2, Room2], Tail), Day1 = Day2, Hour1 = Hour2),
    different_time(Tail).

/* Check for 2 consecutive time slots */
two_consecutive_hours([Day, Hour1, Room], [Day, Hour2, Room]) :-
    append(X, [Hour1, Hour2 | Y], [9, 10, 11, 12, 1, 2, 3, 4]).

/* Check if 2 classes are scheduled for the same time slot */
in_conflict(List1, List2) :-
    member([Day, Hour, Room], List1),
    member([Day, Hour, Room], List2).

/* Check if Day is equal */
same_day([Day1, Hour1, Room1], [Day2, Hour2, Room2]) :-
    Day1 = Day2.

/* Check if time slots frome list are taken */
available([]).
available([[Day, Hour, Room] | Tail]) :-
    not (taken([Day, Hour, Room])),
    available(Tail).

/*
print_solution([[[mon,9,r1], [mon,10,r1], [tues,9,r1], [tues,10,r1]], [[mon,9,r2], [mon,10,r2], [tues,9,r3]], [[mon,11,r1], [tues,10,r3]], [[mon,9,r3], [mon,10,r3], [tues,9,r4]], [[mon,11,r2], [mon,12,r2], [tues,11,r1]], [[tues,12,r3], [tues,1,r3], [tues,2,r3]]]).
*/