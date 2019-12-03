:-use_module(library(clpfd)).

count_equals(_, [], 0).
count_equals(Val, [H | T], Count):-
    count_equals(Val, T, NewCount),
    Val #= H #<=> IsVal,
    Count #= NewCount + IsVal. 