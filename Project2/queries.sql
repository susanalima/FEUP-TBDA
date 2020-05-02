select value(ta).tipo,  sum(value(ta).n_aulas * value(ta).turnos)
from ucs u, table(value(u).ocorrencias) o, table(value(o).tiposAula) ta
where u.curso = 233
and value(o).ano_letivo = '2004/2005'
group by value(ta).tipo