check_availability(Day, [disp(Begin, End) | _]):-
    Day >= Begin, Day =< End.
check_availability(Day, [_ | T]):-
    check_availability(Day, T).



is_available(Day, Name):-
    disponibilidade(Name, Availability),
    check_availability(Day, Availability).

available_people(Day, Names):-
    findall(Name, is_available(Day, Name), Names).

% available_dates()