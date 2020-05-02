
drop type tiposAula_t force;
drop type dsd_t force;
drop type docente_dsd_tab_t force;
drop type docentes_t force;
drop type tiposAula_dsd_tab_t force;
drop type tiposAula_tab_t force;
drop type ocorrencias_t force;
drop type ocorrencias_tab_t force;
drop type ucs_t force;

drop table docentes;
drop table ucs;


create or replace type tiposAula_t as object(
    id number(10),
    tipo varchar(2),
    turnos number(2),
    n_aulas number(5),
    horas_turno number(5)
);

create or replace type dsd_t as object(
    nr number(10),
    id number(10),
    horas number(10),
    fator number(5),
    ordem number(5)
);

create or replace type docentes_t as object(
    nr number(10),
    nome varchar(80),
    sigla varchar(10),
    categoria varchar(50),
    proprio varchar(50),
    apelido varchar(50),
    estado varchar(10)
);

create or replace type tiposAula_dsd_tab_t as table of ref docentes_t;

alter type tiposAula_t add attribute tiposAula_dsd tiposAula_dsd_tab_t cascade;

create or replace type tiposAula_tab_t as table of tiposAula_t;

create or replace type ocorrencias_t as object(
    codigo varchar(10),
    ano_letivo varchar(10),
    periodo varchar(5),
    inscritos number(8),
    com_frequencia number(8),
    aprovados number(8),
    objetivos varchar(4000),
    conteudo varchar(4000),
    departamento varchar(10),
    tiposAula tiposAula_tab_t
);

create or replace type ocorrencias_tab_t as table of ocorrencias_t;

create or replace type ucs_t as object(
    codigo varchar(10),
    designacao varchar(120),
    sigla_uc varchar(10),
    curso varchar(30),
    ocorrencias ocorrencias_tab_t
);

alter type dsd_t add attribute ucs ref ucs_t cascade;

create or replace type docente_dsd_tab_t as table of dsd_t;

alter type docentes_t add attribute docente_dsd docente_dsd_tab_t cascade;

create table docentes of docentes_t
    nested table docente_dsd store as docente_dsd_tab;

create table ucs of ucs_t
    nested table ocorrencias store as ocorrencias_tab
        (nested table tiposAula store as tiposAula_tab
            (nested table tiposAula_dsd store as tiposAula_dsd_tab));
