achata_lista([], []).
achata_lista(X, [X]):- atomic(X).
achata_lista([H | T], L):-
    achata_lista(H, L1),
    achata_lista(T, L2),
    append(L1, L2, L).
