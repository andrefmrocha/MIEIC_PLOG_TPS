:-use_module(library(clpfd)).
:-use_module(library(lists)).


quadrado_3x3(Board):-
    Board = [A1, A2, A3, A4, A5, A6, A7, A8, A9],
    domain(Board, 1, 9),
    all_distinct(Board),
    A1 + A2 + A3 #= A4 + A5 + A6,
    A7 + A8 + A9 #= A4 + A5 + A6,
    A1 + A4 + A7 #= A2 + A5 + A8,
    A2 + A5 + A8 #= A3 + A6 + A9,
    A1 + A5 + A9 #= A7 + A5 + A3,
    labeling([], Board).

length_list(Size, Board):-
    length(Board, Size).

list_diag1([], []).
list_diag1([[E|_]|Ess], [E|Ds]) :-
    maplist(list_tail, Ess, Ess0),
    list_diag1(Ess0, Ds).

list_tail([_|Es], Es).

list_diag2(Ess,Ds) :-
    maplist(reverse, Ess, Fss),
    list_diag1(Fss, Ds).

domain_list(N1, N2, List):-
    domain(List, N1, N2).

sum_list(Sum, Operador, List):-
    sum(List, Operador, Sum).

flatten([], []).
flatten([H | T], FlattedBoard):-
    flatten(T, NewFlatten),
    append(H, NewFlatten, FlattedBoard).

quadrado(Board, Size):-
    length(Board, Size),
    maplist(length_list(Size), Board),
    flatten(Board, FlattedBoard),
    all_distinct(FlattedBoard),
    Ntimes is Size * Size,
    maplist(domain_list(1, Ntimes), Board),
    Sum is (Ntimes + 1) * 3 // 2,
    maplist(sum_list(Sum, #=), Board),
    transpose(Board, NewBoard),
    maplist(sum_list(Sum, #=), NewBoard),
    list_diag1(Board, Diag1),
    sum_list(Sum, #=, Diag1),
    list_diag2(Board, Diag2),
    sum_list(Sum, #=, Diag2),
    maplist(labeling([]), Board).

