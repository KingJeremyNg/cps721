/* DATABASE */
account(12, ann, mcu, 2505).            account(13, robert, rbc, 1001).         account(14, philip, scotia, 1200).
account(15, jeremy, rbc, 500).          account(16, jose, td, 800).             account(17, elijah, scotia, 600).
account(18, linh, tangerine, 15000).    account(19, christian, rbc, 1750).      account(20, adam, bmo, 10200).          
account(21, miguel, mcu, 12500).        account(22, jason, rbc, 2700).          account(23, michelle, cibc, 1300).      
account(24, michelle, cibc, 1775).      account(25, parth, bmo, 5000).          account(26, eyho, rbc, 666).
account(27, xing, rbc, 13000).

created(12, ann, mcu, 8, 2018).         created(13, robert, rbc, 6, 2019).      created(14, philip, scotia, 5, 2000).
created(15, jeremy, rbc, 8, 2008).      created(16, jose, td, 6, 2010).         created(18, linh, tangerine, 9, 2015).
created(19, christian, rbc, 2, 2012).   created(20, adam, bmo, 8, 1950).        created(21, miguel, tangerine, 10, 2013).
created(22, jason, rbc, 2, 2015).       created(23, michelle, cibc, 6, 2012).   created(24, michelle, cibc, 11, 2014).
created(25, parth, bmo, 10, 2020).      created(26, eyho, rbc, 12, 2018).       created(27, xing, rbc, 4, 2019).

gender(ann, female).    gender(robert, male).       gender(philip, male).
gender(jeremy, male).   gender(jose, male).         gender(elijah, male).   
gender(linh, male).     gender(christian, male).    gender(adam, male).
gender(miguel, male).   gender(jason, male).        gender(michelle, female).
gender(parth, male).    gender(eyho, male).         gender(xing, male).

lives(ann, markham).            lives(robert, scarborough).     lives(philip, richmondHill).
lives(jeremy, sanFrancisco).    lives(jose, richmondHill).      lives(elijah, scarborough).
lives(linh, hanoi).             lives(christian, markham).      lives(adam, markham).
lives(miguel, sanFrancisco).    lives(jason, richmondHill).     lives(michelle, brampton).
lives(parth, scarborough).      lives(eyho, losAngeles).        lives(xing, markham).

location(markham, canada).          location(scarborough, canada).      
location(richmondHill, canada).     location(sanFrancisco, usa).    
location(hanoi, vietnam).           location(toronto, canada).
location(brampton, canada).         location(losAngeles, usa).

location(mcu, toronto).         location(mcu, brampton).    location(mcu, scarborough).
location(mcu, losAngeles).

location(rbc, toronto).         location(rbc, richmondHill).
location(rbc, markham).         location(rbc, scarborough).
location(rbc, brampton).

location(scotia, toronto).      location(scotia, richmondHill).
location(scotia, markham).      location(scotia, scarborough).
location(scotia, brampton).

location(td, toronto).          location(td, richmondHill).
location(td, markham).          location(td, scarborough).
location(td, brampton).

location(tangerine, toronto).   location(tangerine, richmondHill).

location(bmo, toronto).         location(bmo, richmondHill).
location(bmo, markham).         location(bmo, scarborough).
location(bmo, brampton).

location(cibc, toronto).        location(cibc, richmondHill).
location(cibc, markham).        location(cibc, scarborough).
location(cibc, brampton).


/* HELPERS */
bank(X) :-
    location(X, City),
    not city(X).

city(X) :-
    location(X, County),
    not location(County, Y).

country(X) :-
    location(City, X),
    not location(X, Y).

hasAccount(X) :-
    account(Number, X, Bank, Balance).

person(X) :-
    gender(X, Gender).

/* LEXICON */
article(a).
article(an).
article(any).
article(the).

common_noun(bank, X) :- bank(X).
common_noun(city, X) :- city(X).
common_noun(country, X) :- country(X).
common_noun(man, X) :- gender(X, male).
common_noun(woman, X) :- gender(X, female).
common_noun(male, X) :- gender(X, male).
common_noun(female, X) :- gender(X, female).
common_noun(owner, X) :- account(Number, X, Bank, Balance).
common_noun(person, X) :- person(X).
common_noun(account, X) :- account(X, Name, Bank, Balance).
common_noun(account, X) :- account(Number, X, Bank, Balance).
common_noun(balance, X) :- account(Number, Name, Bank, X).
common_noun(american, X) :- adjective(american, X).
common_noun(canadian, X) :- adjective(canadian, X).

/* preposition([], X, Y). */
preposition(of, X, Y) :- of(X, Y).
preposition(from, X, Y) :- from(X, Y).
preposition(in, X, Y) :- in(X, Y).
preposition(with, X, Y) :- with(X, Y).
preposition(between, Ref, X, Y) :- between(Ref, X, Y).

/* NUMBER between X and Y */
between(Ref, X, Y) :- number(Ref), Ref > X, Ref < Y.
/* BALANCE between X and Y */
between(Ref, X, Y) :- account(Number, Name, Bank, Balance), Ref = account(Number, Name, Bank, Balance), Balance > X, Balance < Y.

/* BALANCE of ACCOUNT */
of(X, Y) :- account(Y, Name, Bank, X).
/* ACCOUNT of PERSON */
of(X, Y) :- account(X, Y, Bank, Balance), person(Y).
/* OWNER of ACCOUNT */
of(X, Y) :- account(Y, X, Bank, Balance), common_noun(owner, X).
/* COUNTRY of ACCOUNT */
of(X, Y) :- country(X), account(Y, Name, Bank, Balance), location(Bank, City), location(City, X).

/* PERSON from ACCOUNT */
from(X, Y) :- person(X), account(Y, X, Bank, Balance).
/* PERSON from CITY */
from(X, Y) :- person(X), city(Y), lives(X, Y).
/* OWNER from COUNTRY */
from(X, Y) :- common_noun(owner, X), lives(X, Z), location(Z, Y).
/* BALANCE from ACCOUNT */
from(X, Y) :- account(Y, Name, Bank, X).

/* ACCOUNT in BANK */
in(X, Y) :- account(X, Name, Y, Amount).
/* ACCOUNT in LOCAL BANK */
in(X, Y) :- account(X, Name, Y, Amount), location(Y, City), location(City, Canada). 
/* CITY in COUNTRY */
in(X, Y) :- city(X), country(Y), location(X, Y).
/* BANK in CITY */
in(X, Y) :- bank(X), city(Y), location(X, Y).
/* BANK in COUNTRY */
in(X, Y) :- bank(X), country(Y), location(X, City), location(City, Y).
/* BALANCE IN ACCOUNT */
in(X, Y) :- account(Y, Name, Bank, X).

/* BANK with ACCOUNT */
with(X, Y) :- bank(X), account(Y, Name, X, Balance).
/* CITY with ACCOUNT */
with(X, Y) :- city(X), account(Y, Name, Bank, Balance), location(Bank, City).
/* PERSON with ACCOUNT */
with(X, Y) :- person(X), account(Y, X, Bank, Balance).
/* MALE with ACCOUNT */
with(X, Y) :- gender(X, male), account(Y, X, Bank, Balance).
/* FEMALE with ACCOUNT */
with(X, Y) :- gender(X, female), account(Y, X, Bank, Balance).
/* OWNER with ACCOUNT */
with(X, Y) :- common_noun(owner, X), account(Y, X, Bank, Balance).
/* ACCOUNT with BANK */
with(X, Y) :- account(X, Name, Y, Balance).
/* BANK with BALANCE */
with(X, Y) :- bank(X), account(Number, Name, X, Y).
/* ACCOUNT with BALANCE */
with(X, Y) :- account(X, Name, Bank, Y).

proper_noun(City) :- city(City).
proper_noun(Bank) :- bank(Bank).
proper_noun(Country) :- country(Country).
proper_noun(Person) :- person(Person).
proper_noun(Male) :- gender(Male, male).
proper_noun(Female) :- gender(Female, male).

adjective(american, X) :- lives(X, City), location(City, usa).
adjective(american, X) :- city(X), location(X, usa).
adjective(american, X) :- bank(X), location(X, City), city(City), location(City, usa).
adjective(canadian, X) :- lives(X, City), location(City, canada).
adjective(canadian, X) :- city(X), location(X, canada).
adjective(canadian, X) :- bank(X), location(X, City), city(City), location(City, canada).
adjective(female, X) :- gender(X, female).
adjective(male, X) :- gender(X, male).
adjective(local, X) :- lives(X, City), location(City, canada). 
adjective(local, X) :- location(X, City), location(City, canada).
adjective(foreign, X) :- lives(X, City), not location(City, canada).
adjective(foreign, X) :- location(X, City), location(City, Country), not Country = canada.
adjective(small, X) :- account(X, Name, Bank, Balance), Balance < 1000.
adjective(small, X) :- account(Number, Name, Bank, X), X < 1000.
adjective(medium, X) :- account(X, Name, Bank, Balance), Balance > 1000, Balance < 10000.
adjective(large, X) :- account(X, Name, Bank, Balance), Balance > 10000.
adjective(large, X) :- account(Number, Name, Bank, X), X > 10000.
adjective(old, X) :- created(X, Name, Bank, Month, Year), not Year = 2020.
adjective(recent, X) :- created(X, Name, Bank, Month, Year), Year = 2020.


/******************* parser **********************/

/* what([the | Tail], Ref) :- setof(X, np([the | Tail], Ref), Set). */
/* what([Art | Tail], Ref) :- Art \= the, np([Art | Tail], Ref). */
what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name], Name) :- proper_noun(Name).
np([the | Rest], What) :- np2(Rest, X), not (np2(Rest, Y), X \= Y), Who = X.
np([Art | Rest], Who) :- article(Art), np2(Rest, Who).

/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj | Rest], Who) :- adjective(Adj, Who), np2(Rest, Who).
np2([Noun | Rest], Who) :- common_noun(Noun, Who), mods(Rest, Who).
/* np2([Preposition | Rest], Who) :-  prepPhrase([Preposition | Rest], Who). */

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, Who) :-
    appendLists(Start, End, Words),
    prepPhrase(Start, Who),
    mods(End, Who).

/* BETWEEN - END OF SENTENCE */
prepPhrase([between, X, and, Y], Who) :-
    number(X), number(Y),
    preposition(between, Who, X, Y).
/* BETWEEN - MIDDLE OF SENTENCE */
prepPhrase([between, X, and, Y | Rest], Who) :-
    number(X), number(Y),
    preposition(between, Who, X, Y),
    np(Rest, Who).
/* GENERAL CASE */
prepPhrase([Prep | Rest], Who) :-
    preposition(Prep, Who, Ref),
    np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :- appendLists(L1, L2, L3).

/* example noun phrases
    what([a, city, in, canada], X).
    what([the, canadian, man, with, a, large, account, in, a, local, bank], X).
    what([any, foreign, male, person, with, a, small, account, in, a, canadian, bank], X).
    what([a, foreign, male, person, from, losAngeles, with, a, small, account, in, rbc], X).
    what([a, balance, of, a, large, account, in, a, local, bank], X).
    what([any, local, bank, with, an, account, of, a, man, from, usa], X).
    what([an, owner, from, canada, of, a, large, account], X).
    what([a, woman, from, markham, with, a, medium, account], X).
    what([a, bank, in, canada, with, a, small, account, of, a, foreign, person], X).
    what([a, medium, account, in, a, canadian, bank, with, a, small, account, of, an, american], X).
    what([the, balance, of, the, medium, account, in, metro credit union, of, a, woman, from, markham], X).
    what([a,balance,of,an,account,of,an,american,with,a,small,account,in, a,local,bank,with,a,large,account],X).
    what([a, balance, between, 100, and, 25000], X).
*/  