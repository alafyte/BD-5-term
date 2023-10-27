------------------------------------ Задание №1
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;

------------------------------------ Задание №2
drop tablespace RNA_QDATA including contents and datafiles;
create tablespace RNA_QDATA
  datafile 'RNA_QDATA.dbf'
  size 10M
  offline;

alter tablespace RNA_QDATA online;

alter user RNACORE quota 2M on RNA_QDATA;

--RNACORE
-- drop table RNA_T1
create table RNA_T1 (
    x int primary key,
    s varchar2(50)
) tablespace RNA_QDATA;

insert all
    into RNA_T1 values (1, 'z')
    into RNA_T1 values (2, 'y')
    into RNA_T1 values (3, 'x')
select * from dual;

------------------------------------ Задание №3
select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BYTES, blocks, extents
from USER_SEGMENTS
where TABLESPACE_NAME='RNA_QDATA';

select * from USER_SEGMENTS;

------------------------------------ Задание №4
drop table RNA_T1;
select * from USER_SEGMENTS where TABLESPACE_NAME='RNA_QDATA';

select * from USER_RECYCLEBIN;
--purge table RNA_T1;

------------------------------------ Задание №5
flashback table RNA_T1 to before drop;

------------------------------------ Задание №6
begin
  for x in 4..10004
  loop
    insert into RNA_T1 values(x, 'str');
  end loop;
end;

select count(*) from RNA_T1;

------------------------------------ Задание №7
select * from USER_SEGMENTS;
select * from USER_EXTENTS;

------------------------------------ Задание №8
--SYSTEM
drop tablespace RNA_QDATA including contents and datafiles;

------------------------------------ Задание №9
select * from V$LOG order by GROUP#;

------------------------------------ Задание №10
select * from V$LOGFILE order by GROUP#;

------------------------------------ Задание №11
alter system switch logfile;
select * from V$LOG order by GROUP#;

------------------------------------ Задание №12
alter database add logfile
    group 4
    'C:\app\oracle_user\oradata\orcl\REDO04.LOG'
    size 50m
    blocksize 512;

alter database add logfile
    member
    'C:\app\oracle_user\oradata\orcl\REDO04_1.LOG'
    to group 4;

alter database add logfile
    member
    'C:\app\oracle_user\oradata\orcl\REDO04_2.LOG'
    to group 4;

select * from V$LOG order by GROUP#;
select GROUP#, MEMBER from V$LOGFILE order by GROUP#;

------------------------------------ Задание №13
--alter system checkpoint;
alter database drop logfile member 'C:\app\oracle_user\oradata\orcl\REDO04_2.LOG';
alter database drop logfile member 'C:\app\oracle_user\oradata\orcl\REDO04_1.LOG';
alter database drop logfile group 4;

select * from V$LOG order by GROUP#;
select * from V$LOGFILE order by GROUP#;

------------------------------------ Задание №14
--LOG_MODE = NOARCHIVELOG; ARCHIVER = STOPPED
select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

------------------------------------ Задание №15
select * from V$ARCHIVED_LOG;

------------------------------------ Задание №16
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

------------------------------------ Задание №17
alter system set LOG_ARCHIVE_DEST_1 ='LOCATION=C:\app\oracle_user\oradata\orcl\Archive';
select * from V$ARCHIVED_LOG;
alter system switch logfile;
select * from V$LOG order by GROUP#;

------------------------------------ Задание №18
-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

select DBID, name, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

------------------------------------ Задание №19
select * from V$CONTROLFILE;


------------------------------------ Задание №20
--show parameter control;
select * from V$CONTROLFILE_RECORD_SECTION;


------------------------------------ Задание №21
--show parameter spfile;
select NAME, DESCRIPTION from V$PARAMETER;


------------------------------------ Задание №22
create pfile = 'RNA_PFILE.ora' from spfile;


------------------------------------ Задание №23
--show parameter remote_login_passwordfile;
select * from V$PWFILE_USERS;

------------------------------------ Задание №24
select * from V$DIAG_INFO;

------------------------------------ Задание №25
-- C:\app\oracle_user\diag\rdbms\orcl\orcl\alert\log.xml
--log sequence