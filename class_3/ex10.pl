ordenada([_]).
ordenada([N1, N2]):- N1 =< N2.
ordenada([N1, N2| R]):-
    N1 =< N2,
    ordenada([N2 | R]).

bubble_sort([N], [N]).
bubble_sort([N1, N2 | R1], [N2| R2]):-
    N1 >= N2,
    bubble_sort([N1 | R1], R2).
bubble_sort([N1, N2 | R1], [N1 | R2]):-
    bubble_sort([N2 | R1], R2).

ordena(L, L):- ordenada(L).
ordena(L1, L2):-
    bubble_sort(L1, NewL),
    ordena(NewL, L2).
