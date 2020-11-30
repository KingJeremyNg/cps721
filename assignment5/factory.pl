/* Factory domain */

/* Universal situations and fluents based planner  */
:- dynamic free/2.

/*
This is necessary if rules with the same predicate in the head are not consecutive in your program.
 We are looking for a list of actions represented by a variable Plan
 such that executing actions in Plan leads from the initial state
 to a reachable state where a goal condition is true.
 */

solve_problem(Bound, Plan) :-
   C0 is cputime,                                  % C0 is time when program starts %
   max_length(Plan, Bound),                        % Bound is the maximal length of Plan   %
   reachable(S, Plan),
   goal_state(S),                                  % A situation S must be a solution of the problem %
   Cf is cputime, D is Cf - C0, nl,                % Cf is time when program finishes  %
   write('Elapsed time (sec): '), write(D), nl.

max_length([], N) :- N >= 0.
max_length([First | L], N1) :- N1 > 0, N is N1 - 1, max_length(L, N).

reachable(S,[]) :- initial_state(S).

/*
This rule is for the initial parts of the factory domain.
Use it when you debug your precondition and other rules and when you test whether your program can solve easy planning problems. 
Comment it out, when answering the last question about heuristics in the factory domain. Instead, use the other rule provided below.

reachable(S2, [M | List]) :- reachable(S1, List), legal_move(S2, M, S1).

The following rule uses declarative heuristics to cut search: remove comments and write your rules to implement the predicate useless(M,List) (see below).
You use this only when answering the last question in the factory domain, for solving a planning problem that requires 7 steps.
*/
reachable(S2, [M | ListOfPastActions]) :-
   reachable(S1, ListOfPastActions),
   legal_move(S2, M, S1),
   not useless(M, ListOfPastActions).

legal_move([A | S], A, S) :- poss(A, S).
initial_state([]).

/* Precondition axioms */
% write your precondition rules here: you have to provide brief comments %

/* drill(x): drill x, provided x is free */
poss(drill(X), S) :- free(X, S).

/* shape(x): shape a part x, 
this action will undo the effects of actions drill(x) and paint(x).
It is always possible to execute this action. */
poss(shape(X), S).

/* bolt(x, y): fasten a part x to a part y by bolts provided both x and y are drilled and not fastened to anything.
*/
poss(bolt(X, Y), S) :-
   drilled(X, S),
   drilled(Y, S),
   free(X, S),
   free(Y, S).

/* paint(x, colour): paint a part x using colour, provided x is free and colour is available (see below). */
poss(paint(X, Colour), S) :-
   free(X, S),
   available(Colour).


/* Successor state axioms */
% write your successor state rules here: you have to include brief comments %

/* connected(x, y, s): parts x and y are connected in s if they are fastened by bolts. 
Connected parts remain connected after any action unless the agent shapes one of them. */
connected(X, Y, [bolt(X, Y) | S]).
connected(X, Y, [bolt(Y, X) | S]).
connected(X, Y, [A | S]) :-
   not (A = shape(X)),
   not (A = shape(Y)),
   connected(X, Y, S).

/* painted(x, c, s): a part x has colour c in s. 
A painted part remains painted unless it is shaped, drilled or painted in a different colour. */
painted(X, C, [paint(X, C) | S]).
painted(X, C, [A | S]) :-
   free(X, S),
   not (A = paint(X, Y), Y \= C),
   not (A = shape(X)),
   not (A = drill(X)),
   painted(X, C, S).

/* shaped(x, s): a part x is shaped in a situation s. 
A shaped part remains shaped no matter what actions are subsequently executed. */
shaped(X, [shape(X) | S]).
shaped(X, [A | S]):-
   shaped(X,S).

/* free(x, s): a part x is free, i.e., it is not fastened to anything in s. */
free(X, [shape(X) | S]).
free(X, [A | S]) :-
   not (A = bolt(X, Y)),
   not (A = bolt(Y, X)),
   free(X, S).

/* drilled(x, s), a part x is drilled in s. 
A drilled part remains drilled unless it is shaped. */
drilled(X, [drill(X) | S]).
drilled(X, [A | S]) :-
   not (A = shape(X)),  
   drilled(X, S).


/* ---------- Heuristics To Cut Search ------------- */
% write your rules implementing the predicate  useless(Action,History) here. %

useless(drill(X),[paint(X,C) | History]).
useless(drill(X), [bolt(X,Y) | History]).
useless(drill(X), [drill(X) | History]).
useless(drill(X), [shape(X), drill(X) | History]).

useless(shape(X), [drill(X) | History]).
useless(shape(X), [paint(X, C) | History]).

useless(paint(X, C), [paint(X, C) | History]).
useless(paint(X, C), [shape(X), paint(X, C) | History]).
useless(paint(X, C), [drill(X), paint(X, C) | History]). 

useless(bolt(X, Y), [bolt(Y, X) | History]).
useless(bolt(X, Y), [shape(X), bolt(X, Y) | History]).
useless(bolt(X, Y), [shape(X), bolt(Y, X) | History]).

:- [initFactory].

/*
This last line compiles also the file initFactory.pl that should be in same directory as this file.

solve_problem(7, ([bolt(a, b), paint(b, blue), paint(a, green), drill(a), drill(b), shape(b), shape(a)])).
solve_problem(7, ([bolt(b, a), paint(b, blue), drill(b), paint(a, green), drill(a), shape(a), shape(b)])).
solve_problem(7, Plan).
*/

