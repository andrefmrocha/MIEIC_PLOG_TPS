ligacao(1, 2).
ligacao(1, 3).
ligacao(2, 4).
ligacao(3, 4).
ligacao(3,6).
ligacao(4, 6).
ligacao(5,6).

ligacao2(X, Y):- ligacao(X, Y).
ligacao2(X, Y):- ligacao(Y, X).


member(List, X):- append(_, [X | _], List).

caminho(Initial, Final, [Initial | Path]):-
    caminho_helper(Initial, Final, [], Path, 1).

caminho_helper(_, _, _, _, 4):- fail.
caminho_helper(Final, Final, Visited, Visited, Depth):- Depth < 5.
caminho_helper(Initial, Final, Visited, Solution, Depth):-
    ligacao2(Initial, X),
    not(member(Visited, X)),
    append(Visited, [X], NewVisited),
    NewDepth is Depth + 1,
    caminho_helper(X, Final, NewVisited, Solution, NewDepth).

ciclos(Node, Comp, List):-
    findall(Solution, caminho_helper(Node, Node, [], Solution, Comp), Solutions).