roast_turkeys(Value):-
    Vars = [F, L],
    F in 1..9,
    L in 0..9,
    (F * 1000 + 670 + L) mod 72 #= 0,
    labeling([], Vars),
    Value is (F * 1000 + 670 + L) / 72.

