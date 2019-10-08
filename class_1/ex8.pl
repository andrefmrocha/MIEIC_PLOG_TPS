cargo(tecnico, rogerio).
cargo(tecnico, ivone).  
cargo(engenheiro, daniel).  
cargo(engenheiro, isabel).  
cargo(engenheiro, oscar). 
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).

/**
* a- Quem é que chefeia quem chefeia o tecnico?
*/

/**
* b- Quem é que chefeia o tecnico, cujo o chefe é a Ivone.
*/

/**
* c- 
*/
