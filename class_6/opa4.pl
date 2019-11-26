:- op(200, xfx, existe_em).
:- op(200, fx, concatena).
:- op(150, xfx, da).
:- op(100, xfx, e).
:- op(200, fx, apaga).
:- op(200, xfx, de).

X existe_em L:-
    member(X, L).

concatena [] e L da L. 
concatena [X | L1] e L2 da [X | L3]:-
    concatena L1 e L2 da L3.

apaga X a [X|L] da L.
apaga X a [Y|L] da [Y|L1] :-
 apaga X a L da L1. 

