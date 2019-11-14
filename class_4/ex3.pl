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

dfs_all_paths(_, [], []).
dfs_all_paths(Initial, [H | T1], FinalSolution):-
    dfs(Initial, H, [], Solution),
    dfs_all_paths(H, T1, T2),
    append(Solution, T2, FinalSolution).



dfs(X, X, Solution, Solution).
dfs(Initial, Final, Visited, Solution) :-
    ligado(Initial, X),
    \+ member(X, Visited),
    append([X], Visited, NewVisited),
    dfs(X, Final, NewVisited, Solution).