------------------------------------ Задание №1
-- drop tablespace TS_RNA
create tablespace TS_RNA
  datafile 'TS_RNA.dbf'
  size 7M
  autoextend on next 5M
  maxsize 20M
  extent management local;


------------------------------------ Задание №2
-- drop tablespace TS_RNA_TEMP
create temporary tablespace TS_RNA_TEMP
  tempfile 'TS_RNA_TEMP.dbf'
  size 5M
  autoextend on next 3M
  maxsize 30M;


------------------------------------ Задание №3
select * from SYS.dba_tablespaces;
select * from SYS.dba_data_files;


------------------------------------ Задание №4
alter session set "_ORACLE_SCRIPT"=true;
create role RL_RNACORE;

grant connect, create session, create any table, drop any table, create any view,
drop any view, create any procedure, drop any procedure to RL_RNACORE;


------------------------------------ Задание №5
select * from dba_roles where ROLE like '%RL%';
select * from dba_sys_privs;
select * from dba_roles;

------------------------------------ Задание №6
create profile PF_RNACORE limit
  password_life_time 365
  sessions_per_user 5
  failed_login_attempts 5
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 45;

------------------------------------ Задание №7
select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles order by PROFILE;

select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles where PROFILE = 'PF_RNACORE';

select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles where PROFILE = 'DEFAULT';

------------------------------------ Задание №8
--drop user RNACORE
create user RNACORE identified by 12345
default tablespace TS_RNA quota unlimited on TS_RNA
temporary tablespace TS_RNA_TEMP
profile PF_RNACORE
account unlock
password expire;

grant RL_RNACORE to RNACORE;

------------------------------------ Задание №10
-- RNACORE
--drop table TEST_TABLE
create table TEST_TABLE
(
  x number(3),
  s varchar2(50)
);

insert all into TEST_TABLE values (1, 'a')
into TEST_TABLE values (2, 'b')
into TEST_TABLE values (3, 'c')
into TEST_TABLE values (4, 'd')
into TEST_TABLE values (5, 'e')
select * from dual;

select * from TEST_TABLE;

--drop view TEST_VIEW
create view TEST_VIEW as
select * from TEST_TABLE where x > 2 order by x desc;

select * from TEST_VIEW;

------------------------------------ Задание №11
-- SYSTEM
--drop tablespace RNA_QDATA including contents and datafiles
create tablespace RNA_QDATA
  datafile 'RNA_QDATA.dbf'
  size 10M
  offline;

select TABLESPACE_NAME, STATUS, CONTENTS from SYS.dba_tablespaces;

alter tablespace RNA_QDATA online;

alter user RNACORE quota 2M on RNA_QDATA;

-- RNACORE
create table RNA_T1
(
    xx number(2),
    ss varchar2(50)
) tablespace RNA_QDATA;

insert all into RNA_T1 values (11, 'aa')
into RNA_T1 values (22, 'bb')
into RNA_T1 values (33, 'cc')
select * from dual;

select * from RNA_T1;