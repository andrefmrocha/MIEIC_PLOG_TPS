puzzle(Var):-
    Var = [S, E, N, D, M, O, R, Y],
    domain(Var, 0, 9),
    S #\= 0,
    M #\= 0,
    all_distinct(Var),
    (D + E) mod 10 #= Y,
    (D + E) // 10 + ((N + R) mod 10) #=E,
    (N + R) // 10 + ((E + O) mod 10) #=N,
    (E + O) // 10 + ((S + M) mod 10) #=O,
    (S + M) // 10 #=M,
    labeling([], Var).

% 4 + 5 + 3 