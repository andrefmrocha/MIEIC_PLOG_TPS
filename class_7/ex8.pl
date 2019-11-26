puto(Foods):-
    Foods = [Rice, Potatoes, Spaghetti, Tuna],
    domain(Foods, 0, 1000),
    sum(Foods, #=, 711),
    Rice * Potatoes * Spaghetti * Tuna #= 711000000,
    Potatoes #> Tuna,
    Tuna #> Rice,
    Rice #> Spaghetti,
    (Rice mod 10 #= 0) #<=> BRice,
    (Tuna mod 10 #= 0) #<=> BTuna,
    (Spaghetti mod 10 #= 0) #<=> BSpaghetti,
    (Potatoes mod 10 #= 0) #<=> BPotatoes,
    BRice + BTuna + BSpaghetti + BPotatoes #= 2,
    labeling([], Foods).