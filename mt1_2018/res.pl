:-use_module(library(lists)).

%airport(Name, ICAO, Country)
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Pairs-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumcino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('TP5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('TP5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

short(Flight):-
    flight(Flight, _, _, _, Duration, _),
    Duration < 90.


shorter(Flight1, Flight2, Flight1):-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.
shorter(Flight1, Flight2, Flight2):-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 > Duration2.


getTime(Time, Hours, Minutes):-
    Minutes is Time mod 100,
    Hours is Time // 100.

    
arrivalTime(Flight, ArrivalTime):-
    flight(Flight, _, _, DepartureTime, Duration, _),
    getTime(DepartureTime, BegHours, BegMinutes),
    MinutesTime is BegHours * 60 + BegMinutes + Duration,
    Hours is MinutesTime // 60,
    Minutes is MinutesTime mod 60,
    ArrivalTime is Hours * 100 + Minutes.

countriesHelper(Company, Acc, List):-
    flight(_, ID,_, _, _, Company),
    airport(_, ID, Country),
    \+ member(Country, Acc),
    countriesHelper(Company, [Country | Acc], List).
countriesHelper(Company, Acc, List):-
    flight(_, _, ID, _, _, Company),
    airport(_, ID, Country),
    \+ member(Country, Acc),
    countriesHelper(Company, [Country | Acc], List).
countriesHelper(_, List, List).

countries(Company, Countries):-
    countriesHelper(Company, [], Countries).

minustTimes(Time1, Time2, Time):-
    getTime(Time1, Hours1, Minutes1),
    getTime(Time2, Hours2, Minutes2),
    MinutesTime1 is Hours1 * 60 + Minutes1,
    MinutesTime2 is Hours2 * 60 + Minutes2,
    Time is MinutesTime1 - MinutesTime2.

pairableFlight(ArrivalTime, DepartureTime):-
    minustTimes(DepartureTime, ArrivalTime, Diff),
    Diff >= 30,
    Diff =< 90.

pairableFlights:-
    flight(ID1, _, Destination, _, _, _),
    flight(ID2, Destination, _, DepartureTime2, _, _),
    arrivalTime(ID1, T1),
    pairableFlight(T1, DepartureTime2),
    write(Destination), write(' - '),
    write(ID1), write(' \\ '), write(ID2), nl,
    fail.
pairableFlights.

pairableTrip(ArrivalTime, DepartureTime, 0):-
    minustTimes(DepartureTime, ArrivalTime, Diff),
    Diff >= 30.
pairableTrip(ArrivalTime, DepartureTime, 1):-
    minustTimes(DepartureTime, ArrivalTime, Diff),
    Diff < 0.

tripDays([_], _, [], 1).
tripDays([Ori, Dest | T1], Time, [DepartureTime | T2], N):-
    airport(_, OriAirPort, Ori),
    airport(_, DestAirPort, Dest),
    flight(ID1, OriAirPort, DestAirPort, DepartureTime, _, _),
    pairableTrip(Time, DepartureTime, Sum),
    arrivalTime(ID1, ArrivalTime),
    tripDays([Dest | T1], ArrivalTime, T2, NewN),
    N is NewN + Sum.


getTripDuration(Airport, Duration):-
    airport(_, Airport, _),
    flight(_, Airport, _, _, Duration, _).

avgFlightLengthFromAirport(Airport, AvgLength):-
    findall(Duration, getTripDuration(Airport, Duration), Durations),
    sumlist(Durations, Sum),
    length(Durations, L),
    AvgLength is Sum / L.

getCompanyPlaces(Company, Acc,Places):-
    flight(_, From, To, _, _, Company),
    airport(_, From, Country),
    airport(_, To, Country),
    \+member(Country, Acc),!,
    getCompanyPlaces(Company, [Country | Acc], NewPlaces),
    Places is NewPlaces + 1.
getCompanyPlaces(Company, Acc,Places):-
    flight(_, From, To, _, _, Company),
    airport(_, From, FromCountry),
    airport(_, To, ToCountry),
    \+member(FromCountry, Acc),
    \+member(ToCountry, Acc),!,
    getCompanyPlaces(Company, [FromCountry, ToCountry | Acc], NewPlaces),
    Places is NewPlaces + 2.
getCompanyPlaces(Company, Acc,Places):-
    flight(_, From, To, _, _, Company),
    airport(_, From, FromCountry),
    airport(_, To, ToCountry),
    \+member(FromCountry, Acc),
    member(ToCountry, Acc),!,
    getCompanyPlaces(Company, [FromCountry| Acc], NewPlaces),
    Places is NewPlaces + 1.
getCompanyPlaces(Company, Acc,Places):-
    flight(_, From, To, _, _, Company),
    airport(_, From, FromCountry),
    airport(_, To, ToCountry),
    member(FromCountry, Acc),
    \+member(ToCountry, Acc),!,
    getCompanyPlaces(Company, [ToCountry| Acc], NewPlaces),
    Places is NewPlaces + 1.
getCompanyPlaces(_, _, 0):- !.



getPlaces(Places-Company):-
    company(Company, _, _, _),
    getCompanyPlaces(Company, [], Places).


getOtherBest([Best-Company | T1], Best, [Company | T2]):- !, getOtherBest(T1, Best, T2).
getOtherBest(_, _, []):- !.

mostInternational([Company | Other]):-
    setof(Places-Company, getPlaces(Places-Company), List),
    reverse(List, ReversedList),
    [Best-Company| T] = ReversedList,!,
    getOtherBest(T, Best, Other).

make_pairs(L, P, [X-Y | T]):-
    select(X, L, L2),
    select(Y, L2, L3),
    G=..[P, X, Y],
    G, make_pairs(L3, P, T).
make_pairs(L, P, T):-
    select(_, L, L2),
    select(_, L2, L3),
    make_pairs(L3, P, T).

make_pairs([], _, []).

make_pairs_aux(L, P, Length-List):-
    make_pairs(L, P, List),
    length(List, Length).

dif_max_2(X, Y):- X < Y, X >= Y-2.

make_max_pairs(L, P, S):-
    setof(Length-List, make_pairs_aux(L, P, Length-List), List),
    reverse(List, ReversedList),
    [_-S | _] = ReversedList.


validMove(N, CurrX, Y, [X, Y]):-
    X =< CurrX,
    X < N,
    X >= 1.
validMove(N, X, CurrY, [X, Y]):-
    Y =< CurrY,
    Y < N,
    Y >= 1.
validMove(N, CurrX, CurrY, [X, Y]):-
    X =< CurrX,
    X < N,
    X >= 1,
    Y =< CurrY,
    Y < N,
    Y >= 1,
    Diff is CurrX - X,
    Diff is CurrY - Y.
    
getGoals(0, _, _, _):- !, fail.
getGoals(_, 0, _, _):- !, fail.
getGoals(CurrX, CurrY, X, CurrY):-
    X is CurrX - 1,
    X >= 1.
getGoals(CurrX, CurrY, CurrX, Y):-
    Y is CurrY - 1,
    Y >= 1.
getGoals(CurrX, CurrY, X, Y):-
    X is CurrX - 1,
    Y is CurrY - 1,
    X >= 1,
    Y >= 1.
getGoals(CurrX, CurrY, X, Y):-
    NewX is CurrX - 1,
    NewY is CurrY - 1,
    getGoals(NewX, NewY, X, Y).
getGoals(CurrX, CurrY, X, Y):-
    NewY is CurrY - 1,
    getGoals(CurrX, NewY, X, Y).
getGoals(CurrX, CurrY, X, Y):-
    NewX is CurrX - 1,
    getGoals(NewX, CurrY, X, Y).
    

getCoordAndTest(N, CurrX, CurrY, [X, Y]):-
    getGoals(CurrX, CurrY, X, Y),
    validMove(N, CurrX, CurrY, [X, Y]).

findall_helper(N, N, N, []).
findall_helper(N, CurrX, N, FinalMoves):-
    findall([X, Y], getCoordAndTest(N, CurrX, N, [X, Y]), NewMoves),
    NewCurrX is CurrX + 1,
    findall_helper(N, NewCurrX, 1, Moves),
    append(NewMoves, Moves, FinalMoves).
findall_helper(N, CurrX, CurrY, FinalMoves):-
    findall([X, Y], getCoordAndTest(N, CurrX, CurrY, [X, Y]), NewMoves),
    NewCurrY is CurrY + 1,
    findall_helper(N, CurrX, NewCurrY, Moves),
    append(NewMoves, Moves, FinalMoves).
    
findall_second_degree(_, [], []).
findall_second_degree(N, [[CurrX, CurrY] | T1], [NewMoves | T]):-
    findall([X, Y], getCoordAndTest(N, CurrX, CurrY, [X, Y]), NewMoves),
    findall_second_degree(N, T1, T).

check_moves(_, []).
check_moves(N, [[CurrX, CurrY] | T1]):-
    findall([X, Y], getCoordAndTest(N, CurrX, CurrY, [X, Y]), List),
    member([1, 1], List),
    check_moves(N, T1).    
check_moves(_, [[1, 1] | _]):- !, fail.

parse_moves(_, [], [], _).
parse_moves(N, [H | T1], [Index | T], Index):-
    check_moves(N, H),
    NewIndex is Index + 1,
    parse_moves(N, T1, T, NewIndex).
parse_moves(N, [_ | T1], L, Index):-
    NewIndex is Index + 1,
    parse_moves(N, T1, L, NewIndex).

get_moves(_, [], []).
get_moves(FirstDegreeMoves, [H | T1], [(X, Y) | T2]):-
    nth0(H, FirstDegreeMoves, [X, Y]),
    get_moves(FirstDegreeMoves, T1, T2).

get_all_positions(N, N, N, [[N, N]]).
get_all_positions(N, CurrX, N, [[CurrX, N] | T]):-
    NewCurrX is CurrX + 1,
    get_all_positions(N, NewCurrX, 1, T).
get_all_positions(N, CurrX, CurrY, [[CurrX, CurrY] | T]):-
    NewCurrY is CurrY + 1,
    get_all_positions(N, CurrX, NewCurrY, T).

whitoff(N, W):-
    get_all_positions(N, 1, 1, FirstDegreeMoves),
    findall_second_degree(N, FirstDegreeMoves, SecondDegreeMoves),
    parse_moves(N, SecondDegreeMoves, IndexList, 0),
    get_moves(FirstDegreeMoves, IndexList, W).




