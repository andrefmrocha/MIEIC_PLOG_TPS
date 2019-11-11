dropN(L1, N, L2):-
    dropN(L1, N, L2, 1).

dropN([], _, [], _).
dropN([_ | T1], N, L, N):-
    dropN(T1, N, L, 1).
dropN([H | T1], N, [H | T2], X):-
    X1 is X + 1,
    dropN(T1, N, T2, X1).