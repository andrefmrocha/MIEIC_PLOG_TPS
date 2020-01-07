distance([_], 0).
distance([H1, H2 | T], Sum):-
    distance([H2 | T], NewSum),
    Sum #= abs(H2 - H1) + NewSum.

mailman(Sol):-
    length(Sol, 10),
    element(10, Sol, 6),
    domain(Sol, 1, 10),
    all_distinct(Sol),
    distance(Sol, Sum),
    labeling([maximize(Sum)], Sol).