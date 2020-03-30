/*select s.conclusion_year, max(s.final_average)
from xstudents s
where s.final_average is not null
group by s.conclusion_year
ORDER BY s.conclusion_year

select temp.conclusion_year, max(temp.maxAvg)
from (
select s.conclusion_year, s.program, max(s.final_average) as maxAvg
from xstudents s
where s.final_average is not null
group by s.conclusion_year, s.program
order by s.conclusion_year) temp
group by temp.conclusion_year
order by temp.conclusion_year



select q1.conclusion_year, q1.program, q2.result
from (
select s.conclusion_year, s.program, max(s.final_average) as maxAvg
from xstudents s
where s.final_average is not null
group by s.conclusion_year, s.program
order by s.conclusion_year) q1,
(select temp.conclusion_year, max(temp.maxAvg) as result
from (
select s.conclusion_year, s.program, max(s.final_average) as maxAvg
from xstudents s
where s.final_average is not null
group by s.conclusion_year, s.program
order by s.conclusion_year) temp
group by temp.conclusion_year
order by temp.conclusion_year) q2
where q1.conclusion_year = q2.conclusion_year and
q1.maxAvg = q2.result

*/

/*v1*/

with aux as (
select s.conclusion_year, s.program, max(s.final_average) as maxAvg
from xstudents s
where s.final_average is not null
group by s.conclusion_year, s.program
order by s.conclusion_year)

select q1.conclusion_year, q1.program, q2.result
from aux q1,
(select temp.conclusion_year, max(temp.maxAvg) as result
from aux temp
group by temp.conclusion_year
order by temp.conclusion_year) q2
where q1.conclusion_year = q2.conclusion_year and
q1.maxAvg = q2.result


/*v2*/

Select distinct s1.conclusion_year,p.code,s2.max_average as result
From xprograms p, xstudents s1,
(
    select s.conclusion_year,max(s.final_average) as max_average
    from xstudents s
    where s.status = 'C'
    group by s.conclusion_year
) s2
Where p.code = s1.program
    and s1.conclusion_year = s2.conclusion_year
    and s1.final_average = s2.max_average
Order by s1.conclusion_year