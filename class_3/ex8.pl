conta([], 0).
conta([_ | T], A):-
    A > 0,
    A1 is A-1,
    conta(T, A1).


conta_elem(X, [], 0).
conta_elem(X, [X | T], A):-
    A > 0,
    A1 is A-1,
    conta_elem(X, T, A1).
    
conta_elem(X, [Y | T], A):-
    X \= Y,
    conta_elem(X ,T, A).