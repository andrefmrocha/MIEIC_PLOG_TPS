% 1 -> Amarelo
% 2 -> Verde
% 3 -> Vermelho
% 4 -> Azul

distinct([_, _ | []]).
distinct([H1, H2, H3 | T]):-
    all_distinct([H1, H2, H3]),
    distinct([H2, H3 | T]).

sequence([_, _, _ | []], 0).
sequence([H1, H2, H3, H4 | T], Count):-
    (H1 #= 1 #/\ H2 #= 2 #/\ H3 #= 3 #/\ H4 #= 4) #<=> Reif,
    sequence([H2, H3, H4 | T], NewCount),
    Count #= NewCount + Reif.

cars2(Sol):-
    Vars = [P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12],
    domain(Vars, 1, 4),
    global_cardinality(Vars, [1-4, 2-2, 3-3, 4-3]),
    P5 #= 4,
    P1 #= P12,
    P2 #= P11,
    distinct(Vars),
    sequence(Vars, Count),
    Count #= 1,
    labeling([], Vars),
    Sol = Vars.


