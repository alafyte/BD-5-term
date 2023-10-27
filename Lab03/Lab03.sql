------------------------------------ Задание №1
select * from dba_pdbs;

------------------------------------ Задание №2
select * from v$instance;

------------------------------------ Задание №3
select * from SYS.PRODUCT_COMPONENT_VERSION;

create pluggable database RNA_PDB admin user pdb_admin identified by 1234
roles = (DBA) file_name_convert =('C:\app\oracle_user\oradata\orcl\pdbseed', 'C:\app\oracle_user\oradata\orcl\RNA_PDB');

alter pluggable database RNA_PDB open;


------------------------------------ Задание №5
select * from dba_pdbs;

------------------------------------ Задание №6
-- PDB
create tablespace TS_PDB_RNA
  datafile 'TS_PDB_RNA.dbf'
  size 7M
  autoextend on next 5M
  maxsize 20M
  extent management local;

create temporary tablespace TS_PDB_RNA_TEMP
  tempfile 'TS_PDB_RNA_TEMP.dbf'
  size 5M
  autoextend on next 3M
  maxsize 30M;

--drop role RL_PDB_RNACORE;
create role RL_PDB_RNACORE;

grant connect, create session, create any table, drop any table, create any view,
drop any view, create any procedure, drop any procedure to RL_PDB_RNACORE;

--drop profile PF_PDB_RNACORE;
create profile PF_PDB_RNACORE limit
  password_life_time 365
  sessions_per_user 5
  failed_login_attempts 5
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 45;

--drop user U1_RNA_PDB;
create user U1_RNA_PDB identified by 12345
default tablespace TS_PDB_RNA quota unlimited on TS_PDB_RNA
temporary tablespace TS_PDB_RNA_TEMP
profile PF_PDB_RNACORE
account unlock
password expire;

grant RL_PDB_RNACORE to U1_RNA_PDB;

------------------------------------ Задание №7
-- U1_RNA_PDB
create table RNA_table ( x number(2), y varchar(5));

insert into RNA_table values (1, 'first');
insert into RNA_table values (3, 'third');
commit;

select * from RNA_table;

------------------------------------ Задание №8
-- SYSTEM
select * from DBA_ROLES;
select * from DBA_PROFILES;
select * from ALL_USERS;

select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;

------------------------------------ Задание №9
-- CDB
create user C##RNA identified by 12345;
grant connect, create session, alter session, create any table,
drop any table to C##RNA container = all;
-- PDB
grant create session to C##RNA;


------------------------------------ Задание №13
alter pluggable database RNA_PDB close immediate;
drop pluggable database RNA_PDB including datafiles;
drop user C##RNA;

