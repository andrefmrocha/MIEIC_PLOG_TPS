:- ensure_loaded('ex18.pl'). 

runlength_helper([H | T], [N, H], L):-
    N1 is N + 1,
    runlength_helper(T, [N1, H], L).
runlength_helper([H | T], X, [X | L]):-
    runlength_helper(T, [1, H], L).
runlength_helper([], Enc, [Enc]).

runlength([H | T], X):-
    runlength_helper(T, [1, H], X).    

runlength_modificado_helper([H | T], [N, H], L):-
    N1 is N + 1,
    runlength_modificado_helper(T, [N1, H], L).
runlength_modificado_helper([H | T], [1, X], [X | L]):-
    runlength_modificado_helper(T, [1, H], L).
runlength_modificado_helper([H | T], X, [X | L]):-
    runlength_modificado_helper(T, [1, H], L).
runlength_modificado_helper([], Enc, [Enc]).

runlength_modificado([H | T], X):-
    runlength_modificado_helper(T, [1, H], X).    

decode([], []).
decode([[N, Elem] | T1], L):-
    getNElements(N, Elem, X),
    decode(T1, L1),
    append(X, L1, L).
decode([Elem | T1], [Elem | L]):-
    decode(T1, L).
