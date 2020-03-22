/*count*/

select candidates.year, p.acronym, p.designation
from 
(select s.enroll_year, s.program, count(*) nr
from xstudents s
group by s.enroll_year, s.program) students, 
(select c.year, c.program, count(*) nr
from xcandidates c
where c.result = 'C'
group by c.year, c.program) candidates,
xprograms p
where students.enroll_year = candidates.year 
and students.program = candidates.program
and students.nr = candidates.nr
and p.code = students.program
order by candidates.year, candidates.program


/*double negation*/

select candidates.year, p.acronym, p.designation
from xcandidates candidates, xprograms p
where p.code = candidates.program and
candidates.result = 'C' and
(program, year) not in (
select c.program, c.year
from xcandidates c
where c.result = 'C'
and not exists 
(
    select s.enroll_year, s.program
    from xstudents s
    where s.enroll_year = c.year 
    and s.program = c.program
    and s.id = c.id
)
)
group by candidates.year, p.acronym, p.designation
order by candidates.year, p.acronym

