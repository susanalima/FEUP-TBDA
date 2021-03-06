a. Which are the facilities where the room type description contains ‘touros’ and
have ‘teatro’ as one of their activities? Show the id, name, description and
activity.

```
db.municipalities.aggregate([
    {$unwind: "$FACILITIES"},
    {$project: {
        "_id": 0,
        "FACILITIES.ID": 1,
        "FACILITIES.NAME": 1,
        "FACILITIES.ROOMTYPE.DESCRIPTION": 1,
        "FACILITIES.ACTIVITIES.ACTIVITY": 1
     }},
    {$match: 
        {"FACILITIES.ACTIVITIES.ACTIVITY": "teatro",
          "FACILITIES.ROOMTYPE.DESCRIPTION": /touros/,
        }
    },
    ]    
)
```

b. How many facilities with ‘touros’ in the room type description are there in
each region?

```
db.municipalities.aggregate([
    {$unwind: "$FACILITIES"},   
    {$match: 
        {
          "FACILITIES.ROOMTYPE.DESCRIPTION": /touros/,
        }
    },
    {$group : {_id : "$REGION.DESIGNATION", count : {$sum : 1}}}
    ]    
)
```

c. How many municipalities do not have any facility with an activity of
‘cinema’?

```
db.municipalities.aggregate([ 
    {$match: 
        {"FACILITIES.ACTIVITIES.ACTIVITY": {$ne: "cinema"}}
    },
    {$count : "count"}
    ]    
)
```

d. Which is the municipality with more facilities engaged in each of the six kinds
of activities? Show the activity, the municipality name and the corresponding
number of facilities

```
db.municipalities.aggregate([
    {$unwind: "$FACILITIES"},
    {$unwind: "$FACILITIES.ACTIVITIES"},
    {$group: {_id: {"municipality":"$DESIGNATION","activity": "$FACILITIES.ACTIVITIES.ACTIVITY"}, 
    count: {$sum: 1}}},
    {$sort: {"count": -1}},
     {$group: {_id: "$_id.activity", "municipality": {"$first": "$_id.municipality"},
    count: {$max: "$count"}}},
    ]    
)
```

e. Which are the codes and designations of the districts with facilities in all the
municipalities?

```
db.municipalities.aggregate([ 
    {$group:{
    _id: {_id:"$DISTRICT.COD", designation:"$DISTRICT.DESIGNATION"},
    municipalities: { $push: { hasFacilities: {$gt: [{ $size: "$FACILITIES" },0]},nome: "$designation"}}
    },},
    {$match:{
    "municipalities" : {"$not":{"$elemMatch":{"hasFacilities":false}}}
    }},
    {$project: {_id:0, "Code": "$_id._id", "Designation": "$_id.designation"}},
    ]    
)
```

f. Ask the database a query you think is interesting.

retorna os municipalities que estao no centro do continente, que tem mais de 7 facilities

```
db.municipalities.aggregate([ 

    {$match: 
        {"REGION.NUT1": {$eq: "Continente"},
        "REGION.DESIGNATION": {$eq: "Centro"},
        }
    },
     {$project: { _id: 0, "DESIGNATION": 1, count: { $size:"$FACILITIES" }}},
    {$match:{count:{$gt:7}}},
       {$sort: {"count": -1}},
    ]    
)
```

