:-use_module(library(clpfd)).
:-use_module(library(lists)).

% O programa gera uma lista em L2 com base em todos os elementos de L1 que cada tres elementos se encontram em ordem crescente ou ordem decrescente
% 

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).

test([_, _]).
test([X1, X2, X3 | T]):-
    ((X1 #< X2 #/\ X2 #< X3) #\/ (X1 #> X2 #/\ X2 #> X3)),
    test([X2,X3| T]).

p2(L1, L2):-
    length(L1, Length),
    length(L2, Length),
    pos(L1, L2, Is),
    all_distinct(Is),
    test(L2),
    labeling([], Is).



sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs):-
    length(RecipeEggs, Length),
    length(TakenRecipes, Length),
    domain(TakenRecipes, 0, 1),
    Eggs #=< NEggs,
    scalar_product(RecipeTimes, TakenRecipes, #=<, MaxTime),
    scalar_product(RecipeEggs, TakenRecipes, #=, Eggs),
    labeling([maximize(Eggs), down], TakenRecipes),
    findall(Index, nth1(Index, TakenRecipes, 1), Cookings).

make_task(Size, task(0, 1, 1, Size, Machine), Machine).

make_machines(_, [], []).
make_machines(Id, [H | T], [machine(Id, H) | Items]):-
    NewId is Id + 1,
    make_machines(NewId, T, Items).

cut(Shelves, Boards, SelectedBoards):-
    length(Shelves, Length),
    length(Tasks, Length),
    maplist(make_task, Shelves, Tasks, SelectedBoards),
    make_machines(1, Boards, Machines),
    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([], SelectedBoards).

