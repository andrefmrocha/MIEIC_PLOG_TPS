% 1 - ping-pong
% 2 - futebol
% 3 - andebol
% 4 - rugby
% 5 - tenis
% 6 - voleibol


sports(Var):-
    Var = [Claudio, David, Domingos, Francisco, Marcelo, Paulo],
    domain(Var, 1, 6),
    all_distinct(Var),
    David #= 5,
    Marcelo #= 2,
    Francisco #\= 6,
    Paulo #\= 6,
    Domingos #\= 4,
    Claudio #\= 4,
    Francisco #\= 4,
    element(Person, Var, 3),
    Person #\= 4,
    labeling([], Var).
    