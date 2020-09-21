isaLink(mammal, animal).
isaLink(reptile, animal).
isaLink(bird, animal).
isaLink(fish, animal).
isaLink(whale, mammal).
isaLink(dog, mammal).
isaLink(retriever, dog).
isaLink(poodle, dog).
isaLink(goldeRetriever, retriever).
isaLink(cat, mammal).
isaLink(tabby, cat).
isaLink(canary, bird).
isaLink(robin, canary).
isaLink(penguin, bird).
isaLink(emperorPenguin, penguin).
isaLink(chicken, bird).
isaLink(shark, fish).

leaf(X) :- isaLink(X, Y), not isaLink(Z, X).

sibling(X, Y) :- isaLink(X, Z), isaLink(Y, Z), not X = Y.