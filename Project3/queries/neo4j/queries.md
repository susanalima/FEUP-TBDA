a. Which are the facilities where the room type description contains ‘touros’ and
have ‘teatro’ as one of their activities? Show the id, name, description and
activity.

```
MATCH (a:Activities)<-[:ACTIVITY_TYPE]-(f:Facilities)-[:ROOMTYPE]->(r:Roomtypes) WHERE r.description CONTAINS 'touros' and a.activity='teatro' RETURN f.facilityID,f.name, r.description, a.activity
```

b. How many facilities with ‘touros’ in the room type description are there in
each region?

```
MATCH (reg:Regions)<-[:REGION]-(m:Municipalities)<-[:MUNICIPALITY]-(f:Facilities)-[:ROOMTYPE]->(r:Roomtypes) WHERE r.description CONTAINS 'touros' RETURN reg.description, COUNT(f) AS nr
ORDER BY nr DESC
```

c. How many municipalities do not have any facility with an activity of
‘cinema’?

```
MATCH (mun:Municipalities) with count(mun) as totalMun
MATCH (a:Activities)<-[:ACTIVITY_TYPE]-(f:Facilities)-[:MUNICIPALITY]->(m:Municipalities) where a.activity="cinema" WITH DISTINCT m, totalMun return totalMun - count(m) as nrMunicipalities
```

d. Which is the municipality with more facilities engaged in each of the six kinds
of activities? Show the activity, the municipality name and the corresponding
number of facilities

```
MATCH (a:Activities)<-[:ACTIVITY_TYPE]-(f:Facilities)-[:MUNICIPALITY]->(m:Municipalities) with a,m,count(f) as nrFacilities
with a, collect(m) as mun, collect(nrFacilities) as counts
with a, mun, counts, reduce(x=[0,0], idx in range(0,size(counts)-1) | case when counts[idx] > x[1] then [idx,counts[idx]] else x end)[0] as index
return a.activity AS Activity, mun[index].designation AS Municipality, counts[index] As Nr ORDER BY a.activity
```


e. Which are the codes and designations of the districts with facilities in all the
municipalities?

```

```

MATCH (f:Facilities)-[:MUNICIPALITY]->(m:Municipalities)-[:DISTRICT]->(d:Districts)
RETURN (f) - [] -> (m)- [] -> (d)

f. Ask the database a query you think is interesting.

retorna os municipalities que estao no centro do continente, que tem mais de 7 facilities

```
MATCH (f:Facilities)-[:MUNICIPALITY]->(m:Municipalities)-[:REGION]->(r:Regions) with r,m,count(f) as nrFacilities
WHERE r.nut1="Continente" and r.description="Centro" and nrFacilities > 7
return m.designation AS Municipality, nrFacilities
```

