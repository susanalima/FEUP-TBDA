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


3. "Considere a questão de saber quantos candidatos aceites não se matricularam nesse ano lectivo. Compare
uma formulação que use uma subpergunta constante com a equivalente que use uma subpergunta variável
(sugestão: usar EXISTS)."


4. "Estude as tentativas de resposta à questão “Qual o curso com a melhor média de conclusão em cada ano
lectivo” apresentadas abaixo. Comente-as."


5. "Compare os planos de execução da pesquisa “Quantos candidatos tiveram como resultado algo diferente de “C” ou “E”, usando, no contexto Z

    a. Com índice árvore-B em Resultado;

    b. Com índice bitmap em Resultado. "


6. "A pergunta “Há, em algum ano algum curso (ano_lectivo, sigla e nome) que tenha todas as candidaturas
aceites transformadas em matrículas, nesse mesmo ano?” é de natureza universal. Compare do ponto de
vista temporal e de plano de execução as estratégias da dupla negação e da contagem."

