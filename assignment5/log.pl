%% LOGISTICS DOMAIN %%
/* Universal situations and fluents based planner  */
:- dynamic at/3.
/* This is necessary if rules with the same predicate in the head are not
   consecutive in your program.
*/ 

% We are looking for a list of actions represented by a variable Plan
% such that executing actions in Plan leads from the initial state 
% to a reachable state where a goal condition is true.

solve_problem(Bound, Plan) :-
   C0 is cputime,                         % C0 is time when program starts %
   max_length(Plan, Bound),                % Bound is the maximal length of Plan   %
   reachable(S, Plan), 
   goal_state(S),                         % A situation S must be a solution of the problem %
   Cf is cputime, D is Cf - C0, nl,       % Cf is time when program finishes  %
   write('Elapsed time (sec): '), write(D), nl.

max_length([], N) :- N >= 0.
max_length([First | L], N1) :- N1 > 0, N is N1 - 1, max_length(L, N).

reachable(S, []) :- initial_state(S).
/* This rule is for the regular part of the assignment */
reachable(S2, [M | List]) :- reachable(S1, List), legal_move(S2, M, S1).   

/* The following rule is for the bonus question only: remove comments
   and write your own rules to implement the predicate useless(M,List). 

reachable(S2, [M | ListOfActions]) :- reachable(S1,ListOfActions),
                    legal_move(S2,M,S1),
                    not useless(M,ListOfActions).
*/

legal_move([A | S], A, S) :- poss(A, S).
initial_state([]).

/*------------ Precondition Axioms------------------- */
% write here your rules expressing when actions are possible

/* load(Box, Vehicle, Location) loads Box (from a location in a city) onto Vehicle 
It is possible only if both Box and V ehicle are at the same location, Box is not currently loaded
if Vehicle is either a truck or an airplane, but Box is neither truck, nor an airplane. */
poss(load(Box, Vehicle, Location), S) :-
   at(Box, _, []),
   not vehicle(Box),
   not loaded(Box, S),
   at(Box, Location, S),
   vehicle(Vehicle),
   at(Vehicle, Location, S).

/* unload(Box, V hicle, Location) unloads Box from Vehicle into the current Location. 
only if Box is in Vehicle, Vehicle is at Location, and Vehicle is either a truck or an airplane.
Once a box has been unloaded, it is no longer in a vehicle. */
poss(unload(Box, Vehicle, Location), S) :-
   at(Box, _, []),
   not vehicle(Box),
   loaded(Box, S),
   in(Box, Vehicle, S),
   at(Vehicle, Location, S),
   vehicle(Vehicle).

/* drive(Tr, Loc1, Loc2, City) moves the truck Tr from Loc1 to Loc2 and 
only if the truck Tr is at Loc1 and both locations are in the same city */ 
poss(drive(Tr, Loc1, Loc2, City), S) :-
   truck(Tr),
   inCity(Loc1, City),
   inCity(Loc2, City),
   Loc1 \= Loc2,
   at(Tr, Loc1, S).

/* The action fly(Air, LocF rom, LocT o) is possible if Air is an airplane at LocFrom, and 
if both locations are airports in distinct cities. */
poss(fly(Air, LocFrom, LocTo), S) :-
   airplane(Air),
   at(Air, LocFrom, S),
   LocFrom \= LocTo,
   airport(LocFrom),
   airport(LocTo),
   inCity(LocFrom, X),
   inCity(LocTo, Y),
   X \= Y.
 
/*----------- Successor State Axioms-------------- */
% write here your rules expressing effects of actions 

in(Box, Vehicle, [load(Box, Vehicle, Location1) | S]).
in(Box, Vehicle, [A | S]) :-
   not (A = unload(Box, Vehicle, Location2)),
   in(Box, Vehicle, S).

loaded(B, [load(B, Vehicle, Location) | S]).
loaded(B, [A | S]) :-
   not (A = unload(B, Vehicle, Location)),
   loaded(B, S).

at(X, Loc, [drive(X, _, Loc, City) | S]).
at(X, Loc, [fly(X, _, Loc) | S]).

at(X, Loc, [drive(Vehicle, _, Loc, _), load(X, Vehicle, _) | S]).
at(X, Loc, [fly(Vehicle, _, Loc), load(X, Vehicle, _) | S]).

at(X, Loc, [drive(Tr, Loc1, Loc, City) | S]) :-
   at(X, _, []),
   not vehicle(X),
   member(load(X, Tr, _), S),
   not (member(unload(X, Tr, _), S)),
   at(X, Loc, S).
at(X, Loc, [fly(Air, LocFrom, Loc) | S]) :-
   at(X, _, []),
   not vehicle(X),
   member(load(X, Air, _), S),
   not (member(unload(X, Air, _), S)),
   at(X, Loc, S).
at(X, Loc, [A | S]) :-
   not (A = drive(X, _, Loc1, City), Loc1 \= Loc),
   not (A = fly(X, _, LocTo), LocTo \= Loc),
   not (A = unload(X, Vehicle, Loc1), Loc1 \= Loc),
   at(X, Loc, S).

/*
    at(X,Loc,[A|S]):- airplane(X), at_ar(X,Loc,[A|S]).
    at(X,Loc,[A|S]):- truck(X), at_tr(X,Loc,[A|S]).
    at(X,Loc,[A|S]):- at(X,_,[]), not vehicle(X), at_bx(X,Loc,[A|S]).
    
    at_tr(X,Loc,[A|S]):- A=drive(X,_,Loc,_).
    at_tr(X,Loc,[A|S]):- not (A=drive(X,_,Loc1,_), Loc\=Loc1), at_tr(X,Loc,S).

    at_ar(X,Loc,[A|S]):- A=fly(X,_,Loc).
    at_ar(X,Loc,[A|S]):- not (A=fly(X,_,Loc1), Loc\=Loc1), at(X,Loc,S).
    
    at_bx(X,Loc,[fly(Vehicle,_,Loc),load(X,Vehicle,_)|S]):- airplane(Vehicle).
    at_bx(X,Loc,[drive(Vehicle,_,Loc,_),load(X,Vehicle,_)|S]):- truck(Vehicle).
    at_bx(X,Loc,[load(X,Vehicle,Loc)|S]):- vehicle(Vehicle).

    at_bx(X,Loc,[A|S]):- not (A=unload(X,Vehicle,Loc1), Loc\=Loc1), at(X,Loc,S).
*/

/*----------- Successor State Axioms-------------- */
% write here your rules expressing effects of actions 



:- [initLogistics].

/* This command loads the file  initLogistics.pl  with the initial and goal states.
  Keep it in the same folder as this file. Do not copy content here, because TA
  will test your program using another setting (with different trucks, airplanes)
*/


/* ----------------- Heuristics To Cut Search ------------------ */
	% BONUS: write here your rules implementing the predicate "useless" %



