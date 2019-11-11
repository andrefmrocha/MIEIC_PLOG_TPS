duplicar([],  []).
duplicar([H | T1], [H, H | T2]):-
    duplicar(T1, T2).

getNElements(0,  _, []).
getNElements(N,  Elem, [Elem | T1]):-
    N1 is N - 1,
    getNElements(N1, Elem, T1).

duplicarN([], _, []).
duplicarN([H | T1], N, X):-
    duplicarN(T1, N, NewX),
    getNElements(N, H, ElemList),
    append(ElemList, NewX, X).
