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

```

d. Which is the municipality with more facilities engaged in each of the six kinds
of activities? Show the activity, the municipality name and the corresponding
number of facilities

```

```

e. Which are the codes and designations of the districts with facilities in all the
municipalities?

```

```

f. Ask the database a query you think is interesting.

retorna os municipalities que estao no centro do continente, que tem mais de 7 facilities

```

```


