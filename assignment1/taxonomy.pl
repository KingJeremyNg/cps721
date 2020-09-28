/*
Jeremy Ng, 500882192, Section 2
Jose Manipon, 500906166, Section 4
Elijah Tungul, 500885285, Section 5
*/

isaLink(mammal, animal).
isaLink(reptile, animal).
isaLink(bird, animal).
isaLink(fish, animal).
isaLink(whale, mammal).
isaLink(dog, mammal).
isaLink(retriever, dog).
isaLink(poodle, dog).
isaLink(goldenRetriever, retriever).
isaLink(cat, mammal).
isaLink(tabby, cat).
isaLink(canary, bird).
isaLink(robin, canary).
isaLink(penguin, bird).
isaLink(emperorPenguin, penguin).
isaLink(chicken, bird).
isaLink(shark, fish).

leaf(X) :- isaLink(X, Y), not isaLink(Z, X).

sibling(X, Y) :- isaLink(X, Z), isaLink(Y, Z), X \= Y.

grandParent(X, Y) :- isaLink(X, Z), isaLink(Z, Y).

isa(X, Y) :- X = Y.
isa(X, Y) :- isaLink(X, Y).
isa(X, Y) :- isaLink(X, Z), isa(Z, Y).

mostSpecificSubsumer(X, Y, Z) :- isaLink(X, Z), Y = Z.
mostSpecificSubsumer(X, Y, Z) :- isaLink(Y, Z), X = Z.
mostSpecificSubsumer(X, Y, Z) :- isaLink(X, Z), isaLink(Y, Z), X \= Y.
mostSpecificSubsumer(X, Y, Z) :- isaLink(X, Z), isaLink(Y, B), X \= Y, Z \= B, mostSpecificSubsumer(X, B, Z).
mostSpecificSubsumer(X, Y, Z) :- isaLink(X, A), isaLink(Y, Z), X \= Y, A \= Z, mostSpecificSubsumer(A, Y, Z).
mostSpecificSubsumer(X, Y, Z) :- isaLink(X, A), isaLink(Y, B), X \= Y, A \= B, mostSpecificSubsumer(A, B, Z).
