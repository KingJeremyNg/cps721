/*
hasAccount(Person, Bank, Amount).
lives(Person, City).
created(Person, Bank, Month, Year).
*/

created(ann, mcu, 1, 2020).
created(joy, rbc, 8, 2019).
created(jeremy, rbc, 6, 2019).
created(jeremy, td, 6, 2019).
created(steve, td, 3, 2017).
created(steve, rbc, 8, 2017).
created(bob, bmo, 4, 2010).
created(bob, nbc, 3, 2012).

lives(steve, quebec).
lives(jose, nyc).
lives(eli, nyc).
lives(linh, nyc).

hasAccount(bob, bmo, 1000).
hasAccount(bob, nbc, 1000).
hasAccount(steve, td, 2000).
hasAccount(jeremy, rbc, 1200).
hasAccount(jeremy, td, 800).
hasAccount(jose, bofa, 1001).
hasAccount(eli, bofa, 1002).
hasAccount(linh, bofa, 9999).

% 1. When did Ann open her account at Metro Credit Union?
?- created(ann, mcu, Month, Year).

% 2. Does anyone have both an account at Bank of Montreal and an account at National Bank of Canada?
?- hasAccount(X, bmo, Amount1), hasAccount(X, nbc, Amount2).

% 3. Is there a person who has an account at Toronto Dominion and who does not live in Toronto?
?- lives(X, Location), hasAccount(X, td, Amount), not Location = toronto.

% 4. Who opened an account in August 2019 at the Royal Bank of Canada?
?- created(X, rbc, 8, 2019).

% 5. Has anyone opened more than one account with balances less than 1500 in June 2019?
?- created(X, Y, 6, 2019), created(X, Z, 6, 2019), hasAccount(X, Y, AmountY), hasAccount(X, Z, AmountZ), AmountY < 1500, AmountZ < 1500, not Y = Z.

% 6. Does any bank have more than two accounts with balances greater than 1000 opened by people who live in New York?
?- lives(X, nyc), lives(Y, nyc), lives(Z, nyc), hasAccount(X, Bank, AmountX), hasAccount(Y, Bank, AmountY), hasAccount(Z, Bank, AmountZ), AmountX > 1000, AmountY > 1000, AmountZ > 1000, not X = Y, not Y = Z, not X = Z.

% 7. Has anyone living outside of Toronto opened accounts at more than one banks in the same year?
?- lives(X, Location), created(X, Bank1, Month1, Year), created(X, Bank2, Month2, Year), not Location = toronto, not Bank1 = Bank2.

% 8. Who has opened accounts with the same amount at distinct banks in distinct years?
?- created(X, Bank1, Month1, Year1), created(X, Bank2, Month2, Year2), hasAccount(X, Bank1, Amount), hasAccount(X, Bank2, Amount), not Year1 = Year2.

% 9. Find a person from Toronto who has the oldest account at CIBC.

% 10. Find two distinct people outside of Toronto who have the largest accounts.
