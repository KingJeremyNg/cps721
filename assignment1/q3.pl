history(alice, bad).
history(bob, unknown).
history(cherry, unknown).
history(david, bad).
history(edward, good).
history(franklin, good).
history(george, good).
debt(alice, high).
debt(bob, low).
debt(cherry, low).
debt(david, low).
debt(edward, low).
debt(franklin, high).
debt(george, high).
collateral(alice, none).
collateral(bob, none).
collateral(cherry, none).
collateral(david, none).
collateral(edward, none).
collateral(franklin, none).
collateral(george, none).
income(alice, "0_to_15").
income(bob, "15_to_35").
income(cherry, "over35").
income(dave, "0_to_15").
income(edward, "over35").
income(franklin, "0_to_15").
income(george, "over35").
risk(X, high) :- history(X, unknown), debt(X, high).
risk(X, high) :- history(X, bad), collateral(X, none).
risk(X, high) :- history(X, unknown), debt(X, low), collateral(X, none), income(X, "0_to_15").
risk(X, high) :- history(X, good), debt(X, high), collateral(X, none), income(X, "0_to_15").
risk(X, moderate) :- history(X, unknown), debt(X, low), collateral(X, none), income(X, "15_to_35").
risk(X, moderate) :- history(X, bad), collateral(X, adequate).
risk(X, moderate) :- history(X, good), debt(X, high), collateral(X, none), income(X, "15_to_35").
risk(X, low) :- history(X, unknown), debt(X, low), collateral(X, none), income(X, "over35").
risk(X, low) :- history(X, unknown), debt(X, low), collateral(X, adequate).
risk(X, low) :- history(X, good), debt(X, low).
risk(X, low) :- history(X, good), debt(X, high), collateral(X, adequate).
risk(X, low) :- history(X, good), debt(X, high), collateral(X, none), income(X, "over35").