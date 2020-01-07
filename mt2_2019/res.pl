% Paridade diferente
:-use_module(library(clpfd)).
:-use_module(library(lists)).


constroi_bins(_, [], []).
constroi_bins(I, [H | T], [LBinH | LBinT]):-
    H #= I #<=> LBinH,
    constroi_bins(I, T, LBinT).


% Lista de indices que indicam o compartimento em que o objeto deve ficar de domínio 1-N, onde N é o numero de compartimentos do armário.


make_task(_-Volume, task(0, 1, 1, Volume, Machine), Machine).

make_machines(_, [], []).
make_machines(Id, [Volume | T1], [ machine(Id, Volume) | T2]):-
    NewId is Id + 1,
    make_machines(NewId, T1, T2).

weight(Weight-_, Weight).

get_all_elements(_, [], [], 0).
get_all_elements(Drawer, [Weight | T1], [DrawerNum | T2], Total):-
    (Drawer #= DrawerNum) #<=> Reif,
    Total #= Reif * Weight + NextTotal, !,
    get_all_elements(Drawer, T1, T2, NextTotal).
get_weights(0, _, _, []).
get_weights(NDrawers, ObjectWeights, Vars, [NewWeight | T]):-
    get_all_elements(NDrawers, ObjectWeights, Vars, NewWeight),
    NewN is NDrawers - 1,
    get_weights(NewN, ObjectWeights, Vars, T).

constraint_weights(DrawerNum, _, DrawerNum, _).
constraint_weights(NDrawer, Weights, DrawerNum, Width):-
    element(NDrawer, Weights, AboveWeight),
    StepBelow is NDrawer + Width,
    element(StepBelow, Weights, BelowWeight),
    BelowWeight #< AboveWeight,
    NewN is NDrawer + 1,
    constraint_weights(NewN, Weights, DrawerNum, Width).

prat([PH | PT], Objetos, Vars):-
    length(PH, Width),
    length([PH | PT], Height),
    maplist(make_task, Objetos, Tasks, Vars),
    append([PH | PT], FlattenedDrawers),
    make_machines(1, FlattenedDrawers, Machines),
    NDrawers is Width * Height,
    maplist(weight, Objetos, ObjectWeights),
    get_weights(NDrawers, ObjectWeights, Vars, Weights),
    DrawerNum is NDrawers - Width + 1,
    domain(Vars, 1, NDrawers),
    cumulatives(Tasks, Machines, [bound(upper)]),
    constraint_weights(1, Weights, DrawerNum, Width),
    labeling([], Vars).


objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 3, 15).
homens(4).
tempo_max(60).


create_tasks(_, [], [], [], []).
create_tasks(ID, [CurrStartTime | RestStartTimes], [CurrEndTime | RestEndTimes], [_-People-Duration | RestObjects], [task(CurrStartTime, Duration, CurrEndTime, People, ID) | RestTasks]) :-
    NextID is ID+1,
    create_tasks(NextID, RestStartTimes, RestEndTimes, RestObjects, RestTasks).


furniture:-
    homens(NMen),
    tempo_max(MaxTime),
    findall(Name-People-Duration, objeto(Name, People, Duration), Objects),
    length(Objects, Length),
    length(Ss, Length),
    length(Es, Length),
    domain(Ss, 0, MaxTime),
    domain(Es, 0, MaxTime),
    make_tasks(1, Ss, Es, Objects, Tasks),
    maximum(Time, Es),
    Time #=< MaxTime,
    cumulative(Tasks, [limit(NMen)]),
    labeling([minimize(Time)], Ss),
    write(Time), nl,
    write(Es).

