select candidates.year, p.acronym, p.designation
from 
(select s.enroll_year, s.program, count(*) nr
from xstudents s
group by s.enroll_year, s.program
order by s.enroll_year, s.program) students, 
(select c.year, c.program, count(*) nr
from xcandidates c
where c.result = 'C'
group by c.year, c.program
order by c.year, c.program) candidates,
xprograms p
where students.enroll_year = candidates.year 
and students.program = candidates.program
and students.nr = candidates.nr
and p.code = students.program

order by candidates.year, candidates.program
