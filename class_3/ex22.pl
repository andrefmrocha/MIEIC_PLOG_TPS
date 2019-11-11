rodar(L, 0, L).
rodar([H | T1], N, X):-
    N > 0,
    N1 is N - 1,
    rodar(T1, N1, NewX),
    append(NewX, [H], X).