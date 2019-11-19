:-dynamic
    film/4.
:-use_module(library(lists)).

film('Doctor Strange',[action,adventure,fantasy],115,7.6).
film('Hacksaw Ridge',[biography,drama,romance],131,8.7).
film('Inferno',[action,adventure,crime],121,6.4).
film('Arrival',[drama,mystery, scifi],116,8.5).
film('The Accountant',[action,crime,drama],127,7.6).
film('The Girl on the Train',[drama,mystery,thriller],112,6.7).

user(john,1992,'USA').
user(jack,1989,'UK').
user(peter,1983,'Portugal').
user(harry,1993,'USA').
user(richard,1982,'USA').

vote(john,['Inferno'-7,'Doctor Strange'-9,'The Accountant'-6]).
vote(jack,['Inferno'-8,'Doctor Strange'-8,'The Accountant'-7]).
vote(peter,['The Accountant'-4,'Hacksaw Ridge'-7,'The Girl on the Train'-3]).
vote(harry,['Inferno'-7,'The Accountant'-6]).
vote(richard,['Inferno'-10,'Hacksaw Ridge'-10,'Arrival'-9]).

curto(Movie):-
    film(Movie, _, Duration, _),
    Duration < 125.

diff(P1, P2, Diff, Movie):-
    vote(P1, Movies1),
    vote(P2, Movies2),
    member(Movie-Class1, Movies1),
    member(Movie-Class2, Movies2),
    Diff is abs(Class1 - Class2).

isGoodMovie(Class, 1):-
    Class >= 8.
isGoodMovie(_, 0).

isNiceGuy([], _):- !, fail.
isNiceGuy(_, 2).
isNiceGuy([_-Class | T], Count):-
    isGoodMovie(Class, Value),
    NewCount is Count + Value,
    isNiceGuy(T, NewCount).


niceGuy(Guy):-
    vote(Guy, Movies),
    isNiceGuy(Movies, 0).

elemsComuns([], [], _).
elemsComuns([H | T1], [H | T2] , L2):-
    member(H, L2), !,
    elemsComuns(T1, T2, L2).
elemsComuns([_ | T1], Common , L2):-
    elemsComuns(T1, Common, L2).

printCategory(Category):-
    film(Movie, Categories, Duration, Rating),
    member(Category, Categories),
    write(Movie), write(' ('), write(Duration),
    write('min, '), write(Rating), write('/10)'), nl,
    fail.

printCategory(_).


similarity(Movie1, Movie2, Score):-
    film(Movie1, Cats1, Dur1, Rat1),
    film(Movie2, Cats2, Dur2, Rat2),
    elemsComuns(Cats1, Common, Cats2),
    length(Common, NCommon),
    length(Cats1, NCats1),
    length(Cats2, NCats2),
    PercentCommonCat is NCommon/(NCats1 + NCats2 - NCommon),
    DurDiff is abs(Dur1 - Dur2),
    RatDiff is abs(Rat1 - Rat2),
    Score is PercentCommonCat * 100 - 3 * DurDiff - 5 * RatDiff.


fittingSimilarity(Film, Film2, Ratio):-
    similarity(Film, Film2, Ratio),
    Film \= Film2,
    Ratio > 10.

getOtherFilms(_, [], []):- !.
getOtherFilms(Best, [Best-Film | T1], [Film | T2]):-
    !,
    getOtherFilms(Best, T1, T2).
getOtherFilms(_, _, []):- !.

mostSimilar(Film, 0, []):-
    findall(Ratio-Film2, fittingSimilarity(Film, Film2, Ratio), []).


mostSimilar(Film, Similarity, [BestMovie | OtherFilms]):-
    setof(Ratio-Film2, fittingSimilarity(Film, Film2, Ratio), Films),
    [Similarity-BestMovie | T] = Films,
    getOtherFilms(Similarity, T, OtherFilms).


countryDiff(Country, Country, 0):- !.
countryDiff(_, _, 2).

avgDiff([], _, 0, 0).
avgDiff([Movie-Rating1 | T], Movies2, Sum, N):-
    member(Movie-Rating2, Movies2),
    Value is abs(Rating1 - Rating2),
    avgDiff(T, Movies2, NewSum, NewN),
    Sum is NewSum + Value,
    N is NewN + 1.
avgDiff([_ | T], Movies2, Sum, N):-
    avgDiff(T, Movies2, Sum, N).


distancia(User1, Distancia, User2):-
    user(User1, Year1, Country1),
    user(User2, Year2, Country2),
    vote(User1, Movies1),
    vote(User2, Movies2),
    avgDiff(Movies1, Movies2, Sum, N),
    AgeDiff is abs(Year1 - Year2),
    AvgDiff is Sum / N,!,
    countryDiff(Country1, Country2, CountryDiff),
    Distancia is AvgDiff + AgeDiff/3 + CountryDiff.


getRating(Film, Rating):-
    vote(_, Ratings),
    member(Film-Rating, Ratings).

sum([], 0).
sum([H | T], Sum):-
    sum(T, NewSum),
    Sum is NewSum + H.

update(Film):-
    retract(film(Film, Categories, Dur, _)),
    findall(Rating, getRating(Film, Rating), Ratings),
    sum(Ratings, Sum),
    length(Ratings, L),
    NewRating is Sum / L,
    assert(film(Film, Categories, Dur, NewRating)).

% O predicado definido calcula as ratings medias para um determinado utilizador
% avgRating
% U - User
% A - AvgRating
% VL - MovieRatingList
% Vs - RatingList
% S - Sum
% L - Length

getCoords(CurrX, CurrY, X, Y):-
    X is CurrX - 2,
    Y is CurrY - 1.
getCoords(CurrX, CurrY, X, Y):-
    X is CurrX - 2,
    Y is CurrY + 1.
getCoords(CurrX, CurrY, X, Y):-
    X is CurrX + 2,
    Y is CurrY - 1.
getCoords(CurrX, CurrY, X, Y):-
    X is CurrX + 2,
    Y is CurrY + 1.
getCoords(CurrX, CurrY, X, Y):-
    Y is CurrY - 2,
    X is CurrX - 1.
getCoords(CurrX, CurrY, X, Y):-
    Y is CurrY - 2,
    X is CurrX + 1.
getCoords(CurrX, CurrY, X, Y):-
    Y is CurrY + 2,
    X is CurrX - 1.
getCoords(CurrX, CurrY, X, Y):-
    Y is CurrY + 2,
    X is CurrX + 1.

validMove(X/Y):-
    X >= 1,
    X =< 8,
    Y >= 1,
    Y =< 8.

getMove(CurrX/CurrY, X/Y):-
    getCoords(CurrX, CurrY, X, Y),
    validMove(X/Y).

move(Coords, Celulas):-
    findall(X/Y, getMove(Coords, X/Y), Celulas).

singleList([], []).
singleList([H | T], List):-
    singleList(T, NewList),
    append(H, NewList, List).

podeMoverEmNHelper(1, Coords, Celulas):- 
    move(Coords, Celulas).
podeMoverEmNHelper(N, Coords, Celulas):-
    move(Coords, Moves),
    NewN is N - 1,
    maplist(podeMoverEmNHelper(NewN), Moves, NestedCells),
    singleList(NestedCells, Celulas).


podeMoverEmN(Coords, N, Celulas):-
    podeMoverEmNHelper(N, Coords, Cells),!,
    sort(Cells, Celulas).


minJogadasHelper(BegCoords, EndCoords, N, N):-
    podeMoverEmN(BegCoords, N, Cells),
    member(EndCoords, Cells).
minJogadasHelper(BegCoords, EndCoords, Acc, N):-
    NewAcc is Acc + 1,
    minJogadasHelper(BegCoords, EndCoords, NewAcc, N).

minJogadas(BegCoords, EndCoords, N):-
    minJogadasHelper(BegCoords, EndCoords, 1, N), !.
