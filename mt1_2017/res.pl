:-dynamic
    played/4.

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge)
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, Hours, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


achievedALot(Player):-
    played(Player, _, _, PercentUnlocked),
    PercentUnlocked >= 80.

isAgeAppropriate(Name, Game):-
    player(Name, _, Age),
    game(Game, _, MinAge),
    MinAge =< Age.

timeSpentIngame(Player, Game, Time):-
    played(Player, Game, Time, _).
timeSpentIngame(_, _, 0).


timePlayingGames(_, [], [], 0).
timePlayingGames(Player, [Game | T1], [Time | T2], SumTimes):-
    timePlayingGames(Player, T1, T2, NewSumTimes),
    timeSpentIngame(Player, Game, Time),
    SumTimes is NewSumTimes + Time.

listGamesOfCategory(Category):-
    game(Name, Categories, MinAge),
    member(Category, Categories),
    write(Name), write(' ('), write(MinAge), write(')'), nl,
    fail.
listGamesOfCategory(_).

updatePlayer(Player, Game, Hours, Percentage):-
    retract(played(Player, Game, CurrentHours, CurrentPercentage)), !,
    NewHours is CurrentHours + Hours,
    NewPercentage is CurrentPercentage + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage):-
    assert(played(Player, Game, Hours, Percentage)).
    

fewHours(Player, AccGames, [Game | T]):-
    played(Player, Game, Hours, _),
    \+ member(Game, AccGames),
    Hours < 10, 
    !, fewHours(Player, [Game | AccGames], T).
fewHours(_, _, []).

fewHours(Player, Games):-
    fewHours(Player, [], Games).

betweenAge(MinAge, MaxAge, Player):-
    player(Player, _, Age),
    MinAge =< Age,
    MaxAge >= Age.

ageRange(MinAge, MaxAge, Players):-
    findall(Player, betweenAge(MinAge, MaxAge, Player), Players).

playerAge(Game, Age):-
    played(Player, Game, _, _),
    player(_, Player, Age).

sumList([], 0).
sumList([H | T], Sum):-
    sumList(T, NewSum),
    Sum is NewSum + H.

averageAge(Game, Avg):-
    findall(Age, playerAge(Game, Age), Ages),
    sumList(Ages, Sum),
    length(Ages, Num),
    Avg is Sum / Num.

getRatio(Game, Ratio, Player):-
    played(Player, Game, Hours, Percentage),
    Ratio is Percentage/Hours.

reverse([], []).
reverse([H | T], ReversedList):-
    reverse(T, NewReversedList),
    append(NewReversedList, [H], ReversedList).

getOtherTopPlayers(BestRatio, [BestRatio-Player | T1], [Player | T2]):-
    getOtherTopPlayers(BestRatio, T1, T2).
getOtherTopPlayers(_, _, []).

mostEffectivePlayers(Game, [BestPlayer | OtherPlayersList]):-
    setof(Ratio-Player, getRatio(Game, Ratio, Player), ReversedPlayers),
    reverse(ReversedPlayers, RatioPlayers),
    [BestRatio-BestPlayer | OtherPlayers] = RatioPlayers,
    getOtherTopPlayers(BestRatio, OtherPlayers, OtherPlayersList).

% Verifica se o jogador nao esta  a jogar nenhum jogo que não lhe seja adequado em termos de idade.
% O cut é verde uma vez que este irá apenas impedir a procura de novos jogador na base de factos com o mesmo username.

% Nome mais adequado - playingAppropriateGames
% X - Username
% Y - PlayerName
% Z - PlayerAge
% G - Game
% L - _
% M - _
% N - _,
% W - MinAge

% Guardando a matriz triangular inferior
matrix([[8], [8, 2], [7, 4, 3], [7, 4, 3, 1]]).

calculateIndex(1, Y, 1/NewY):-
    NewY is Y + 1.
% calculateIndex(X, Y, X/NewY):-
%     Y >= X,
%     NewY is Y + 1.
calculateIndex(X, Y, X/Y).
    

areClose(_, [], _, _, []).
areClose(MaxDist, [H | T1], X, Y, [Index | T2]):-
    H =< MaxDist,
    calculateIndex(X, Y, Index),
    NewY is Y + 1,
    areClose(MaxDist, T1, X, NewY, T2).
areClose(MaxDist, [_ | T1], X, Y, List):-
    NewY is Y + 1,
    areClose(MaxDist, T1, X, NewY, List).

areClose(_, [], _, []).
areClose(MaxDist, [H | T], X, FinalPares):-
    areClose(MaxDist, H, X, 1, NewPares),
    NewX is X + 1,
    areClose(MaxDist, T, NewX, Pares),
    append(NewPares, Pares, FinalPares).
    
areClose(MaxDist, MatDist, Pares):-
    areClose(MaxDist, MatDist, 2, Pares).

areClose(MaxDist, P):-
    matrix(X),
    areClose(MaxDist, X, P).


% A melhor forma de codificar esta seria atraves de cada no ser representado atraves da estrutura [ID, leftTree, RightTree]

% [1, [2, [5, [7, [8, australia, [9, [10, stahelena, anguila], georgiadosul]], uk], [6, servia, franca]], [3, [4, niger, india], irlanda]], brasil]

