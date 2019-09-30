% gosta(pessoa, coisa)
gosta('Ana', peru).
gosta('António', frango).
gosta('Bruno', salmao).

% casado(pessoa1, pessoa2
casado('Ana', 'Barbara').
casado('Ana', 'Bruno').
casado('António', 'Bruno').

% combina(produto1, produto2
combina(solha, 'vinho verde').


casadoseGostar(Pessoa1, Pessoa2, Coisa):-
    casado(Pessoa1, Pessoa2),
    gosta(Pessoa1, Coisa),
    gosta(Pessoa2, Coisa).

casadoseGostar(Pessoa1, Pessoa2, Coisa):-
    casado(Pessoa2, Pessoa1),
    gosta(Pessoa1, Coisa),
    gosta(Pessoa2, Coisa).

