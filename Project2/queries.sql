
/*a*/

select value(ta).tipo,  sum(value(ta).n_aulas * value(ta).turnos)
from ucs u, table(value(u).ocorrencias) o, table(value(o).tiposAula) ta
where u.curso = 233
and value(o).ano_letivo = '2004/2005'
group by value(ta).tipo

/*b*/


/*c*/

with aux as (
select value(d).nr as nr, value(d).nome as nome, value(ta).tipo as tipo, sum(value(x).horas) as horas
from ocorrencias o, table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where value(o).ano_letivo = '2003/2004'
and value(ta).id = value(x).id
group by value(d).nr, value(d).nome, value(ta).tipo
order by value(d).nr
)

select  ht.tipo, max(ht.horas)
from aux ht
group by ht.tipo
 /********************/

create or replace view horasPorTipo as 
select value(d).nr as nr, value(d).nome as nome, value(ta).tipo as tipo, sum(value(x).horas*value(x).fator) as horas
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
select value(o).ano_letivo, value(d).categoria,  round(avg(value(x).horas),3)
from ocorrencias o, table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where regexp_like (value(o).ano_letivo, '^200[1-4]')
and value(ta).id = value(x).id
group by value(o).ano_letivo, value(d).categoria 
order by value(o).ano_letivo,  value(d).categoria 

/*e*/

/*f*/