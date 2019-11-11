slice_helper(_, _, End, N, []):-
    End < N.
slice_helper([H | T1], Start, End, N, [H | T2]):-
    N >= Start,
    N1 is N + 1,
    slice_helper(T1, Start, End, N1, T2).
slice_helper([_ | T1], Start, End, N, T2):-
    N1 is N + 1,
    slice_helper(T1, Start, End, N1, T2).



slice(L, Start, End, R):-
    slice_helper(L, Start, End, 1, R).