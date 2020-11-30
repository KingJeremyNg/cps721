/*
https://prnt.sc/vql96k
https://prnt.sc/vqlb00
JOINT PROBABILITY DISTRIBUTION
P(A, T, L, S, B, C, X, D)
    = P(X | C, A, T, L, S, B, X, D) * P(C, A, T, L, S, B, D)
    = P(X | C) . P(C, A, T, L, S, B, D)
    = P(X | C) . P(D | C, B) . P(C, A, T, L, S, B)
    = P(X | C) . P(D | C, B) . P(C | T, L) . P(A, T, L, S, B)
    ...
    = P(X | C) . P(D | C, B) . P(C | T, L) . P(B | S) . P(L | S) . P(T | A) . P(A) . P(S)
Random Variables are binary
2^8 - 1 = 255
# of random variables
https://prnt.sc/vqll4r

P(A = t | X = t, D = t)
    = P(A = t, D = t, X = t) divided by P(D = t, X = t)
    = SUMOF T, L, S, B, C P(A = t, T, L, S, B, C, X = t, D = t)
    divided by SUMOF A, T, L, S, B, C P(A, T, L, S, B, C, X = t, D = t)
https://prnt.sc/vqlrhy
*/