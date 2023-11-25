------------------------------------ Задание №1
create or replace procedure U1_RNA_PDB.GET_TEACHERS(PCODE TEACHER.PULPIT%TYPE)
    is
    cursor GetTeachers is select TEACHER, TEACHER_NAME, PULPIT
                          from TEACHER
                          where PULPIT = PCODE;
    m_teacher      TEACHER.TEACHER%TYPE;
    m_teacher_name TEACHER.TEACHER_NAME%TYPE;
    m_pulpit       TEACHER.PULPIT%TYPE;
begin
    open GetTeachers;
    fetch GetTeachers into m_teacher, m_teacher_name, m_pulpit;
    DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);

    while (GetTeachers%found)
        loop
            DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
            fetch GetTeachers into m_teacher, m_teacher_name, m_pulpit;
        end loop;
    close GetTeachers;
end GET_TEACHERS;

begin
    GET_TEACHERS('ИСиТ');
end;

------------------------------------ Задание №2
create or replace function U1_RNA_PDB.GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE)
return number
is
    result_num number;
begin
    select count(TEACHER) into result_num from TEACHER where PULPIT=PCODE;
    return result_num;
end GET_NUM_TEACHERS;

begin
     DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('ИСиТ'));
end;

------------------------------------ Задание №3
create or replace procedure U1_RNA_PDB.GET_TEACHERS_BY_FACULTY (FCODE FACULTY.FACULTY%TYPE)
    is
    cursor GetTeachersByFaculty is
        select TEACHER, TEACHER_NAME, P.PULPIT
        from TEACHER inner join PULPIT P on P.PULPIT = TEACHER.PULPIT
        where FACULTY = FCODE;

    m_teacher      TEACHER.TEACHER%TYPE;
    m_teacher_name TEACHER.TEACHER_NAME%TYPE;
    m_pulpit       TEACHER.PULPIT%TYPE;
begin
    open GetTeachersByFaculty;
    fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;

    while (GetTeachersByFaculty%found)
    loop
        DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
        fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;
    end loop;

    close GetTeachersByFaculty;

end GET_TEACHERS_BY_FACULTY;

begin
    GET_TEACHERS_BY_FACULTY('ИДиП');
end;


create or replace procedure U1_RNA_PDB.GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
is
    cursor GetSubjects is
    select * from SUBJECT where PULPIT=PCODE;

    m_subject SUBJECT.SUBJECT%type;
    m_subject_name SUBJECT.SUBJECT_NAME%type;
    m_pulpit SUBJECT.PULPIT%type;
begin
    open GetSubjects;
    fetch GetSubjects into m_subject, m_subject_name, m_pulpit;

    while (GetSubjects%found)
    loop
        DBMS_OUTPUT.PUT_LINE(m_subject || ' ' || m_subject_name || ' ' || m_pulpit);
        fetch GetSubjects into m_subject, m_subject_name, m_pulpit;
    end loop;
    close GetSubjects;

end GET_SUBJECTS;

begin
    GET_SUBJECTS('ИСиТ');
end;

------------------------------------ Задание №4
create or replace function U1_RNA_PDB.FGET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
return number
is
    result_num number;
begin
    select count(TEACHER) into result_num from TEACHER
                          where TEACHER.PULPIT in (select PULPIT from PULPIT where FACULTY=FCODE);
    return result_num;
end FGET_NUM_TEACHERS;

begin
    DBMS_OUTPUT.PUT_LINE(FGET_NUM_TEACHERS('ИДиП'));
end;

create or replace function U1_RNA_PDB.GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) return number
is
    result_num number;
begin
    select count(SUBJECT) into result_num from SUBJECT where PULPIT=PCODE;
    return result_num;
end GET_NUM_SUBJECTS;

begin
    DBMS_OUTPUT.PUT_LINE(GET_NUM_SUBJECTS('ИСиТ'));
end;

------------------------------------ Задание №5
create or replace package TEACHERS as
  FCODE FACULTY.FACULTY%type;
  PCODE SUBJECT.PULPIT%type;
  procedure P_GET_TEACHERS(FCODE FACULTY.FACULTY%type);
  procedure P_GET_SUBJECTS (PCODE SUBJECT.PULPIT%type);
  function P_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type) return number;
  function P_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%type) return number;
end TEACHERS;

create or replace package body TEACHERS
is
    procedure P_GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
        is
        cursor GetTeachersByFaculty is
            select TEACHER, TEACHER_NAME, P.PULPIT
            from TEACHER
                     inner join PULPIT P on P.PULPIT = TEACHER.PULPIT
            where FACULTY = FCODE;
        m_teacher      TEACHER.TEACHER%TYPE;
        m_teacher_name TEACHER.TEACHER_NAME%TYPE;
        m_pulpit       TEACHER.PULPIT%TYPE;
    begin
        open GetTeachersByFaculty;
        fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;

        while (GetTeachersByFaculty%found)
            loop
                DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
                fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;
            end loop;

        close GetTeachersByFaculty;

    end P_GET_TEACHERS;
    procedure P_GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE)
        is
        cursor GetSubjects is
            select *
            from SUBJECT
            where PULPIT = PCODE;
        m_subject      SUBJECT.SUBJECT%type;
        m_subject_name SUBJECT.SUBJECT_NAME%type;
        m_pulpit       SUBJECT.PULPIT%type;
    begin
        open GetSubjects;
        fetch GetSubjects into m_subject, m_subject_name, m_pulpit;

        while (GetSubjects%found)
            loop
                DBMS_OUTPUT.PUT_LINE(m_subject || ' ' || m_subject_name || ' ' || m_pulpit);
                fetch GetSubjects into m_subject, m_subject_name, m_pulpit;
            end loop;
        close GetSubjects;

    end P_GET_SUBJECTS;
    function P_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
        return number
        is
        result_num number;
    begin
        select count(TEACHER)
        into result_num
        from TEACHER
        where TEACHER.PULPIT in (select PULPIT from PULPIT where FACULTY = FCODE);
        return result_num;
    end P_GET_NUM_TEACHERS;
    function P_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) return number
        is
        result_num number;
    begin
        select count(SUBJECT) into result_num from SUBJECT where PULPIT = PCODE;
        return result_num;
    end P_GET_NUM_SUBJECTS;
begin
    null;
end TEACHERS;

------------------------------------ Задание №6
begin
  DBMS_OUTPUT.PUT_LINE('Кол-во преподавателей на факультете: ' || TEACHERS.P_GET_NUM_TEACHERS('ИДиП'));
  DBMS_OUTPUT.PUT_LINE('Кол-во предметов на кафедре: ' || TEACHERS.P_GET_NUM_SUBJECTS('ИСиТ'));
  DBMS_OUTPUT.PUT_LINE('------------------------');
  TEACHERS.P_GET_TEACHERS('ИДиП');
  DBMS_OUTPUT.PUT_LINE('------------------------');
  TEACHERS.P_GET_SUBJECTS('ИСиТ');
end;