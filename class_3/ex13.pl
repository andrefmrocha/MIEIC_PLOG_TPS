lista_ate(1, [1]).
lista_ate(N, [N | T]):- 
    N1 is N - 1,
    lista_ate(N1, T).

lista_entre(N2, N2, [N2]).
lista_entre(N1, N2, [N1 | T]):-
    N is N1 + 1,
    lista_entre(N, N2, T).

soma_lista([T], T).
soma_lista([H | T], Soma):-
    soma_lista(T, NewSoma),
    Soma is H + NewSoma.

par(N):-
    0 is N mod 2.

lista_pares(2, [2]).
lista_pares(N, [N | T]):- 
    N1 is N - 1,
    par(N),
    lista_pares(N1, T).
lista_pares(N, T):- 
    N1 is N - 1,
    lista_pares(N1, T).

lista_impares(2, [2]).
lista_impares(N, [N | T]):- 
    N1 is N - 1,
    \+ par(N),
    lista_impares(N1, T).
lista_impares(N, T):- 
    N1 is N - 1,
    lista_impares(N1, T).