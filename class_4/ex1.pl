ligado(a,b).
ligado(f,i).
ligado(a,c).
ligado(f,j).
ligado(b,d).
ligado(f,k).
ligado(b,e).
ligado(g,l).
ligado(b,f).
ligado(g,m).
ligado(c,g).
ligado(k,n).
ligado(d,h).
ligado(l,o).
ligado(d,i).
ligado(i,f).


dfs(X, X, Solution, Solution).
dfs(Initial, Final, Visited, Solution) :-
    ligado(Initial, X),
    \+ member(X, Visited),
    append([X], Visited, NewVisited),
    dfs(X, Final, NewVisited, Solution).

neighbour(Initial, L):-
    bagof(X, ligado(Initial, X), L).

bfs(X, X, Solution, Solution).
bfs([Initial | T], Final, Visited, Solution):-
    neighbour(Initial, [H | T]),
    % \+ member(H, Visited),
    append(Visited, [H], NewVisited),
    bfs(H, Final, NewVisited, Solution).
