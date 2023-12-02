grant create trigger, drop any trigger to U1_RNA_PDB;
alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';


------------------------------------ Задание №1
--drop table Task_Table

create table Task_Table
(
    a int primary key,
    b varchar(30)
);

------------------------------------ Задание №2
begin
    for i in 1..10
    loop
        insert into Task_Table values (i, 'a');
    end loop;
end;


-----------------------------------------------
select * from Task_Table;
insert into Task_Table values (55, 'xx');
update Task_Table set b = 'yy' where a = 55;
delete Task_Table where a = 55;
----------------------------------------------


------------------------------------ Задание №3, 4
create or replace trigger INSERT_TR_BEFORE_STATEMENT
    before insert
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_BEFORE_STATEMENT');
end;

create or replace trigger UPDATE_TR_BEFORE_STATEMENT
    before update
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_BEFORE_STATEMENT');
end;

create or replace trigger DELETE_TR_BEFORE_STATEMENT
    before delete
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_BEFORE_STATEMENT');
end;

------------------------------------ Задание №5
create or replace trigger INSERT_TR_BEFORE_ROW
    before insert
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_BEFORE_ROW');
end;

create or replace trigger UPDATE_TR_BEFORE_ROW
    before update
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_BEFORE_ROW');
end;

create or replace trigger DELETE_TR_BEFORE_ROW
    before delete
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_BEFORE_ROW');
end;

------------------------------------ Задание №6
create or replace trigger TRIGGER_DML
    before insert or update or delete
    on Task_Table
begin
    if INSERTING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_INSERT');
    ELSIF UPDATING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_UPDATE');
    ELSIF DELETING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_DELETE');
    end if;
end;

------------------------------------ Задание №7
create or replace trigger INSERT_TR_AFTER_STATEMENT
    after insert
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_AFTER_STATEMENT');
end;

create or replace trigger UPDATE_TR_AFTER_STATEMENT
    after update
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_AFTER_STATEMENT');
end;

create or replace trigger DELETE_TR_AFTER_STATEMENT
    after delete
    on Task_Table
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_AFTER_STATEMENT');
end;

------------------------------------ Задание №8
create or replace trigger INSERT_TR_AFTER_ROW
    after insert
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_AFTER_ROW');
end;

create or replace trigger UPDATE_TR_AFTER_ROW
    after update
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_AFTER_ROW');
end;

create or replace trigger DELETE_TR_AFTER_ROW
    after delete
    on Task_Table
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_AFTER_ROW');
end;

------------------------------------ Задание №9
create table AUDITS
(
    OperationDate date,
    OperationType varchar2(50),
    TriggerName   varchar2(50),
    Data          varchar2(40)
);

------------------------------------ Задание №10
create or replace trigger TRIGGER_BEFORE_AUDIT
    before insert or update or delete
    on Task_Table
    for each row
begin
    if inserting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - INSERT' );
         insert into AUDITS values (
                                    sysdate,
                                    'insert',
                                    'TRIGGER_BEFORE_AUDIT',
                                    :new.a || ' ' || :new.b
                                   );
    elsif updating then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - UPDATE' );
        insert into AUDITS values (
                                    sysdate,
                                    'update',
                                    'TRIGGER_BEFORE_AUDIT',
                                     :old.a || ' ' || :old.b || ' -> ' || :new.a || ' ' || :new.b
                                   );
    elsif deleting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - DELETE' );
         insert into AUDITS values (
                                    sysdate,
                                    'delete',
                                    'TRIGGER_BEFORE_AUDIT',
                                    :old.a || ' ' || :old.b
                                   );
    end if;
end;

create or replace trigger TRIGGER_AFTER_AUDIT
    after insert or update or delete
    on Task_Table
    for each row
begin
    if inserting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - INSERT' );
         insert into AUDITS values (
                                    sysdate,
                                    'insert',
                                    'TRIGGER_AFTER_AUDIT',
                                    :new.a || ' ' || :new.b
                                   );
    elsif updating then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - UPDATE' );
        insert into AUDITS values (
                                    sysdate,
                                    'update',
                                    'TRIGGER_AFTER_AUDIT',
                                     :old.a || ' ' || :old.b || ' -> ' || :new.a || ' ' || :new.b
                                   );
    elsif deleting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - DELETE' );
         insert into AUDITS values (
                                    sysdate,
                                    'delete',
                                    'TRIGGER_AFTER_AUDIT',
                                    :old.a || ' ' || :old.b
                                   );
    end if;
end;

select * from AUDITS;
--truncate table AUDITS;

------------------------------------ Задание №11
insert into Task_Table values (1, 'v');


------------------------------------ Задание №12
create table Task_Table
(
    a int primary key,
    b varchar(30)
);
drop table TASK_TABLE;

--drop trigger TRIGGER_PREVENT_TABLE_DROP
create or replace trigger TRIGGER_PREVENT_TABLE_DROP
    before drop
    on U1_RNA_PDB.schema
begin
    if DICTIONARY_OBJ_NAME = 'TASK_TABLE'
    then
        RAISE_APPLICATION_ERROR(-20000, 'You can not drop table TASK_TABLE.');
    end if;
end;

------------------------------------ Задание №13
drop table AUDITS;

------------------------------------ Задание №14
--drop view TASK_TABLE_VIEW;
create view TASK_TABLE_VIEW
as select * from TASK_TABLE;

create or replace trigger TRIGGER_INSTEAD_OF_INSERT
    instead of insert
    on TASK_TABLE_VIEW
begin
    if INSERTING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_INSTEAD_OF_INSERT');
        insert into TASK_TABLE values (100, 'www');
    end if;
end TRIGGER_INSTEAD_OF_INSERT;

select * from TASK_TABLE_VIEW;
insert into TASK_TABLE_VIEW values (111, 'eee');

