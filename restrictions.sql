
/*Primary Keys*/

alter table yprograms add constraint yprograms_code_pk primary key (code);
alter table zprograms add constraint zprograms_code_pk primary key (code);

alter table ycandidates add constraint ycandidates_id_program_year_pk primary key (id, program, year);
alter table zcandidates add constraint zcandidates_id_program_year_pk primary key (id, program, year);

alter table ystudents add constraint ystudents_nr_pk primary key (nr);
alter table zstudents add constraint zstudents_nr_pk primary key (nr);


/*Foreign Keys*/

alter table ycandidates add constraint ycandidates_program_fk foreign key (program) references yprograms(code);
alter table zcandidates add constraint zcandidates_program_fk foreign key (program) references zprograms(code);

alter table ystudents add constraint ystudents_program_fk foreign key (program) references yprograms(code);
alter table zstudents add constraint zstudents_program_fk foreign key (program) references zprograms(code);

alter table ystudents add constraint ystudents_id_program_year_fk foreign key (id, program, enroll_year) references ycandidates(id, program, year);
alter table zstudents add constraint zstudents_id_program_year_fk foreign key (id, program, enroll_year) references zcandidates(id, program, year);