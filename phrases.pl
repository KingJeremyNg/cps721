/*
1	S -> NP  VP
2	VP -> copula_verb  Mods
3	VP -> transitive verb  NP  Mods
4	VP -> intransitive verb   Mods
5	NP -> proper_noun
6	NP -> article NP2   
7	NP2 -> adjective NP2
8	NP2 -> common_noun Mods
9	Mods -> [ ]
10	Mods -> PP Mods
11	PP -> preposition NP
*/

S = [bob, shot, an, elephant, in, his, pyjamas]

/*
https://prnt.sc/ve301q
bob = NP
shot = transitive
an = article
elephant = common
in = preposition
his = adjective
pyjamas = common

Bob shot in his pyjamas an elephant.
Bob shot an elephant in his pyjamas.
*/

NP = [the, little, red, brick, near, a, pink, cube, with, a, blue, pyramid]

/*
https://prnt.sc/ve39ol
the = article
little = adjective
red = adjective

The little red brick near a pink cube with a blue pyramid.
The little red brick with a blue pyramid near a pink cube.
*/