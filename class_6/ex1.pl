abs_dif(A, B, C):-
    C is abs(A - B).

f(X,Y):-Y is X*X.

map([], _, []).
map([H | T], Func, [HCR | TCR]):-
    Pred =..[Func, H, HCR],
    Pred,
    map(T, Func, TCR).

f(1).
f(3).
