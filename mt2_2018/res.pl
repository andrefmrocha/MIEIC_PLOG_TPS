% O programa em cause gera duas listas L1 e L2 de tamanho N e N - 1 respetivamente e preenche-a com
% valores entre [1, M] de modo a que a cada elemento de L2 corresponda à soma de cada par de elementos
% de L1.

:-use_module(library(clpfd)).
:-use_module(library(lists)).

check([_], []).
check([A, B | T], [X | Xs]):-
    A + B #= X,
    check([B | T], Xs).

prog2(N, M, L1, L2):-
    length(L1, N),
    N1 is N - 1, length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    all_distinct(L1),
    check(L1, L2),
    append(L1, L2, L),
    labeling([], L).

pairing(_, _, _, [], 0).
pairing(MenHeights, WomenHeights, Delta, [ManIndex-WomanIndex | T], N):-
    element(ManIndex, MenHeights, ManHeight),
    element(WomanIndex, WomenHeights, WomanHeight),
    ManHeight #>= WomanHeight,
    abs(ManHeight - WomanHeight) #< Delta,
    N1 is N - 1,
    pairing(MenHeights, WomenHeights, Delta, T, N1).

man_pair(X-_, X).
woman_pair(_-X, X).

sort([_]).
sort([M1-_, M2-W2 | T]):-
    M1 #< M2,
    sort([M2-W2 | T]).

gym_pairs(MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, Length),
    length(WomenHeights, Length),
    pairing(MenHeights, WomenHeights, Delta, Pairs, Length),
    sort(Pairs),
    maplist(man_pair, Pairs, MenPairs),
    maplist(woman_pair, Pairs, WomenPairs),
    all_distinct(MenPairs),
    all_distinct(WomenPairs),
    append(MenPairs, WomenPairs, DestructuredPairs),
    labeling([], DestructuredPairs).

smallest_length(MLength, WLength, MLength):-
    MLength #=< WLength.
smallest_length(MLength, WLength, WLength):-
    MLength #>= WLength.

    
pairing(_, _, _, [], N, N, N).
pairing(MenHeights, WomenHeights, Delta, [ManIndex-WomanIndex | T], N, CurrentN, MaxN):-
    N #>= CurrentN,
    element(ManIndex, MenHeights, ManHeight),
    element(WomanIndex, WomenHeights, WomanHeight),
    ManHeight #>= WomanHeight,
    abs(ManHeight - WomanHeight) #< Delta,
    NewN #= CurrentN + 1,
    pairing(MenHeights, WomenHeights, Delta, T, N, NewN, MaxN).
pairing(_, _, _, [], N, Current, Current):-
    N #>= Current.

% Different pairing but same number of pairs?

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, MLength),
    length(WomenHeights, WLength),
    smallest_length(MLength, WLength, Length),
    pairing(MenHeights, WomenHeights, Delta, Pairs, Length, 0, MaxN),
    % sort(Pairs),
    maplist(man_pair, Pairs, MenPairs),
    maplist(woman_pair, Pairs, WomenPairs),
    all_distinct(MenPairs),
    all_distinct(WomenPairs),
    append(MenPairs, WomenPairs, DestructuredPairs),
    labeling([maximize(MaxN)], DestructuredPairs).
