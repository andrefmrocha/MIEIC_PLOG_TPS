% L1 - origem, L2 - destino
delete_one(X, La, Lb):-
     append(Ll, [X | Lu], La),
     append(Ll, Lu, Lb).

delete_all(X, L1, L1):-
    \+ member(X, L1).

delete_all(X, L1, L2):-
    member(X, L1),
    delete_one(X, L1, L3),
    delete_all(X, L3, L2).