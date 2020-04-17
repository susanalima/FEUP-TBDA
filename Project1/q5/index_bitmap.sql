create table z_bitmap_years
as select * from GTD12.years;

create table z_bitmap_programs
as select * from GTD12.programs;

create table z_bitmap_candidates
as select * from GTD12.candidates;

create table z_bitmap_students
as select * from GTD12.students;


alter table z_bitmap_programs add constraint z_bitmap_programs_code_pk primary key (code);
alter table z_bitmap_candidates add constraint z_bitmap_candidates_id_program_year_pk primary key (id, program, year);
alter table z_bitmap_students add constraint z_bitmap_students_nr_pk primary key (nr);
alter table z_bitmap_candidates add constraint z_bitmap_candidates_program_fk foreign key (program) references z_bitmap_programs(code);
alter table z_bitmap_students add constraint z_bitmap_students_program_fk foreign key (program) references z_bitmap_programs(code);
alter table z_bitmap_students add constraint z_bitmap_students_id_program_year_fk foreign key (id, program, enroll_year) references z_bitmap_candidates(id, program, year);


create bitmap index idx_bitmap_zcandidates_result on z_bitmap_candidates (result);