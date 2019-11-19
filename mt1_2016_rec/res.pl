:-dynamic
    vote/2,
    filmUserVotes/2.

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

normal(Movie):-
    film(Movie, _, Dur, _),
    Dur > 60,
    Dur < 120.


raro(Movie):-
    \+normal(Movie).

sumRatings([_-Rating], Rating).
sumRatings([_-Rating | T], Sum):-
    sumRatings(T, NewSum),
    Sum is Rating + NewSum.

happierGuy(User1, User2, User1):-
    vote(User1, Ratings1),
    vote(User2, Ratings2),
    sumRatings(Ratings1, SumRatings1),
    length(Ratings1, L1),
    AvgRating1 is SumRatings1 / L1,
    sumRatings(Ratings2, SumRatings2),
    length(Ratings2, L2),
    AvgRating2 is SumRatings2 / L2,
    AvgRating1 > AvgRating2, !.

happierGuy(_, User2, User2).

checkRating(_, []).
checkRating(Rating, [_-H | T]):-
    Rating > H,
    checkRating(Rating, T).

checkAllRatings([], _).
checkAllRatings([_-Rating | T], Ratings2):-
    checkRating(Rating, Ratings2),
    checkAllRatings(T, Ratings2).

likedBetter(User1, User2):-
    vote(User1, Ratings1),
    vote(User2, Ratings2),
    checkAllRatings(Ratings1, Ratings2).


checkifRecomendable([], _).
checkifRecomendable([Movie-_| T], Ratings2):-
    member(Movie-_, Ratings2),
    checkifRecomendable(T, Ratings2).

findFirst([Movie-_ | T], Ratings2, NotFound):-
    member(Movie-_, Ratings2),!,
    findFirst(T, Ratings2, NotFound).

findFirst([Movie-_ | _], _, Movie).

recommends(User, Movie):-
    vote(User, Ratings1),
    vote(_, Ratings2),
    checkifRecomendable(Ratings1, Ratings2),
    !, findFirst(Ratings2, Ratings1, Movie).


getPredArgs(Pred, Args):-
    Func=..[Pred | Args],
    Func.

reverse([], []).
reverse([H | T], ReversedList):-
    reverse(T, NewReversedList),
    append(NewReversedList, [H], ReversedList).

generateArgumentList(0, []).
generateArgumentList(Arity, [_ | T]):-
    NewArity is Arity - 1,
    generateArgumentList(NewArity, T).

removePreds(_, []).
removePreds(Pred, [H | T]):-
    Func=..[Pred | H],
    retract(Func),
    removePreds(Pred, T).

addPreds(_, []).
addPreds(Pred, [H | T]):-
    Func=..[Pred | H],
    assert(Func),
    addPreds(Pred, T).


invert(Pred, Arity):-
    generateArgumentList(Arity, Arguments),
    findall(Arguments, getPredArgs(Pred, Arguments), List),!,
    removePreds(Pred, List),
    reverse(List, ReversedList),
    addPreds(Pred, ReversedList).

getDifference([], _, []).
getDifference([Movie-_ | T1], Ratings2, [Movie | T2]):-
    \+member(Movie-_, Ratings2),!,
    getDifference(T1, Ratings2, T2).
getDifference([_| T1], Ratings2,  T2):-
    getDifference(T1, Ratings2, T2).


onlyOne(User1, User2, OnlyOneList):-
    vote(User1, Ratings1),
    vote(User2, Ratings2),
    getDifference(Ratings1, Ratings2, L1),
    getDifference(Ratings2, Ratings1, L2),
    append(L1, L2, OnlyOneList).

getUserVotes(Film, User-Vote):-
    vote(User, Ratings),
    member(Film-Vote, Ratings).


filmVoting([]).
filmVoting([Film | T]):-
    findall(Votes, getUserVotes(Film, Votes), VotesList),
    assert(filmUserVotes(Film, VotesList)),
    filmVoting(T).


filmVoting:-
    findall(Film, film(Film, _, _, _), Films),
    filmVoting(Films).


readPred(_, []).
readPred(Pred, [H | T]):-
    Func=..[Pred | H],
    write(Func), write('.'), nl,
    readPred(Pred, T).

dumpDatabase(FileName):-
    generateArgumentList(2, VoteArguments),
    generateArgumentList(3, UserArguments),
    generateArgumentList(4, FilmArguments),
    findall(VoteArguments, getPredArgs(vote, VoteArguments), VoteList),!,
    findall(FilmArguments, getPredArgs(film, FilmArguments), FilmList),!,
    findall(UserArguments, getPredArgs(user, UserArguments), UserList),!,
    tell(FileName),
    readPred(vote, VoteList),
    readPred(film, FilmList),
    readPred(user, UserList),
    told.
