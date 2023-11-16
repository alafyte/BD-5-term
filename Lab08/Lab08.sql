------------------------------------ Задание №1
begin
    null;
end;

------------------------------------ Задание №2
begin
    dbms_output.put_line('Hello, world');
end;

------------------------------------ Задание №3
declare
    x number(3) := 3;
    y number(3) := 0;
    z number(10, 2);
begin
    z := x / y;
    dbms_output.put_line('z = ' || z);
exception
    when others
        then dbms_output.put_line(sqlcode || ': error = ' || sqlerrm);
end;

------------------------------------ Задание №4
declare
    x number(3) := 3;
    y number(3) := 0;
    z number(10, 2);
begin
    dbms_output.put_line('x = ' || x || ', y = ' || y);
    begin
        z := x / y;
    exception
        when others
            then dbms_output.put_line('error = ' || sqlerrm);
    end;
    dbms_output.put_line('z = ' || z);
end;

------------------------------------ Задание №5
--show parameter plsql_warnings;
select name, value
from v$parameter
where name = 'plsql_warnings';
--alter system set plsql_warnings='ENABLE:INFORMATIONAL';


------------------------------------ Задание №6
select keyword
from v$reserved_words
where length = 1;


------------------------------------ Задание №7
select keyword
from v$reserved_words
where length > 1
order by keyword;


------------------------------------ Задание №8
select name, value
from v$parameter
where name like 'plsql%';
--show parameter plsql;


------------------------------------ Задание №9 (10-17)
declare
    t10     number(3)      := 50;
    t11     number(3)      := 15;
    sum_var number(10, 2);
    dwr     number(10, 2);
    t12     number(10, 2)  := 2.11;
    t13     number(10, -3) := 222999.45;
    t14     binary_float   := 123456789.123456789;
    t15     binary_double  := 123456789.123456789;
    t16     number(38, 10) := 12345E+10;
    t17     boolean        := true;
begin
    sum_var := t10 + t11;
    dwr := mod(t10, t11);

    dbms_output.put_line('t10 = ' || t10);
    dbms_output.put_line('t11 = ' || t11);
    dbms_output.put_line('remainder = ' || dwr);
    dbms_output.put_line('sum = ' || sum_var);
    dbms_output.put_line('fixed = ' || t12);
    dbms_output.put_line('rounded = ' || t13);
    dbms_output.put_line('binary float = ' || t14);
    dbms_output.put_line('binary double = ' || t15);
    dbms_output.put_line('E+10 = ' || t16);
    if t17
    then
        dbms_output.put_line('bool = ' || 'true');
    end if;
end;

------------------------------------ Задание №18
declare
    nm constant number       := 34;
    vc constant varchar2(10) := 'Varchar2';
    c           char(5)      := 'Char';
begin
    c := 'Nchar';
    dbms_output.put_line(nm);
    dbms_output.put_line(vc);
    dbms_output.put_line(c);
exception
    when others
        then dbms_output.put_line('error = ' || sqlerrm);
end;

------------------------------------ Задание №19
declare
    pulp u1_rna_pdb.pulpit.pulpit%type;
begin
    pulp := 'ПИ';
    dbms_output.put_line(pulp);
end;

------------------------------------ Задание №20
declare
    faculty_res u1_rna_pdb.faculty%rowtype;
begin
    faculty_res.faculty := 'ИТ';
    faculty_res.faculty_name := 'Факультет информационных технологий';
    dbms_output.put_line(faculty_res.faculty || ' - ' || faculty_res.faculty_name);
end;

------------------------------------ Задание №21, 22
declare
    x pls_integer := 6;
begin
    if x < 10 then
        dbms_output.put_line('x < 10');
    elsif x > 10 then
        dbms_output.put_line('x > 10');
    else
        dbms_output.put_line('x = 10');
    end if;
end;

------------------------------------ Задание №23
declare
    x pls_integer := 21;
begin
    case
        when x between 10 and 20 then dbms_output.put_line('10 <= x <= 20');
        when x between 21 and 40 then dbms_output.put_line('21 <= x <= 40');
        else dbms_output.put_line('else block');
        end case;
end;

------------------------------------ Задание №24
declare
    x pls_integer := 0;
begin
    dbms_output.put_line('LOOP: ');
    loop
        x := x + 2;
        dbms_output.put_line(x);
        exit when x >= 10;
    end loop;
end;

------------------------------------ Задание №25
declare
    x pls_integer := 5;
begin
    dbms_output.put_line('WHILE: ');
    while (x > 0)
        loop
            dbms_output.put_line(x);
            x := x - 1;
        end loop;
end;

------------------------------------ Задание №26
begin
    dbms_output.put_line('FOR: ');
    for k in 1..5
        loop
            dbms_output.put_line(k);
        end loop;
end;
