create table z_btree_years
as select * from GTD12.years;

create table z_btree_programs
as select * from GTD12.programs;

create table z_btree_candidates
as select * from GTD12.candidates;

create table z_btree_students
as select * from GTD12.students;


alter table z_btree_programs add constraint z_btree_programs_code_pk primary key (code);
alter table z_btree_candidates add constraint z_btree_candidates_id_program_year_pk primary key (id, program, year);
alter table z_btree_students add constraint z_btree_students_nr_pk primary key (nr);
alter table z_btree_candidates add constraint z_btree_candidates_program_fk foreign key (program) references z_btree_programs(code);
alter table z_btree_students add constraint z_btree_students_program_fk foreign key (program) references z_btree_programs(code);
alter table z_btree_students add constraint z_btree_students_id_program_year_fk foreign key (id, program, enroll_year) references z_btree_candidates(id, program, year);


create index idx_btree_zcandidates_result on z_btree_candidates (result);