------------------------------------ Задание №9
create table RNA_t (
  x number(3) primary key,
  s varchar(50)
);

------------------------------------ Задание №11
insert all
    into RNA_t (x, s) values (1, 'a')
    into RNA_t (x, s) values (2, 'b')
    into RNA_t (x, s) values (3, 'c')
select * from dual;
commit;

select * from RNA_T;
------------------------------------ Задание №12
update RNA_t set x = 22 where s = 'a';
update RNA_t set s = 'd' where x = 3;
commit;

------------------------------------ Задание №13
select count(*) Count_of_lines from RNA_t T where x > 2;

------------------------------------ Задание №14
delete RNA_t where x = 22;
commit;

------------------------------------ Задание №15
create table RNA_tl (
  x number(3),
  y number(3),
  z number(3),
  foreign key (x) references RNA_t (x)
);

insert all
  into RNA_tl (x, y, z) values (2, 4, 8)
  into RNA_tl (x, y, z) values (3, 8, 1)
select * from dual;
commit;

------------------------------------ Задание №16
select * from RNA_t left outer join RNA_tl on RNA_tl.x = RNA_t.x;
select * from RNA_t right outer join RNA_tl on RNA_tl.x = RNA_t.x;
select * from RNA_t join RNA_tl on RNA_tl.x = RNA_t.x;

------------------------------------ Задание №18
drop table RNA_tl;
drop table RNA_t;
