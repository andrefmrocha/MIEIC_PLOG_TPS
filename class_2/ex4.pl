factorial(0, 1).
factorial(N, V):-
    N >= 1,
    N1 is N - 1, factorial(N1, V1),
    V is V1 * N.