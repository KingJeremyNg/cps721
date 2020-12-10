answer(true).
answer(false).

solve([A, B, C, D, E]) :-
    setof(X, problem([A, B, C, D, E]), Set).

problem([A, B, C, D, E]) :-
    answer(Answer1),
    answer(Answer2),
    answer(Answer3),
    answer(Answer4),
    answer(Answer5),
    Answers = [Answer1, Answer2, Answer3, Answer4, Answer5],

    Ann = [true, true, false, true, false],
    Bob = [false, true, true, true, false],
    Cindy = [true, false, true, true, false],
    David = [false, true, true, false, true],
    Edward = [true, false, true, false, true],

    /* 1. Cindy got more answers right than Ann */
    correctCounter(Cindy, Answers, X),
    correctCounter(Ann, Answers, Y),
    X > Y,

    /* 2. David got more answers right than Bob */
    correctCounter(David, Answers, I),
    correctCounter(Bob, Answers, J),
    I > J,

    /* 3. Edward did not get all the answers right, nor did he get them all wrong */
    correctCounter(Edward, Answers, K),
    K > 0,
    K < 5,

    A = Answer1,
    B = Answer2,
    C = Answer3,
    D = Answer4,
    E = Answer5.

correctCounter([], [], 0).
correctCounter([H | T], [H | AT], X) :-
    correctCounter(T, AT, Acc),
    X is Acc + 1.
correctCounter([H | T], [AH | AT], X) :-
    correctCounter(T, AT, Acc),
    H \= AH,
    X is Acc.
