unificavel([], _, []).
unificavel([X | T1], Termo, L2):-
    not(X = Termo), !,
    unificavel(T1, Termo, L2).
unificavel([H | T1], Termo, [H | T2]):-
    unificavel(T1, Termo, T2).