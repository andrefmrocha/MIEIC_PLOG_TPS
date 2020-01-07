mary([45, 78, 36, 29]).
john([49, 72, 43, 31]).

tasks:-
    mary(MaryTasks),
    john(JohnTasks),
    length(MaryTasks, Length),
    length(JohnTasks, Length),
    Half is Length // 2,
    length(MaryGivenTasks, Length),
    length(JohnGivenTasks, Length),
    global_cardinality(MaryGivenTasks, [0-Half, 1-Half]),
    global_cardinality(JohnGivenTasks, [0-Half, 1-Half]),
    domain(MaryGivenTasks, 0, 1),
    domain(JohnGivenTasks, 0, 1),
    scalar_product(MaryTasks, MaryGivenTasks, #=, MarySum),
    scalar_product(JohnTasks, JohnGivenTasks, #=, JohnSum),
    Sum #= MarySum + JohnSum,
    append(JohnGivenTasks, MaryGivenTasks, Tasks),
    labeling([minimize(Sum)], Tasks),
    write(Tasks).