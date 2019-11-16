%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').


%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

madeItThroughHelper([]):- fail.
madeItThroughHelper([120 | _]).
madeItThroughHelper([_ | T]):-madeItThroughHelper(T).


madeItThrough(Id):-
    performance(Id, Times),
    !, madeItThroughHelper(Times).

mynth1([H | _], 1, H).
mynth1([_ | T], Index, Elem):-
    NewIndex is Index - 1,
    mynth1(T, NewIndex, Elem).

juriTimes([], _, [], 0).
juriTimes([H | T], JuriMember, [Time | NewTimes], Total):-
    juriTimes(T, JuriMember, NewTimes, NewTotal),
    performance(H, Times),
    mynth1(Times, JuriMember, Time),
    Total is Time + NewTotal.
 

getAllPerformances(JuriMember, Performants, [Time | T]):-
    performance(X, Times),
    \+ member(X, Performants),
    mynth1(Times, JuriMember, Time),
    getAllPerformances(JuriMember, [X | Performants], T).
getAllPerformances(_, _, []).

countPerformances([], 0).
countPerformances([120 | T],  Count):-
    countPerformances(T, NewCount),
    Count is NewCount + 1.
countPerformances([_ | T],  Count):-
    countPerformances(T, Count).

patientJuri(JuriMember):-
    getAllPerformances(JuriMember, [], Times),
    countPerformances(Times, N),
    N >= 2.


countTimes([], 0).
countTimes([H | T], Count):-
    countTimes(T, NewCount),
    Count is NewCount + H.

bestPerformance(P, P, _, _, _):- !, fail.
bestPerformance(CountP1, CountP2, P1, _, P1):-
    CountP1 > CountP2.
bestPerformance(_, _, _, P2, P2).

bestParticipant(P1, P2, P):-
    performance(P1, P1Times),
    performance(P2, P2Times),
    countTimes(P1Times, CountP1),
    countTimes(P2Times, CountP2),
    bestPerformance(CountP1, CountP2, P1, P2, P).


allPerfsHelper(Performants):-
    performance(X, Times),
    \+ member(X, Performants),
    participant(X, _, Performance),
    write(X), write(':'), write(Performance),
    write(':'), write(Times), nl,
    allPerfsHelper([X | Performants]).
allPerfsHelper(_).

allPerfs:-
    allPerfsHelper([]).

checkPerfomances([]).
checkPerfomances([120 | T]):- checkPerfomances(T).

sucessfulPerformance(Participant):-
    performance(Participant, Times),
    !, checkPerfomances(Times).


nSuccessfulParticipants(T):-
    findall(Performant, sucessfulPerformance(Performant), Performants),
    length(Performants, T).

getAllPerformants(L):-
    findall(Performant, performance(Performant, _), L).

likingJuris(_, [],  []).
likingJuris(Index, [120 | T1], [Index | T2]):-
    NewIndex is Index + 1,
    likingJuris(NewIndex, T1, T2).
likingJuris(Index, [_ | T1], List):-
    NewIndex is Index + 1,
    likingJuris(NewIndex, T1, List).

juriFans([], []).
juriFans([H | T1], [H-Juris | T2]):-
    performance(H, Times),
    likingJuris(1, Times, Juris),
    juriFans(T1, T2).

juriFans(L):-
    getAllPerformants(Performants),
    juriFans(Performants, L).


:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).


getNBest(_, 0, []).
getNBest([H | T1], N, [H  | T2]):-
    NewN is N - 1,
    getNBest(T1, NewN, T2).

nextPhase(N, L):-
    setof(Total-ID-Performance, eligibleOutcome(ID, Performance, Total), Participants),
    invert(Participants, NewParticipants),
    getNBest(NewParticipants, N, L).

invert([], []).
invert([H | T], List):-
    invert(T, NewList),
    append(NewList, [H], List).


% Percorre uma lista de participantes, guardando numa lista a performance dos quais a idade é menor ou igual a Q, sendo que guarda tambem uma lista de todos os participantes.

% O cut utilizado força a que nao seja reexplorado qualquer campo de pesquisa que ja tenha sido previamente explorado. A ausencia deste cut levaria a que houvesse uma repetiçao de resultados tanto em R como em P, pelo que é um cut vermelho.

% O predicado verifica a condiçao acima, ou seja, se para um determinado numero (X), existe em L, uma sequencia de X numeros entre X e X.

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

impoeList(0, _).
impoeList(N, L):-
    impoe(N, L),
    N1 is N - 1,
    impoeList(N1, L).

langford(N, L):-
    S is N * 2,
    length(L, S),
    impoeList(N, L).