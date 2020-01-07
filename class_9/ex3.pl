task(1, 1, 2, 1).
task(2, 3, 5, 4).
task(3, -10, 1, -11).

get_people(Id, People):- task(Id, People, _, _).
get_time(Id, Time):- task(Id, _, Time, _).
get_suffering(Id, Suffering):- task(Id, _, _, Suffering).

plan(N, Plan):-
    length(Plan, N),
    domain(Plan, 1, 3),
    maplist(get_people, Plan, People),
    maplist(get_time, Plan, Times),
    maplist(get_suffering, Plan, Sufferings),
    sum(People, #=, TotalPeople),
    sum(Times, #=, TotalTime),
    sum(Sufferings, #=, TotalSuffering),
    TotalPeople #>= 5, TotalPeople #=< 6,
    TotalTime #=< 10, 
    labeling([minimize(TotalSuffering)], Plan).