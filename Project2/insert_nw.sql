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

insert into docentes (nr,nome,sigla,categoria,proprio,apelido,estado,docente_dsd)
select nr, nome, sigla, categoria, proprio, apelido, estado,cast(multiset(
    select dsd_t(nr, id, horas, fator, ordem, null)
    from GTD10.xdsd s
    where d.nr = s.nr
) as docente_dsd_tab_t)
from GTD10.xdocentes d;



-------------------------------------------------------------------------

insert into ucs (codigo,designacao,sigla_uc,curso,ocorrencias)
select codigo,designacao,sigla_uc,curso,cast(multiset(
    select ocorrencias_t(o.codigo, o.ano_letivo, o.periodo, o.inscritos, o.com_frequencia, o.aprovados, o.objetivos, o.conteudo, o.departamento,cast(multiset(
        select tiposAula_t(a.id, a.tipo, a.turnos, a.n_aulas, a.horas_turno,null)
        from GTD10.xtiposaula a
        where a.ano_letivo = o.ano_letivo and a.periodo = o.periodo and a.codigo = o.codigo
    ) as tiposAula_tab_t))
    from GTD10.xocorrencias o
    where o.codigo = u.codigo
)as ocorrencias_tab_t)
from GTD10.xucs u;

insert into docentes (nr,nome,sigla,categoria,proprio,apelido,estado,docente_dsd)
select nr, nome, sigla, categoria, proprio, apelido, estado,cast(multiset(
    select dsd_t(nr, id, horas, fator, ordem, (
        select ref(u)
        from ucs u , table(u.ocorrencias) o, table(o.tiposAula) ta
        where ta.id = s.id
    ))
    from GTD10.xdsd s
    where d.nr = s.nr
) as docente_dsd_tab_t)
from GTD10.xdocentes d;



update table(select o.tiposAula from table(select u.ocorrencias from ucs u) o) ta
   set ta.tiposAula_dsd= cast(multiset(
       select ref(d)
       from docentes d, table(d.docente_dsd) dsd
       where ta.id = dsd.id
   ) as tiposAula_dsd_tab_t );