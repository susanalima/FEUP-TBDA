select c.year, count(*) as notEnrolled
from xcandidates c
where result = 'C' and
NOT EXISTS (
select s.enroll_year
from xstudents s
where c.id = s.id and c.year = s.enroll_year and c.program = s.program)
group by c.year
order by c.year