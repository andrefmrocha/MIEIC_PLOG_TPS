pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

% teamMember(pilot, team)

teamMember('Lamb', 'Breitling').
teamMember('Besenyei', 'Red Bull').
teamMember('Chambliss', 'Red Bull').
teamMember('MacLean', 'Mediterranean Racing Team').
teamMember('Mangold', 'Cobra').
teamMember('Jones', 'Bonhomme da Matador').

% plane(pilot, plane)
plane('Lamb', 'MX2').
plane('Besenyei', 'Edge540').
plane('Chambliss', 'Edge540').
plane('MacLean', 'Edge540').
plane('Mangold', 'Edge540').
plane('Jones', 'Edge540').
plane('Bonhomme', 'Edge540').

circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

% victory(pilot, circuit)
victory('Jones', 'Porto').
victory('Mangold', 'Budapest').
victory('Mangold', 'Istanbul').

% numGates(circuit, gate)
numGates('Istanbul', 9).
numGates('Budapest', 6).
numGates('Porto', 5).

winsRace(Team, Circuit):-
    teamMember(Pilot, Team),
    victory(Pilot, Circuit).

morethan1Wins(Pilot):-
    victory(Pilot, Circuit1),
    victory(Pilot, Circuit2),
    Circuit1 @< Circuit2.

morethan8Gates(Circuit):-
    circuit(Circuit),
    numGates(Circuit, NumGates),
    NumGates @> 8.

dontPilot(Pilot):-
    pilot(Pilot),
    plane(Pilot, Plane),
    Plane \= 'Edge540'.    




