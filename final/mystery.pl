/*
To discover who killed Mr. Boddy, you need to learn where each person was, and what weapon was in the room.

To begin, you need to know the suspects. There are three men (George, John, Robert)
and three women (Barbara, Christine, Yolanda).
Each person was in a different room (Bathroom, Dining Room, Kitchen, Living Room, Pantry, Study).
A suspected weapon was found in each room (Bag, Firearm, Gas, Knife, Poison, Rope).

It was discovered that Mr. Boddy was gassed in the pantry. The suspect found in that room was the murderer. Who, then, do you point the finger towards?
*/

man(george).
man(john).
man(robert).
woman(barbara).
woman(christine).
woman(yolanda).
person(X) :- man(X).
person(X) :- woman(X).

solve([Bathroom, DiningRoom, Kitchen, LivingRoom, Pantry, Study, Bag, Firearm, Gas, Knife, Poison, Rope]) :-
    /* Clue 1: Barbara was either in the study or the bathroom; Yolanda was in the other. */
    woman(Bathroom),
    woman(Study),
    Bathroom \= Study,
    Bathroom \= christine,
    Study \= christine,

    /* Clue 2: The person with the bag, who was not Barbara nor George, was not in the bathroom nor the dining room. */
    person(Bag),
    Bag \= barbara,
    Bag \= george,
    Bathroom \= Bag,
    person(DiningRoom),
    DiningRoom \= Bag,

    /* Clue 3: The woman with the rope was found in the study. */
    woman(Rope),
    Rope = Study,

    /* Clue 4: The man in the kitchen was not found with the rope, knife, bag, or firearm. */
    man(Kitchen),
    person(Knife),
    Kitchen \= Knife,
    person(Firearm),
    Kitchen \= Firearm,
    Kitchen \= Rope,
    Kitchen \= Bag,

    /* Clue 5: The weapon in the living room was found with either John or George. */
    man(LivingRoom),
    LivingRoom \= robert,

    /* Clue 6: The knife was not in the dining room. */
    DiningRoom \= Knife,

    /* Clue 7: Yolanda was not with the weapon found in the study nor the pantry. */
    person(Pantry),
    Pantry \= yolanda,
    Study \= yolanda,

    /* Clue 8: The firearm was in the room with George. */
    Firearm = george,

    Gas = Pantry,
    person(Poison),

    all_diff([Bathroom, DiningRoom, Kitchen, LivingRoom, Pantry, Study]),
    all_diff([Bag, Firearm, Gas, Knife, Poison, Rope]).

all_diff([]).
all_diff([N | L]) :- not member(N, L), all_diff(L).
