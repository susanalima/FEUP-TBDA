create index students_program_status_conclusion_enroll on zstudents (conclusion_year - enroll_year, status, program); /*1*/
create index students_id_program_enroll_year on zstudents (id, program,enroll_year); /*3*/
create bitmap index candidates_result on zcandidates (result); /*5*/
create bitmap index candidates_program_year_result on zcandidates (result, program, year); /*6*/
create index students_program_enroll on zstudents (program, enroll_year);
create index students_avg_conclusion_program on zstudents (final_average, conclusion_year, program); /*4*/


drop index students_program_status_conclusion_enroll ;
drop index students_id_program_enroll_year;
drop index candidates_result;
drop index candidates_program_year_result;
drop index students_program_enroll;
drop index students_avg_conclusion_program;

