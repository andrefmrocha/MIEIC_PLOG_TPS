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

madeItThrough(Id):-
    performance(Id, L),
    madeItHelper(L).

madeItHelper([]):- !, fail.
madeItHelper([120 | _]).

madeItHelper([_ | T]):-
    !,madeItHelper(T).

% juriTimes(+Participants, +JuriMember, -Times, -Total)

juriTimes(L, JuriMember, Times, Total):- 
    juriHelper(L, JuriMember, [], 0, L, NewTotal),
    Times = L,
    Total = NewTotal.

juriHelper([], _, Times, Total, Times, Total).
juriHelper([H | T], JuriMember, Times, Total, AccTimes, AccTotal):-
    performance(H, PTimes),
    nth1(JuriMember, PTimes, CurrentTime),
    append(Times, [CurrentTime], NewTime),
    NewTotal is Total + CurrentTime,
    juriHelper(T, JuriMember, NewTime, NewTotal, AccTimes, AccTotal).