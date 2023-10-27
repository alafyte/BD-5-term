------------------------------------ Задание №1
select SUM(VALUE) TOTAL_SGA_IN_BYTES from v$sga;

------------------------------------ Задание №2
select NAME POOL_NAME, VALUE SIZE_IN_BYTES from v$sga;

------------------------------------ Задание №3
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components;

------------------------------------ Задание №4
select CURRENT_SIZE from v$sga_dynamic_free_memory;

------------------------------------ Задание №5
select name, value from V$PARAMETER where name in ('sga_target', 'sga_max_size');

------------------------------------ Задание №6
select COMPONENT, MIN_SIZE, MAX_SIZE, CURRENT_SIZE from v$sga_dynamic_components
where COMPONENT in ('KEEP buffer cache', 'RECYCLE buffer cache', 'DEFAULT buffer cache');

------------------------------------ Задание №7
create table KEEP_POOL_TABLE (num number) storage (buffer_pool keep);
insert into KEEP_POOL_TABLE values (1);
insert into KEEP_POOL_TABLE values (2);
insert into KEEP_POOL_TABLE values (3);
commit;

select * from KEEP_POOL_TABLE;
select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
from user_segments where segment_name like 'KEEP%';

------------------------------------ Задание №8
create table DEFAULT_CACHE_TABLE (num number) storage (buffer_pool default);
insert into DEFAULT_CACHE_TABLE values (4);
insert into DEFAULT_CACHE_TABLE values (5);

select * from DEFAULT_CACHE_TABLE;
select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
from user_segments where segment_name like 'DEFAULT_CACHE%';

------------------------------------ Задание №9
--show parameter log_buffer;

------------------------------------ Задание №10
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

------------------------------------ Задание №11
select SID, STATUS, SERVER, LOGON_TIME, PROGRAM, OSUSER, MACHINE, USERNAME, STATE
from v$session
where STATUS = 'ACTIVE';

------------------------------------ Задание №12
select sid, process, name, description, program
from v$session s join v$bgprocess using (paddr)
where s.status = 'ACTIVE';

------------------------------------ Задание №13
select * from v$process;

------------------------------------ Задание №14
--show parameter db_writer_processes;
select * from v$process where pname like 'DBW%';

------------------------------------ Задание №15
select NAME, NETWORK_NAME, PDB from v$services;

------------------------------------ Задание №16
select * from V$DISPATCHER;
--show parameter DISPATCHERS;

------------------------------------ Задание №17
-- services.msc -> OracleOraDB12Home1TNSListener

------------------------------------ Задание №18
-- C:\app\oracle_user\product\12.1.0\dbhome_1\NETWORK\ADMIN\listener.ora

------------------------------------ Задание №19
-- start, stop, status, services, version, reload, save_config, trace, quit, exit, set, show

------------------------------------ Задание №20
-- lsnrctl -> services