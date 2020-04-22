create type tiposAula_t as object(
    tipo varchar(2),
    turnos number(2),
    n_aulas number(5),
    horas_turno number(5)
);

create type dsd_t as object(
    horas number(10),
    fator number(2),
    ordem number(5),
    tiposAula ref tiposAula_t
);

create type docente_dsd_tab_t as table of dsd_t;

create type docentes_t as object(
    nr number(10),
    nome varchar(30),
    sigla varchar(5),
    categoria varchar(10),
    proprio varchar(15),
    apelido varchar(15),
    estado varchar(2),
    docente_dsd docente_dsd_tab_t
);

create type tiposAula_dsd_tab_t as table of ref docentes_t;

alter type tiposAula_t add attribute tiposAula_dsd tiposAula_dsd_tab_t cascade;

create type tiposAula_tab_t as table of tiposAula_t;

create type ocurrencias_t as object(
    ano_letivo number(4),
    periodo varchar(2),
    inscritos number(8),
    com_frequencia number(8),
    aprovados number(8),
    objetivos varchar(30),
    conteudo varchar(30),
    departamento varchar(30),
    tiposAula tiposAula_tab_t
);

create type ocurrencias_tab_t as table of ocurrencias_t;

create type ucs_t as object(
    codigo varchar(7),
    designacao varchar(15),
    sigla_uc varchar(5),
    curso varchar(15),
    ocurrencias ocurrencias_tab_t
);



create table tiposAula of tiposAula_t
    nested table tiposAula_dsd store as tiposAula_dsd_tab;

create table docentes of docentes_t
    nested table docente_dsd store as docente_dsd_tab;

create table ocurrencias of ocurrencias_t
    nested table tiposAula store as tiposAula_tab return as locator;

create table ucs of ucs_t
    nested table ocurrencias store as ocurrencias_tab return as locator;
