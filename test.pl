likes(jeremy, test).

/* cd("//C/Users/jerem/Desktop/Code/cps721/assignment5"). */
/* cd("//C/Users/jerem/Desktop/Code/cps721"). */

Successor State Axioms
  
  Positive
    - Fluent was made true by most recent action taken
  Negative
    - Fluent was true before taking an action, action did not make it false

  e.g. Pocket domain

  doorUnlocked([unlockDoor | S]). (Positive SSA)
  doorUnlocked([A | S]) :- doorUnlocked(S). (Negative SSA)
  holding(X, [takeOut(X, P) | S]). (Positive SSA)
  holding(X, [A | S]) :- holding(X, S), not A = putBack(X, P). (Negative SSA)

  e.g. Elevator domain

  liftAt(F,S)  - the elevator is at a floor F in situation S

  liftAt(F, [up(F1, F) | S]). (Positive)
  liftAt(F, [down(F1, F) | S]). (Positive)
  liftAt(F, [A|S]) :- liftAt(F, S), not A = up(F, F1), not A = down(F, F2).