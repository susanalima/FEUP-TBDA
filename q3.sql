select count(*) as notEnrolled
from xcandidates c
where result = 'C' and
NOT EXISTS (
select s.id
from xstudents s
where c.id = s.id and c.year = s.enroll_year and c.program = s.program)