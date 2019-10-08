membro(X, [X | Y]).
membro(X, [_| Xs]):-membro(X, Xs).


membro2(X, L):- append(_, [X | _], L).

last(L, X):- append(_, [X], L).

% x - element, L - list, N - position
nthElement(X, [X | _], 1).
nthElement(X, [_ | T], N):-
    N > 1,
    N1 is N-1,
    nthElement(X, T, N1).