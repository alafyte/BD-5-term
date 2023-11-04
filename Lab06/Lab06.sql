------------------------------------ Задание №1
--C:\app\oracle_user\product\12.1.0\dbhome_1\NETWORK\ADMIN\sqlnet.ora
--C:\app\oracle_user\product\12.1.0\dbhome_1\NETWORK\ADMIN\tnsnames.ora


------------------------------------ Задание №2
select NAME, DESCRIPTION, VALUE from v$parameter;

------------------------------------ Задание №3
--conn system/oracle_user@//localhost:1521/RNA_PDB;
alter session set container=RNA_PDB;

select * from dba_tablespaces;
select TABLESPACE_NAME, FILE_NAME from dba_data_files;
select * from dba_roles;
select * from dba_users;

------------------------------------ Задание №4
--regedit


------------------------------------ Задание №5
--conn U1_RNA_PDB/54321@RNA_PDB;


------------------------------------ Задание №7
-- insert into RNA_table values (1, 'first');
-- insert into RNA_table values (3, 'third');
select * from RNA_TABLE;

------------------------------------ Задание №8
--help timing
--timi start;
--select * from dba_roles;
--timi stop;

------------------------------------ Задание №9
--desc
--desc RNA_TABLE;


------------------------------------ Задание №10
select * from user_segments;

------------------------------------ Задание №11
create view view_segments as
    select count(SEGMENT_NAME) segments_count, sum(EXTENTS) extents_count,
           sum(BLOCKS) bloks_count, sum(BYTES) memory_size
    from user_segments;
select * from view_segments;
