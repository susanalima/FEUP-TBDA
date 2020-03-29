Create Index candidates_year on zcandidates (year);
Create index students_enroll_year on zstudents (enroll_year);

Create bitmap index candidates_result on zcandidates (result);
Create bitmap index candidates_status on zstudents (status);