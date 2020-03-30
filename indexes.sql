create index students_program_status_conclusion_enroll on zstudents (program, status, conclusion_year - enroll_year) /*1*/

create index students_program_enroll_year on zstudents (id, program,enroll_year); /*3*/

create bitmap index candidates_result on zcandidates (result); /*5*/

create bitmap index candidates_program_year_result on zcandidates (program, year, result); /*6*/

create index students_program_enroll on zstudents (program, enroll_year) /*6*/


Drop index students_status_conclusion_enroll ;
Drop index students_id_program_enroll_year;
Drop index candidates_result;
Drop index candidates_program_year_result;
Drop index students_program_enroll;

