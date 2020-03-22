select s.nr, s.conclusion_year - s.enroll_year as time
from xprograms  p, xstudents s
where p.acronym = 'EIC' and s.program = p.code and  s.conclusion_year - s.enroll_year < 5

/*or*/

select s.nr, s.conclusion_year - s.enroll_year as years
from  xstudents s join xprograms  p on  s.program = p.code
where p.acronym = 'EIC' and  s.conclusion_year - s.enroll_year < 5 and s.status = 'C'
order by s.nr

