:-use_module(library(random)).
nth1([Elem | _], Elem, 1).
nth1([_ | T], Elem, Index):-
    NewIndex is Index - 1,
    nth1(T, Elem, NewIndex).

rnd_selectN(_, 0, []).
rnd_selectN(L, N, [Elem | T]):-
    length(L, Length),
    random_between(1, Length, Index),
    nth1(L, Elem, Index),
    N1 is N - 1,
    rnd_selectN(L, N1, T).

rnd_select(0, _, []).
rnd_select(N, Upper, [Elem | T]):-
    random_between(1, Upper, Elem),
    N1 is N - 1,
    rnd_select(N1, Upper, T).
