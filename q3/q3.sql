/*constante*/

select c.year, count(*) as notEnrolled
from xcandidates c
where result = 'C' and
(c.id, c.program, c.year) NOT IN (
select s.id, s.program, s.enroll_year
from xstudents s)
group by c.year
order by c.year

/*variavel*/

select c.year, count(*) as notEnrolled
from xcandidates c
where result = 'C' and
NOT EXISTS (
select s.enroll_year
from xstudents s
where c.id = s.id and c.year = s.enroll_year and c.program = s.program)
group by c.year
order by c.year

/*

does not work

with enrolledStudents as 
(select ep.enroll_year, sum(ep.nr) as f
from (
select s.enroll_year, s.program, count(*) nr
from xstudents s
group by s.enroll_year, s.program) ep
group by ep.enroll_year), 
candidates as 
(select cp.year, sum(cp.nr) as f
from (
select c.year, c.program, count(*) nr
from xcandidates c
group by c.year, c.program) cp
group by cp.year)


select es.enroll_year, c.f - es.f 
from enrolledStudents es, candidates c
where es.enroll_year = c.year
order by es.enroll_year
*/


