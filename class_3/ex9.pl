substitui(_, _, [], []).

substitui(X, Y, [X | T1], [Y | T2]):-
    substitui(X, Y, T1 , T2).

substitui(X, Y, [H | T1], [H | T2]):-
    X \= H,
    substitui(X, Y, T1, T2).

skips(_, [], []).
skips(X, [H | T1], [_ | T2]):-
    X \= H, 
    skips(X, T1, T2).

skips(X, [X | T1], [X | T2]):-
    skips(X, T1, T2).

elimina_duplicados([], _).
elimina_duplicados([H | T], L2):-
