insert into docentes (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from GTD10.xdocentes;

insert into ucs (codigo, designacao, sigla_uc, curso)
select codigo, designacao, sigla_uc, curso
from GTD10.xucs;

insert into ocorrencias (codigo, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento)
select codigo, ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento
from GTD10.xocorrencias;

insert into tiposAula (id, tipo, turnos, n_aulas, horas_turno)
select id, tipo, turnos, n_aulas, horas_turno
from GTD10.xtiposaula;

insert into dsd (nr, id, horas, fator, ordem, tiposAula)
select nr, xdsd.id, horas, fator, ordem, ref(ta)
from GTD10.xdsd xdsd, tiposAula ta
where ta.id = xdsd.id;

update docentes d
set d.docente_dsd = cast(multiset(
    select ref(x)
    from dsd x
    where d.nr = x.nr) as docente_dsd_tab_t);

update ucs u
set u.ocorrencias = cast(multiset(
    select ref(o)
    from ocorrencias o
    where o.codigo = u.codigo) as ocorrencias_tab_t);


