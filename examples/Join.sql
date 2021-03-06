use downing_test;

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

/* -----------------------------------------------------------------------
Create
*/

create table Student (
    sID    int,
    sName  text,
    GPA    float,
    sizeHS int);

create table Apply (
    sID      int,
    cName    text,
    major    text,
    decision boolean);

create table College (
    cName      text,
    state      char(2),
    enrollment int);

/* -----------------------------------------------------------------------
Insert
*/

insert into Student values (123, 'Amy',    3.9,  1000);
insert into Student values (234, 'Bob',    3.6,  1500);
insert into Student values (320, 'Lori',   null, 2500);
insert into Student values (345, 'Craig',  3.5,   500);
insert into Student values (432, 'Kevin',  null, 1500);
insert into Student values (456, 'Doris',  3.9,  1000);
insert into Student values (543, 'Craig',  3.4,  2000);
insert into Student values (567, 'Edward', 2.9,  2000);
insert into Student values (654, 'Amy',    3.9,  1000);
insert into Student values (678, 'Fay',    3.8,   200);
insert into Student values (765, 'Jay',    2.9,  1500);
insert into Student values (789, 'Gary',   3.4,   800);
insert into Student values (876, 'Irene',  3.9,   400);
insert into Student values (987, 'Helen',  3.7,   800);

insert into Apply values (123, 'Berkeley', 'CS',             true);
insert into Apply values (123, 'Cornell',  'EE',             true);
insert into Apply values (123, 'Stanford', 'CS',             true);
insert into Apply values (123, 'Stanford', 'EE',             false);
insert into Apply values (234, 'Berkeley', 'biology',        false);
insert into Apply values (321, 'MIT',      'history',        false);
insert into Apply values (321, 'MIT',      'psychology',     true);
insert into Apply values (345, 'Cornell',  'bioengineering', false);
insert into Apply values (345, 'Cornell',  'CS',             true);
insert into Apply values (345, 'Cornell',  'EE',             false);
insert into Apply values (345, 'MIT',      'bioengineering', true);
insert into Apply values (543, 'MIT',       'CS',            false);
insert into Apply values (678, 'Stanford', 'history',        true);
insert into Apply values (765, 'Cornell',  'history',        false);
insert into Apply values (765, 'Cornell',  'psychology',     true);
insert into Apply values (765, 'Stanford', 'history',        true);
insert into Apply values (876, 'MIT',      'biology',        true);
insert into Apply values (876, 'MIT',      'marine biology', false);
insert into Apply values (876, 'Stanford', 'CS',             false);
insert into Apply values (987, 'Berkeley', 'CS',             true);
insert into Apply values (987, 'Stanford', 'CS',             true);

insert into College values ('Berkeley', 'CA', 36000);
insert into College values ('Cornell',  'NY', 21000);
insert into College values ('Irene',    'TX', 25000);
insert into College values ('MIT',      'MA', 10000);
insert into College values ('Stanford', 'CA', 15000);

/* -----------------------------------------------------------------------
Student cross join Apply
*/

select "Cross Join";

# select *
#     from Student, Apply;

select *
    from Student cross join Apply;

/* -----------------------------------------------------------------------
Student theta join[Student.sID = Apply.sID] Apply
*/

select "Theta Join";

# select *
#     from Student inner join Apply
#     where Student.sID = Apply.sID;

# select *
#     from Student
#     inner join Apply on Student.sID = Apply.sID;

select *
    from Student
    inner join Apply using (sID);

/* -----------------------------------------------------------------------
Student natural join Apply
*/

select "Natural Join";

select *
    from Student natural join Apply;

/* -----------------------------------------------------------------------
name and GPA of students
   with high school size > 1000,
   with major            = CS,
   with decision         = false

project[sName, GPA]
    (select[(sizeHS > 1000)     and
            (major = 'CS')      and
            (decision = false)]
        (Student join Apply))
*/

select *
    from Student
    inner join Apply using (sID)
    where (sizeHS > 1000) and (major = 'CS') and (decision = false);

select sName, GPA
    from Student
    inner join Apply using (sID)
    where (sizeHS > 1000) and (major = 'CS') and (decision = false);

/* -----------------------------------------------------------------------
name and GPA of students with
   with high school size > 500,
   with major            = CS,
   with decision         = false,
   with enrollment       > 20000

project[sName, GPA]
    (select[(sizeHS > 500)       and
           (major = 'CS')        and
           (decision = false)    and
           (enrollment > 20000)]
        (Student join Apply join College))
*/

select *
    from Student
        inner join Apply   using (sID)
        inner join College using (cName)
    where (sizeHS     > 500)   and
          (major      = 'CS')  and
          (decision   = true)  and
          (enrollment > 20000);

select sName, GPA
    from Student
        inner join Apply   using (sID)
        inner join College using (cName)
    where (sizeHS     > 500)   and
          (major      = 'CS')  and
          (decision   = true)  and
          (enrollment > 20000);

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

exit
