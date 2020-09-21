baby(marc).
baby(mary).

toddler(michelle).
toddler(steve).
toddler(bob).

likes(marc, michelle).
likes(bob, ray).
likes(bob, michelle).

male(ray).
male(marc).
male(bob).
male(steve).

female(mary).
female(michelle).

child(X) :- toddler(X).
child(X) :- male(X), child(X).
girl(X) :- female(X), child(X).

person(X) :- male(X).
person(X) :- female(X).

adult(X) :- person(X), not Child(X), not baby(X).

likes(X, Y) :- baby(Y), adult(X).
likes(X, bob). /* Everyone likes bob */