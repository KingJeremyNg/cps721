/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

value(historyK,p1,bad). value(debt,p1,high). value(collateral,p1,none).
value(hist,p2,unknown). value(debt,p2,high). value(collateral,p2,none).
value(hist,p3,unknown). value(debt,p3,low). value(collateral,p3,none).
value(hist,p4,unknown). value(debt,p4,low). value(collateral,p4,none).
value(hist,p5,unknown). value(debt,p5,low). value(collateral,p5,none).
value(hist,p6,unknown). value(debt,p6,low). value(collateral,p6,adequate).
value(historyK,p7,bad). value(debt,p7,low). value(collateral,p7,none).
value(historyK,p8,bad). value(debt,p8,low). value(collateral,p8,adequate).
value(historyK,p9,good). value(debt,p9,low). value(collateral,p9,none).
value(historyK,p10,good). value(debt,p10,high). value(collateral,p10,adequate).
value(historyK,p11,good). value(debt,p11,high). value(collateral,p11,none).
value(historyK,p12,good). value(debt,p12,high). value(collateral,p12,none).
value(historyK,p13,good). value(debt,p13,high). value(collateral,p13,none).
value(historyK,p14,bad). value(debt,p14,high). value(collateral,p14,none).

sameValue(Att, [Head], Val) :-
    value(Att, Head, Val).
sameValue(Att, [Head | Tail], Val) :-
    sameValue(Att, Tail, Val), value(Att, Head, Val).

/* divide(Examples, Att, Boolean, Pos, Neg) */
divide([Head | []], Att, Boolean, [PosH | []], [NegH | []]) :-
    value(Att, Head, Boolean).
divide([Head | Tail], Att, Boolean, [PosH | PosT], [NegH | NegT]) :-
    divide(Tail, Att, Boolean, PosT, NegT),
    value(Att, Head, Boolean),
    PosH is Head.

divide1([Head], Att, Boolean, [], [Head]) :- not value(Att, Head, Boolean).
divide1([Head], Att, Boolean, [Head], []) :- value(Att, Head, Boolean).

/*
minim([Min | []], Min).
minim([Head, Body, | Tail], Min) :-
    Head =< Body,
    minim([Head | Tail], Min).
minim([Head, Body | Tail], Min) :-
    Head > Body,
    minim([Body | Tail], Min).
*/