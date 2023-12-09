alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

alter system set JOB_QUEUE_PROCESSES = 5;
select count(*) from dba_objects_ae where Object_Type = 'PACKAGE';

------------------------------------ Задание №1
--drop table LAB_14;
--drop table LAB_14_TO;
--drop table job_status;

create table LAB_14
(
    a number,
    b number
);
create table LAB_14_TO
(
    a number,
    b number
);

create table job_status
(
    status        nvarchar2(50),
    error_message nvarchar2(500),
    datetime      date default sysdate
);

insert into LAB_14 values (1, 6);
insert into LAB_14 values (8, 2);
insert into LAB_14 values (9, 68);
insert into LAB_14 values (41, 12);
insert into LAB_14 values (3, 77);
insert into LAB_14 values (122, 4);
insert into LAB_14 values (661, 44);
insert into LAB_14 values (341, 61);
insert into LAB_14 values (1, 0);
commit;
select * from LAB_14;

------------------------------------ Задание №2, 3
--drop procedure job_procedure;
create or replace procedure job_procedure
is
    cursor job_cursor is
    select * from LAB_14;

    err_message varchar2(500);
begin
    for m in job_cursor
    loop
        insert into LAB_14_TO values (m.a, m.b);
    end loop;

    delete from LAB_14;
    insert into job_status (status, datetime) values ('SUCCESS', sysdate);
    commit;
    exception
      when others then
          err_message := sqlerrm;
          insert into job_status (status, error_message) values ('FAILURE', err_message);
          commit;
end job_procedure;


declare job_number user_jobs.job%type;
begin
  dbms_job.submit(job_number, 'BEGIN job_procedure(); END;', sysdate, 'sysdate + 7');
  commit;
  dbms_output.put_line(job_number);
end;

select * from JOB_STATUS;

------------------------------------ Задание №4
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

------------------------------------ Задание №5
begin
  dbms_job.run(22);
end;

begin
  dbms_job.remove(22);
end;


select * from JOB_STATUS;

------------------------------------ Задание №6
begin
dbms_scheduler.create_schedule(
  schedule_name => 'SCH_1',
  start_date => sysdate,
  repeat_interval => 'FREQ=WEEKLY',
  comments => 'SCH_1 WEEKLY starts now'
);
end;

select * from user_scheduler_schedules;

begin
dbms_scheduler.create_program(
  program_name => 'PROGRAM_1',
  program_type => 'STORED_PROCEDURE',
  program_action => 'job_procedure',
  number_of_arguments => 0,
  enabled => true,
  comments => 'PROGRAM_1'
);
end;

select * from user_scheduler_programs;


begin
    dbms_scheduler.create_job(
            job_name => 'JOB_1',
            program_name => 'PROGRAM_1',
            schedule_name => 'SCH_1',
            enabled => true
        );
end;

select * from user_scheduler_jobs;

begin
  DBMS_SCHEDULER.DISABLE('JOB_1');
end;

begin
    DBMS_SCHEDULER.RUN_JOB('JOB_1');
end;


begin
  DBMS_SCHEDULER.DROP_JOB( JOB_NAME => 'JOB_1');
end;


