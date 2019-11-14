:- use_module(library(lists)).

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