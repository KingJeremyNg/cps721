male(tony).
male(bob).
male(john).

female(sue).
female(ann).

parent(ann, bob).
parent(tony, sue).
parent(john, ann).
parent(john, tony).

mother(M, P) :- female(M), parent(M, P).
father(F, P) :- male(F), parent(F, P).
sister(S, P) :- female(S), parent(X, S), Parent(X, P), S \= P.
brother(B, P) :- male(B), parent(X, B), parent(X, P), B\= P.

ancestor(A, P) :- parent(A, P).                     /* base case */
ancestor(A, P) :- parent(A, X), ancestor(X, P).     /* recursive case */
