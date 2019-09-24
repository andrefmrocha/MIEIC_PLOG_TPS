aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

ensina(Professor, Aluno):-
    professor(Professor, Cadeira),
    aluno(Aluno, Cadeira).

localTrabalho(Aluno, Universidade):-
    frequenta(Aluno, Universidade).

localTrabalho(Professor, Universidade):-
    funcionario(Professor, Universidade).

colega(Aluno1, Aluno2):-
    aluno(Aluno1, Cadeira),
    aluno(Aluno2, Cadeira).

colega(Aluno1, Aluno2):-
    frequenta(Aluno1, Universidade),
    frequenta(Aluno2, Universidade).

colega(Professor1, Professor2):-
    funcionario(Professor1, Universidade),
    funcionario(Professor2, Universidade).



