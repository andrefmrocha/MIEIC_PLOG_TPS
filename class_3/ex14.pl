primo_helper(_, 1).
primo_helper(N, Div):-
    Division is N mod Div,
    Division \= 0,
    NewDiv is Div - 1,
    primo_helper(N, NewDiv).

primo(N):-
    Div is N - 1,
    primo_helper(N, Div).


lista_primos(1, [1]).
lista_primos(N, [N | T]):-
    N1 is N - 1,
    primo(N),
    lista_primos(N1, T).
lista_primos(N, T):-
    N1 is N - 1,
    lista_primos(N1, T).