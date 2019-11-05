:- use_module(library(lists)).

abs_dif(A, B, C):-
    C is abs(A - B).

f(X,Y):-Y is X*X.

map([], _, []).
map([H | T], Func, [HCR | TCR]):-
    Pred =..[Func, H, HCR],
    Pred,
    map(T, Func, TCR).

f(1).
f(3).

separa(Lista, Func, L):-
    separa_aux(Lista, Func, LAccept, LRej),
    append(LAccept, LRej, L).


separa_aux([], _, [], []).
separa_aux([H | T1], Func, [H | T2], L):-
    Pred =..[Func, H],
    Pred, !,
    separa_aux(T1, Func, T2, L).
separa_aux([H | T1], Func, L, [H | T2]):-
    separa_aux(T1, Func, L, T2).


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

proximo(Idade, Nome, Dif):-
    idade(Nome, IdAmigo),
    abs_dif(Idade, IdAmigo, Dif).

mais_proximos(Idade, ListaProximos):-
    setof(Dif-N, proximo(Idade, N, Dif), [Alvo-N | Lista]),
    primeiros([Alvo-N | Lista], ListaProximos, Alvo).

primeiros([], [], _).
primeiros([Primeiro-N | T1], [Primeiro-N | T2], Primeiro):- 
    !, primeiros(T1, T2, Primeiro).
primeiros([_-_ | _], [], _).


