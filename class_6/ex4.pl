:- use_module(library(lists)).

functor2(Termo, Nome, Aridade):-
    Termo=.. [Nome | Tail],
    length(Tail, Aridade).

arg2(Index, Termo, Arg):-
    Termo=..[_ | T],
    nth1(Index, T, Arg).

idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18).


