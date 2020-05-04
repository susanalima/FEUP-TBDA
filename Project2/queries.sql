
/*a*/

select value(ta).tipo as tipo, sum(value(ta).getClassHours()) as classHours
from ucs u, table(value(u).ocorrencias) o, table(value(o).tiposAula) ta
where u.curso = 233
and value(o).ano_letivo = '2004/2005'
group by value(ta).tipo;

/*b*/

create or replace view requiredHours as
select value(u).codigo as codigo, sum(value(ta).getClassHours()) as horas
from ucs u, table(value(u).ocorrencias) o, table(value(o).tiposAula) ta
where value(o).ano_letivo = '2003/2004'
group by value(u).codigo;

create or replace view assignedHours as
select u.codigo as codigo, sum(value(x).horas) as horas
from ucs u, table(value(u).ocorrencias) o,  table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where value(o).ano_letivo = '2003/2004'
and value(ta).id = value(x).id
group by u.codigo

select r.codigo, r.horas as requiredHours, a.horas as assignedHours
from requiredHours r, assignedHours a
where r.codigo = a.codigo and r.horas <> a.horas;


/*c*/

create or replace view horasPorTipo as 
select value(d).nr as nr, value(d).nome as nome, value(ta).tipo as tipo, sum(value(x).getHorasFator()) as horas
from ocorrencias o, table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where value(o).ano_letivo = '2003/2004'
and value(ta).id = value(x).id
group by value(d).nr, value(d).nome, value(ta).tipo
order by value(d).nr;

create or replace view maxHorasPorTipo as 
select  ht.tipo as tipo, max(ht.horas) as maxHoras
from horasPorTipo ht
group by ht.tipo;

select ht.nr, ht.nome, ht.tipo, ht.horas as horasFator
from horasPorTipo ht, maxHorasPorTipo mh
where ht.tipo  = mh.tipo
and ht.horas = mh.maxHoras;


/*d*/
select value(o).ano_letivo as ano_letivo, value(d).categoria as categoria,  round(avg(value(x).horas),3) as avgHours
from ocorrencias o, table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where regexp_like (value(o).ano_letivo, '^200[1-4]')
and value(ta).id = value(x).id
and value(d).categoria is not null
group by value(o).ano_letivo, value(d).categoria 
order by value(o).ano_letivo,  value(d).categoria 

/*e*/

select value(o).ano_letivo as ano_letivo, value(o).periodo as periodo, sum(value(ta).horas_turno) as horas
from ocorrencias o, table(value(o).tiposAula) ta
where value(ta).n_aulas is not null and value(ta).turnos is not null and value(o).periodo like '%S'
group by value(o).ano_letivo, value(o).periodo
order by value(o).ano_letivo, value(o).periodo;

/*f*/

select value(u).codigo as codigo,value(o).ano_letivo as anoLetivo, round(value(o).calculatePercentage(value(o).inscritos,value(o).com_frequencia),3) as PercentagemComFrequencia ,round(value(o).calculatePercentage(value(o).inscritos,value(o).aprovados),3) as PercentagemAprovados 
from ucs u, table(value(u).ocorrencias) o
where value(o).inscritos is not null and value(o).com_frequencia is not null and value(o).aprovados is not null
order by value(u).codigo,value(o).ano_letivo;