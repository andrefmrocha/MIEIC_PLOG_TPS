unificavel([], _, []).

unificavel([H | T1], Termo, L):-
    not(H=Termo),
    !, unificavel(T1, Termo, L).
unificavel([H | T1], Termo, [H | T2]):- 
    unificavel(T1, Termo, T2).