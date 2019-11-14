ligado(a,b, 2).
ligado(f,i, 2).
ligado(a,c, 1).
ligado(f,j, 2).
ligado(b,d, 1).
ligado(f,k, 3).
ligado(b,e, 4).
ligado(g,l, 3).
ligado(b,f, 5).
ligado(g,m, 3).
ligado(c,g, 4).
ligado(k,n, 1).
ligado(d,h, 1).
ligado(l,o, 3).
ligado(d,i, 4).
ligado(i,f, 5).

member(Elem, List):- append(_, [Elem | _], List).

select_value([H | _], Visited, H):-
    not(member(H, Visited)).
select_value([_ | T], Visited, BestValue):-
    select_value(T, Visited, BestValue).
    

dijkstra(X, X, Solution, Solution).
dijkstra(Initial, Final, Visited, Solution) :-
    setof(Value-X, ligado(Initial, X, Value), Values),
    select_value(Values, Visited, _-BestValue),
    append(Visited, [BestValue], NewVisited),
    dijkstra(BestValue, Final, NewVisited, Solution).