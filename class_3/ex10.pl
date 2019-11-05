ordenada([_]).
ordenada([N1, N2]):- N1 =< N2.
ordenada([N1, N2| R]):-
    N1 =< N2,
    ordenada([N2 | R]).

% ordena([], _).
% ordena([H1 | T1], [H2 | T2]):-
%     H1 =< H2,
