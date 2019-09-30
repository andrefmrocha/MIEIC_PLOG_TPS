passaro(tweety).
peixe(goldie).
minhoca(molie).
gato(silvester).

gosta_de(Animal, minhoca):-
    passaro(Animal).

gosta_de(Animal, peixe):-
    gato(Animal).

gosta_de(Animal, passaro):-
    gato(Animal).

amigo(eu, silvester).

come(Animal, Comida):-
    gosta_de(Animal, Comida).
    
