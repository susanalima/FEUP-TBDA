// Create activities
LOAD CSV WITH HEADERS FROM 'file:///activities.csv' AS row
MERGE (activities:Activities {activityREF: toInteger(row.REF)})
    ON CREATE SET activities.activity = row.ACTIVITY;

// Create facilities
LOAD CSV WITH HEADERS FROM 'file:///facilities.csv' AS row
MERGE (fac:Facilities {facilityID: toInteger(row.ID)})
    ON CREATE SET fac.name = row.NAME, fac.capacity = toInteger(row.CAPACITY), fac.roomtype = toInteger(row.ROOMTYPE), fac.address = row.ADDRESS, fac.municipality = toInteger(row.MUNICIPALITY);

// Create roomtype
LOAD CSV WITH HEADERS FROM 'file:///roomtypes.csv' AS row
MERGE (room:Roomtypes {roomtypeID: toInteger(row.ROOMTYPE)})
    ON CREATE SET room.description = row.DESCRIPTION;

// Create municipality
LOAD CSV WITH HEADERS FROM 'file:///municipalities.csv' AS row
MERGE (mun:Municipalities {municipalityCOD: toInteger(row.COD)})
    ON CREATE SET mun.designation = row.DESIGNATION, mun.district = toInteger(row.DISTRICT), mun.region = toInteger(row.REGION);

// Create districts
LOAD CSV WITH HEADERS FROM 'file:///districts.csv' AS row
MERGE (dis:Districts {districtCOD: toInteger(row.COD)})
    ON CREATE SET dis.designation = row.DESIGNATION, dis.region = toInteger(row.REGION);

// Create regions
LOAD CSV WITH HEADERS FROM 'file:///regions.csv' AS row
MERGE (reg:Regions {regionCOD: toInteger(row.COD)})
    ON CREATE SET reg.description = row.DESIGNATION, reg.nut1 = row.NUT1;

CREATE INDEX uses_id_ref FOR (u:Uses) ON (u.usesID, u.usesREF);
CREATE INDEX activity_ref FOR (act:Activities) ON (act.activityREF);
CREATE INDEX facility_id FOR (fac:Facilities) ON (fac.facilityID);
CREATE INDEX roomtype_id FOR (room:Roomtypes) ON (room.roomtypeID);
CREATE INDEX municipalities_cod FOR (mun:Municipalities) ON (mun.municipalityCOD);
CREATE INDEX districts_cod FOR (dis:Districts) ON (dis.districtCOD);
CREATE INDEX regions_cod FOR (reg:Regions) ON (reg.regionCOD);

// Create relation between facilities and activities
LOAD CSV WITH HEADERS FROM 'file:///uses.csv' AS row
MATCH (fac:Facilities {facilityID: toInteger(row.ID)})
MATCH (act:Activities {activityREF: toInteger(row.REF)})
CREATE (fac)-[:ACTIVITY_TYPE]->(act);

// Create relation between facilities and roomtype
LOAD CSV WITH HEADERS FROM 'file:///facilities.csv' AS row
MATCH (fac:Facilities {facilityID: toInteger(row.ID)})
MATCH (room:Roomtypes {roomtypeID: toInteger(row.ROOMTYPE)})
MERGE (fac)-[:ROOMTYPE {type: room.description}]->(room);

// Create relation between facilities and municipalitites
LOAD CSV WITH HEADERS FROM 'file:///facilities.csv' AS row
MATCH (fac:Facilities {facilityID: toInteger(row.ID)})
MATCH (mun:Municipalities {municipalityCOD: toInteger(row.MUNICIPALITY)})
MERGE (fac)-[:MUNICIPALITY]->(mun);

// Create relation between municipalities and districts
LOAD CSV WITH HEADERS FROM 'file:///municipalities.csv' AS row
MATCH (mun:Municipalities {municipalityCOD: toInteger(row.COD)})
MATCH (dist:Districts {districtCOD: toInteger(row.DISTRICT)})
MERGE (mun)-[:DISTRICT]->(dist);

// Create relation between municipalities and regions
LOAD CSV WITH HEADERS FROM 'file:///municipalities.csv' AS row
MATCH (mun:Municipalities {municipalityCOD: toInteger(row.COD)})
MATCH (reg:Regions {regionCOD: toInteger(row.REGION)})
MERGE (mun)-[:REGION]->(reg);

// Create relation between districts and regions
LOAD CSV WITH HEADERS FROM 'file:///districts.csv' AS row
MATCH (dist:Districts {districtCOD: toInteger(row.COD)})
MATCH (reg:Regions {regionCOD: toInteger(row.REGION)})
MERGE (dist)-[:REGION]->(reg);
