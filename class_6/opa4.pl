:- op(200, xfx, existe_em).

X existe_em [X | _].
X existe_em [_ | L]:-
    X existe_em L.