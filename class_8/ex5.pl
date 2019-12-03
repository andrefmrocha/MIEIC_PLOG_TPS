:-use_module(library(lists)).


cars(Sol):-
    Vars = [Yellow, Green, Blue, Black],
    Sizes = [YellowSize, GreenSize, BlueSize, BlackSize],
    domain(Vars, 1, 4),
    domain(Sizes, 1, 4),
    all_distinct(Vars),
    all_distinct(Sizes),
    Smaller #= Blue - 1,
    Bigger #= Blue + 1,
    element(Smaller, Sizes, SmallerSize),
    element(Bigger, Sizes, BiggerSize),
    SmallerSize #< BiggerSize,
    GreenSize #< YellowSize,
    GreenSize #< BlueSize,
    GreenSize #< BlackSize,
    Green #> Blue,
    Yellow #> Black,
    append(Sizes, Vars, Sol),
    labeling([], Sol).