
/*-------------- Generic Domain Properties ------------*/

inCity(ryerson,toronto).   inCity(pearsonAirport,toronto).
inCity(univChicago,chicago).	inCity(ohareAirport,chicago).
inCity(univBritishColumbia,vancouver).	inCity(yvrAirport,vancouver).
inCity(memorialUnivNewfoundland,stJohn).	inCity(stJohnAirport,stJohn).

airport(pearsonAirport).	airport(ohareAirport).
airport(yvrAirport).	airport(stJohnAirport).

truck(daimler).    truck(volvo).    truck(ford).    truck(gmc).

airplane(airbus380).  airplane(an124).  airplane(md90).  airplane(boeing747).

vehicle(X) :- truck(X).		
vehicle(X) :- airplane(X).

/*----------------- The initial state.----------------- */

at(bigBox1,memorialUnivNewfoundland,[]).	at(bigBox2,ryerson,[]).
at(bigBox3,univBritishColumbia,[]).	at(bigBox4,univOfTor,[]).

at(daimler,pearsonAirport,[]).	at(volvo,univOfTor,[]).
at(ford,yvrAirport,[]).	at(gmc,stJohnAirport,[]).

at(airbus380,pearsonAirport,[]).	at(an124,pearsonAirport,[]).
at(boeing747,stJohnAirport,[]).	at(md90,yvrAirport,[]).

/*------------------ Goal state ----------------------- */

/* This is a very easy planning problem that can be solved by a sequence of 2 actions.*/
%% goal_state(S) :- 	in(bigBox1,gmc,S).


%% This simple planning problem takes 3 steps and is solved in about 2sec without heuristics
%% goal_state(S) :- at(bigBox1,stJohnAirport,S).

%% solve_problem(3, [drive(truck, memorialUnivNewfoundland, stJohnAirport, stJohn), load(bigBox1, truck, memorialUnivNewfoundland)]).

%% This problem requires 5 actions and can be solved in less than 1min without heuristics
%% goal_state(S) :- 	in(bigBox1,boeing747,S).


%% The following problem needs 6 actions to solve and takes a few minutes without heuristics
 goal_state(S) :- at(bigBox1,pearsonAirport,S).


/*-------------------------------------------------------------------------*/

%% The remaining part of this file is related to a BONUS question ONLY %%


% The following problem needs 8 actions. it can be solved in a few seconds with heuristics
% but it is difficult to solve without heuristics
% goal_state(S) :- 	in(bigBox1,daimler,S).


% The following problem needs 9 actions; it was not solved (without heuristics) after an hour
% With the complete set of heuristics, this problem takes less than 1 sec to solve!
% goal_state(S) :- at(bigBox1,ryerson,S).


%% With the goal state the plan of 9 actions can be easily computed with heuristics
%% in a few sconds, but without heuristics it cannot be computed.
%	goal_state(S) :-  at(bigBox2,univBritishColumbia,S).


% The planning problem when 2 boxes should be delivered between universities 
% requires 18 steps: it is computationally challenging even with declarative heuristics.
% On a fast machine it takes about 30min to solve this problem. However, without 
% heuristics this problem is computationally infeasible even for the fastest computers.
%	goal_state(S) :-  at(bigBox1,ryerson,S),
%		at(bigBox2,univBritishColumbia,S).
