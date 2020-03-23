select  c.program, c.year, min(c.average) as minAverage
from xcandidates c
where average is not null and c.result = 'C'
group by c.program, c.year
order by c.program, c.year