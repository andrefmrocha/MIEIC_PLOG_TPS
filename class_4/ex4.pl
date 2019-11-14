:-ensure_loaded('ex3.pl').

findall_dfs(Initial, FinalPoints, Solutions):-
    findall(Solution, dfs_all_paths(Initial, FinalPoints, Solution), Solutions).