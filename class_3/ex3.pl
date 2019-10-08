myappend([], L, L).
myappend([L | L1], L2, [L | L3]):- myappend(L1, L2, L3).