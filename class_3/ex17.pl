palindroma_helper(L, L).
palindroma_helper(L, [_ | L]).
palindroma_helper(L1, [H | T2]):-
    append([H], L1, NewL1),
    palindroma_helper(NewL1, T2).

palindroma(L):-
    palindroma_helper([], L).