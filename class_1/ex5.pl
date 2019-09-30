mora_em(joao, apartamento).
mora_em(maria, apartamento).
mora_em(ana, casa).
animal(cao).
desporto(tenis).
desporto(natacao).
gosta_de(maria, natacao).
gosta_de(maria, desporto).
gosta_de(joao, gato).
gosta_de(joao, jogos).
mulher(ana).
mulher(maria).
homem(joao).

morar_e_gostar(Pessoa, Casa, Animal):-
    mora_em(Pessoa, Casa),
    gosta_de(Pessoa, Animal).

