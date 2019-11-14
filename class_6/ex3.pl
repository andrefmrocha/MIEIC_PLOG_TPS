proximo(Idade, Nome, Dif):-
    idade(Nome, IdAmigo),
    abs_dif(Idade, IdAmigo, Dif).

mais_proximos(Idade, ListaProximos):-
    setof(Dif-N, proximo(Idade, N, Dif), [Alvo-N | Lista]),
    primeiros([Alvo-N | Lista], ListaProximos, Alvo).

primeiros([], [], _).
primeiros([Primeiro-N | T1], [Primeiro-N | T2], Primeiro):- 
    !, primeiros(T1, T2, Primeiro).
primeiros([_-_ | _], [], _).
primeiros([_-_ | _], [], _).