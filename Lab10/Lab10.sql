alter session set nls_date_format = 'DD-MM-YYYY';

------------------------------------ Задание №1

alter table TEACHER
    add BIRTHDAY date;
alter table TEACHER
    add SALARY number;

update TEACHER
set BIRTHDAY = '12-02-1959'
where TEACHER = 'СМЛВ';
update TEACHER
set BIRTHDAY = '30-01-1987'
where TEACHER = 'АКНВЧ';
update TEACHER
set BIRTHDAY = '19-04-1991'
where TEACHER = 'КЛСНВ';
update TEACHER
set BIRTHDAY = '16-04-1964'
where TEACHER = 'ГРМН';
update TEACHER
set BIRTHDAY = '19-11-1988'
where TEACHER = 'ЛЩНК';
update TEACHER
set BIRTHDAY = '05-10-1966'
where TEACHER = 'БРКВЧ';
update TEACHER
set BIRTHDAY = '10-08-1976'
where TEACHER = 'ДДК';
update TEACHER
set BIRTHDAY = '11-09-1989'
where TEACHER = 'КБЛ';
update TEACHER
set BIRTHDAY = '24-12-1983'
where TEACHER = 'УРБ';
update TEACHER
set BIRTHDAY = '03-06-1990'
where TEACHER = 'РМНК';
update TEACHER
set BIRTHDAY = '10-05-1970'
where TEACHER = 'ПСТВЛВ';
update TEACHER
set BIRTHDAY = '26-10-1999'
where TEACHER = '?';
update TEACHER
set BIRTHDAY = '30-07-1984'
where TEACHER = 'ГРН';
update TEACHER
set BIRTHDAY = '11-03-1975'
where TEACHER = 'ЖЛК';
update TEACHER
set BIRTHDAY = '12-07-1969'
where TEACHER = 'БРТШВЧ';
update TEACHER
set BIRTHDAY = '26-02-1983'
where TEACHER = 'ЮДНКВ';
update TEACHER
set BIRTHDAY = '13-12-1991'
where TEACHER = 'БРНВСК';
update TEACHER
set BIRTHDAY = '20-01-1968'
where TEACHER = 'НВРВ';
update TEACHER
set BIRTHDAY = '21-12-1969'
where TEACHER = 'РВКЧ';
update TEACHER
set BIRTHDAY = '28-01-1975'
where TEACHER = 'ДМДК';
update TEACHER
set BIRTHDAY = '10-07-1983'
where TEACHER = 'МШКВСК';
update TEACHER
set BIRTHDAY = '08-10-1988'
where TEACHER = 'ЛБХ';
update TEACHER
set BIRTHDAY = '30-07-1984'
where TEACHER = 'ЗВГЦВ';
update TEACHER
set BIRTHDAY = '16-04-1964'
where TEACHER = 'БЗБРДВ';
update TEACHER
set BIRTHDAY = '12-05-1985'
where TEACHER = 'ПРКПЧК';
update TEACHER
set BIRTHDAY = '20-10-1980'
where TEACHER = 'НСКВЦ';
update TEACHER
set BIRTHDAY = '21-08-1990'
where TEACHER = 'МХВ';
update TEACHER
set BIRTHDAY = '13-08-1966'
where TEACHER = 'ЕЩНК';
update TEACHER
set BIRTHDAY = '11-11-1978'
where TEACHER = 'ЖРСК';

update TEACHER
set SALARY = 1030
where TEACHER = 'СМЛВ';
update TEACHER
set SALARY = 1030
where TEACHER = 'АКНВЧ';
update TEACHER
set SALARY = 980
where TEACHER = 'КЛСНВ';
update TEACHER
set SALARY = 1050
where TEACHER = 'ГРМН';
update TEACHER
set SALARY = 590
where TEACHER = 'ЛЩНК';
update TEACHER
set SALARY = 870
where TEACHER = 'БРКВЧ';
update TEACHER
set SALARY = 815
where TEACHER = 'ДДК';
update TEACHER
set SALARY = 995
where TEACHER = 'КБЛ';
update TEACHER
set SALARY = 1460
where TEACHER = 'УРБ';
update TEACHER
set SALARY = 1120
where TEACHER = 'РМНК';
update TEACHER
set SALARY = 1250
where TEACHER = 'ПСТВЛВ';
update TEACHER
set SALARY = 333
where TEACHER = '?';
update TEACHER
set SALARY = 1520
where TEACHER = 'ГРН';
update TEACHER
set SALARY = 1430
where TEACHER = 'ЖЛК';
update TEACHER
set SALARY = 900
where TEACHER = 'БРТШВЧ';
update TEACHER
set SALARY = 875
where TEACHER = 'ЮДНКВ';
update TEACHER
set SALARY = 970
where TEACHER = 'БРНВСК';
update TEACHER
set SALARY = 780
where TEACHER = 'НВРВ';
update TEACHER
set SALARY = 1150
where TEACHER = 'РВКЧ';
update TEACHER
set SALARY = 805
where TEACHER = 'ДМДК';
update TEACHER
set SALARY = 905
where TEACHER = 'МШКВСК';
update TEACHER
set SALARY = 1200
where TEACHER = 'ЛБХ';
update TEACHER
set SALARY = 1500
where TEACHER = 'ЗВГЦВ';
update TEACHER
set SALARY = 905
where TEACHER = 'БЗБРДВ';
update TEACHER
set SALARY = 715
where TEACHER = 'ПРКПЧК';
update TEACHER
set SALARY = 880
where TEACHER = 'НСКВЦ';
update TEACHER
set SALARY = 735
where TEACHER = 'МХВ';
update TEACHER
set SALARY = 595
where TEACHER = 'ЕЩНК';
update TEACHER
set SALARY = 850
where TEACHER = 'ЖРСК';


------------------------------------ Задание №2
select regexp_substr(teacher_name, '(\S+)', 1, 1) || ' ' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 2), 1, 1) || '. ' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 3), 1, 1) || '. ' as ФИО
from teacher;

------------------------------------ Задание №3
select *
from teacher
where TO_CHAR(birthday, 'd') = 2;

------------------------------------ Задание №4
--drop view next_month

create or replace view next_month as
select *
from TEACHER
where TO_CHAR(birthday, 'mm') =
      (select substr(to_char(trunc(last_day(sysdate)) + 1), 4, 2)
       from dual);

select *
from next_month;

------------------------------------ Задание №5
--drop view number_months
create or replace view number_months as
select to_char(birthday, 'Month') Месяц,
       count(*)                   Количество
from teacher
group by to_char(birthday, 'Month')
having count(*) >= 1
order by Количество desc;

select *
from number_months;

------------------------------------ Задание №6
declare
    cursor teacher_birthday
        return teacher%rowtype is
        select *
        from teacher
        where MOD((TO_CHAR(sysdate, 'yyyy') - TO_CHAR(birthday, 'yyyy') + 1), 10) = 0;
    v_teacher  TEACHER%rowtype;
begin
    open teacher_birthday;

    fetch teacher_birthday into v_teacher;

    while (teacher_birthday%found)
        loop
            dbms_output.put_line(v_teacher.teacher || ' ' || v_teacher.teacher_name || ' ' || v_teacher.pulpit || ' ' ||
                                 v_teacher.birthday || ' ' || v_teacher.salary);
            fetch teacher_birthday into v_teacher;
        end loop;

    close teacher_birthday;
end;

------------------------------------ Задание №7
declare
    cursor teachers_avg_salary is
        select pulpit, floor(avg(salary)) as AVG_SALARY
        from TEACHER
        group by pulpit;
    cursor faculty_avg_salary is
        select FACULTY, AVG(SALARY)
        from TEACHER
                 join PULPIT P on TEACHER.PULPIT = P.PULPIT
        group by FACULTY;
    cursor faculties_avg_salary is
        select AVG(SALARY)
        from TEACHER;
    m_pulpit  TEACHER.PULPIT%type;
    m_salary  TEACHER.SALARY%type;
    m_faculty PULPIT.FACULTY%type;
begin

    dbms_output.put_line('--------------- По кафедрам -----------------');
    open teachers_avg_salary;
    fetch teachers_avg_salary into m_pulpit, m_salary;

    while (teachers_avg_salary%found)
        loop
            dbms_output.put_line(m_pulpit || ' ' || m_salary);
            fetch teachers_avg_salary into m_pulpit, m_salary;
        end loop;
    close teachers_avg_salary;

    dbms_output.put_line('--------------- По факультетам -----------------');
    open faculty_avg_salary;
    fetch faculty_avg_salary into m_faculty, m_salary;

    while (faculty_avg_salary%found)
        loop
            dbms_output.put_line(m_faculty || ' ' || m_salary);
            fetch faculty_avg_salary into m_faculty, m_salary;
        end loop;
    close faculty_avg_salary;

    dbms_output.put_line('--------------- По всем факультетам -----------------');
    open faculties_avg_salary;
    fetch faculties_avg_salary into m_salary;
    dbms_output.put_line(round(m_salary, 2));
    close faculties_avg_salary;
end;

------------------------------------ Задание №8
declare
    type SupplierType is record (
        SupplierName varchar2(100),
        SupplierLocation varchar2(50)
        );
    type ProductType is record (
        ProductName varchar2(100),
        Price number,
        Quantity number,
        SupplierInfo SupplierType
        );
    product_info  ProductType;
    supplier_info SupplierType;

begin
    supplier_info := SupplierType('Поставщик 1', 'Минск');
    product_info := ProductType('Телевизор', 999.99, 100, supplier_info);

    dbms_output.put_line('Товар: ' || product_info.ProductName);
    dbms_output.put_line('Цена: $' || product_info.Price);
    dbms_output.put_line('Количество: ' || product_info.Quantity);
    dbms_output.put_line('Поставщик: ' || product_info.SupplierInfo.SupplierName);
    dbms_output.put_line('Город: ' || product_info.SupplierInfo.SupplierLocation);
end;

