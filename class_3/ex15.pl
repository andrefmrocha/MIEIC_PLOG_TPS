produto_interno([], [], 0).
produto_interno([H1 | T1], [H2 | T2], N):-
    produto_interno(T1, T2, N1),
    N is N1 + (H1 * H2).