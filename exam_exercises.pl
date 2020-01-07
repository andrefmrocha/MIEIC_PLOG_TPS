:-use_module(library(clpfd)).
:-use_module(library(lists)).

constrain([X, Y]):-
    X #< Y #\/ X #> Y.
constrain([X, Y, Z | T]):-
    (X #< Y #/\ Y #> Z) #\/ (X #> Y #/\ Y #< Z),
    constrain([Y, Z | T]).

ups_and_downs(Min, Max, N, L):-
    length(L, N),
    domain(L, Min, Max),
    constrain(L),
    labeling([], L).


concelho(x, 120, 410).
concelho(y, 10, 800).
concelho(z, 543, 2387).
concelho(w, 3, 38).
concelho(k, 234, 376).

get_dist(_-Dist-_, Dist).
get_elect(_-_-Elect, Elect).

concelhos(NDays, MaxDist, CVs, TotalDist, TotalElect):-
    findall(Name-Dist-NPeople, concelho(Name, Dist, NPeople), Concelhos),
    length(Concelhos, Length),
    length(Taken, Length),
    domain(Taken, 0, 1),
    NumOnes #=< NDays,
    NumZeroes #>= Length - NDays,
    global_cardinality(Taken, [0-NumZeroes, 1-NumOnes]),
    maplist(get_dist, Concelhos, Dists),
    maplist(get_elect, Concelhos, Elects),
    scalar_product(Dists, Taken, #=, TotalDist),
    scalar_product(Elects, Taken, #=, TotalElect),
    TotalDist #=< MaxDist,
    labeling([maximize(TotalElect)], Taken),
    findall(Council, (nth1(Index, Taken, 1), nth1(Index, Concelhos, Council-_-_)), CVs).
