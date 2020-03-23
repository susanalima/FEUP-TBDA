# Project

## Questions to analyse

1. "Qual a lista dos números dos alunos especiais, que terminaram o curso com sigla EIC em menos de cinco
anos, e quantos anos demoraram."


```
select s.nr, s.conclusion_year - s.enroll_year as years
from  xstudents s join xprograms  p on  s.program = p.code
where p.acronym = 'EIC' and  s.conclusion_year - s.enroll_year < 5 and s.status = 'C'
order by s.nr
```


2. "Qual a média mínima de candidatura em cada curso, em cada ano, dos alunos matriculados? Nem todas
as candidaturas têm a média preenchida."

```
select  c.program, c.year, min(c.average)  as minAverage
from xcandidates c
where average is not null and c.result = 'C'
group by c.program, c.year
order by c.program, c.year
```


3. "Considere a questão de saber quantos candidatos aceites não se matricularam nesse ano lectivo. Compare
uma formulação que use uma subpergunta constante com a equivalente que use uma subpergunta variável
(sugestão: usar EXISTS)."

```
select count(*) as notEnrolled
from xcandidates c
where result = 'C' and
NOT EXISTS (
select s.id
from xstudents s
where c.id = s.id and c.year = s.enroll_year and c.program = s.program)
```

4. "Estude as tentativas de resposta à questão “Qual o curso do aluno com a melhor média de conclusão em
cada ano lectivo” apresentadas abaixo. Comente-as."


```
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
``` 


5. "Compare os planos de execução da pesquisa “Quantos candidatos tiveram como resultado algo diferente de “C” ou “E”, usando, no contexto Z

    a. Com índice árvore-B em Resultado;

    b. Com índice bitmap em Resultado. "


```
select count(*) as nrCandidates
from xcandidates c
where c.result != 'C' and c.result != 'E'
```

6. "A pergunta “Há, em algum ano algum curso (ano_lectivo, sigla e nome) que tenha todas as candidaturas
aceites transformadas em matrículas, nesse mesmo ano?” é de natureza universal. Compare do ponto de
vista temporal e de plano de execução as estratégias da dupla negação e da contagem."


#### count:

```
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

```

#### double negation:

```
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
``` 

