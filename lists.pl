/*
[] - empty
[a] = [a | []] - one element
[A, B | [C]] - [A, B BAR [C]]
[a | [b, c]] - [head | tail]

[a] = [a]
[a] \= [b]
[a] = [A]
A - Anything
[A] - one element

[A | B] - A \= [], B = []++
[X, Y] - Exactly 2 elements because comma notation
[A | B] = [a] - Because [a | []]
[X, Y] is the same as [X | [Y]]
[X | Y] cannot equate to [X, Y]. Can only transform if Y = [y]

Simplifying
[b | [W | [a, Z]]] = [b, c | [d, a, f]]
[b, W | [a, Z]] = [b, c, d, a, f]
[b, W, a, Z] = [b, c, d, a, f]
Cannot equate LHS with RHS. With comma notation, LHS is 4 elements, RHS is 5 elements.

[con | [A | B]] = [D, A | [t, e, s, t]]
[con, A | B]
D = con
A = A
B = [t, e, s, t]

[a, b | [[q], [r] | S]] = [X | [Y, Z | [W]]]
[a, b, [q], [r] | S] = [X, Y, Z | [W]]
[a, b, [q], [r] | []] = [X, Y, Z, W | []]
*/
