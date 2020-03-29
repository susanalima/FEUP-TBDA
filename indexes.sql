Create Index candidates_year on zcandidates (year);
Create index students_id_program_enroll_year on zstudents (id,program,enroll_year);

Create bitmap index candidates_result on zcandidates (result);
Create bitmap index students_status on zstudents (status);



Drop index candidates_year ;
Drop index students_enroll_year;
Drop index candidates_result;
Drop index students_status;
