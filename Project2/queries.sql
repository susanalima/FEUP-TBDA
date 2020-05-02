
/*a*/

select value(ta).tipo,  sum(value(ta).n_aulas * value(ta).turnos)
from ucs u, table(value(u).ocorrencias) o, table(value(o).tiposAula) ta
where u.curso = 233
and value(o).ano_letivo = '2004/2005'
group by value(ta).tipo

/*b*/


/*c*/

/*d*/

select value(o).ano_letivo, value(d).categoria, round(avg(value(x).horas),3)
from ocorrencias o, table(value(o).tiposAula) ta, table(value(ta).tiposAula_dsd) d, table(value(d).docente_dsd) x
where regexp_like (value(o).ano_letivo, '^200[1-4]')
group by value(o).ano_letivo, value(d).categoria 
order by value(o).ano_letivo,  value(d).categoria 

/*e*/

/*f*/