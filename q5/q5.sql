select count(*) as nrCandidates
from xcandidates c
where c.result != 'C' and c.result != 'E'


select count(*) as nrCandidates
from zcandidates c
where c.result != 'C' and c.result != 'E'