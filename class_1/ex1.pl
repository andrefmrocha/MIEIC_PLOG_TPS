male('Aldo Burrows').
male('Lincoln Burrows').
male('LJ Burrows').
male('Michael Scofield').
female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

% parent(parent, child)

parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofield', 'Lincoln Burrows').

parent('Aldo Burrows', 'Michael Scofield').
parent('Christina Rose Scofield', 'Michael Scofield').

parent('Lincoln Burrows', 'LJ Burrows').
parent('Lisa Rix', 'LJ Burrows').

parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').

father(Parent, Child):-
    parent(Parent, Child),
    male(Parent).

father(Parent, Child):-
    parent(Parent, Child),
    male(Parent).
