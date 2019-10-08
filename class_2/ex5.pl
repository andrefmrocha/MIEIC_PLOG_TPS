e_primo(N):- e_primo(N, 2).


e_primo(N, Div):-
    Div < N,
    N mod Div =\= 0,
    Div1 is Div + 1,
    e_primo(N, Div1).
    
e_primo(N, N).