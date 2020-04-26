insert into docentes (nr, nome, sigla, categoria, proprio, apelido, estado)
select nr, nome, sigla, categoria, proprio, apelido, estado
from GTD10.xdocentes;

insert into ucs (codigo, designacao, sigla_uc, curso)
select codigo, designacao, sigla_uc, curso
from GTD10.xucs;

insert into ocorrencias (ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento)
select ano_letivo, periodo, inscritos, com_frequencia, aprovados, objetivos, conteudo, departamento
from GTD10.XOCORRENCIAS;

insert into tiposAula (id, tipo, turnos, n_aulas, horas_turno)
select id, tipo, turnos, n_aulas, horas_turno
from GTD10.xtiposaula;

insert into dsd (horas, fator, ordem, tiposAula)
select horas, fator, ordem, ref(ta)
from GTD10.xdsd xdsd, tiposAula ta
where ta.id = xdsd.id;


