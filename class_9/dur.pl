:-use_module(library(clpfd)).
:-use_module(library(lists)).

dur(Starts):-
    Starts = [S1, S2, S3, S4, S5, S6, S7],
    Ends = [E1, E2, E3, E4, E5, E6, E7],
    Tasks = [
        task(S1, 16, E1, 2, t1),
        task(S2, 6, E2, 9, t2),
        task(S3, 13, E3, 3, t3),
        task(S4, 7, E4, 7, t4),
        task(S5, 5, E5, 10, t5),
        task(S6, 18, E6, 1, t6),
        task(S7, 4, E7, 11, t7)
    ],
    domain(Starts, 1, 30),
    maximum(End, Ends),
    cumulative(Tasks, [limit(13)]),
    labeling([minimize(End)], Starts).
