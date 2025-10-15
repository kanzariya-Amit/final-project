create database final_project;
use final_project;

create table student_table (
    student_id int primary key,
    first_name varchar(90),
    last_name varchar(90),
    email varchar(90),
    birthdate date,
    enrollmentdate date
);

insert into student_table (student_id, first_name, last_name, email, birthdate, enrollmentdate)
values
    (1, 'john', 'doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
    (2, 'jane', 'smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01'),
    (3, 'meet', 'aadeshara', 'meet.aadheshara@gmail.com', '2006-11-23', '2021-09-14'),
    (4, 'gippi', 'meggi', 'gippi.meggi@gmail.com', '2000-12-12', '2023-02-21'),
    (5, 'herit', 'tan', 'herit.tan@gmial.com', '1900-12-09', '2025-10-10'),
    (6, 'rutvik', 'makwana', 'rutvik.makwana@gmail.com', '1898-04-27', '2017-05-30');

create table course_table (
    course_id int primary key,
    course_name varchar(90),
    department_id int,
    credits int
);

insert into course_table (course_id, course_name, department_id, credits)
values
    (101, 'introduction to sql', 1, 3),
    (102, 'data strucures', 2, 4),
    (103, 'python', 3, 5),
    (104, 'html', 4, 6),
    (105, 'css', 5, 7),
    (106, 'c++', 6, 8);

create table instructors_table (
    instructor_id int primary key,
    first_name varchar(90),
    last_name varchar(90),
    email varchar(90),
    department_id int
);

insert into instructors_table (instructor_id, first_name, last_name, email, department_id)
values
    (1, 'alice', 'johnson', 'alice.johnson@univ.com', 11),
    (2, 'bob', 'lee', 'bob.lee@univ.com', 12),
    (3, 'anjali', 'patel', 'anjali.patel@univ.com', 13),
    (4, 'meera', 'patel', 'meera.parel@univ.com', 14),
    (5, 'anu', 'tan', 'anu.tan@univ.com', 15),
    (6, 'mitu', 'kanzariya', 'mitu.kanzariya@univ.com', 16);


create table enrollments_table (
    enrollment_id int,
    student_id int,
    course_id int,
    enrollmentdate date
);

insert into enrollments_table (enrollment_id, student_id, course_id, enrollmentdate)
values
    (1, 1, 101, '2022-08-01'),
    (2, 2, 102, '2021-08-01'),
    (3, 3, 103, '2021-09-09'),
    (4, 4, 104, '2025-09-08'),
    (5, 5, 105, '2020-11-11'),
    (6, 6, 106, '2020-05-05');

create table departments_table (
    department_id int,
    department_name varchar(90)
);

insert into departments_table (department_id, department_name)
values
    (1, 'computer science'),
    (2, 'mathematics'),
    (3, 'science'),
    (4, 'gujrati'),
    (5, 'social science'),
    (6, 'hindi');

select * from student_table;
select * from course_table;
select * from instructors_table;
select * from enrollments_table;
select * from departments_table;

update student_table
set email = 'john.d.new@email.com'
where student_id = 1;

update course_table
set credits = 4
where course_name = 'introduction to sql';

select student_id, first_name, last_name, enrollmentdate
from student_table
where year(enrollmentdate) > 2022;

select t1.course_id, t1.course_name
from course_table as t1
join departments_table as t2 on t1.department_id = t2.department_id
where t2.department_name = 'mathematics'
limit 5;

select t2.course_name, count(t1.student_id) as student_count
from enrollments_table as t1
join course_table as t2 on t1.course_id = t2.course_id
group by t2.course_name
having count(t1.student_id) > 5;

select t1.student_id, t1.first_name, t1.last_name
from student_table as t1
join enrollments_table as t2 on t1.student_id = t2.student_id
join course_table as t3 on t2.course_id = t3.course_id
where t3.course_name in ('introduction to sql', 'data strucures')
group by t1.student_id, t1.first_name, t1.last_name
having count(distinct t3.course_name) = 2;

select distinct t1.student_id, t1.first_name, t1.last_name
from student_table as t1
join enrollments_table as t2 on t1.student_id = t2.student_id
join course_table as t3 on t2.course_id = t3.course_id
where t3.course_name in ('introduction to sql', 'data strucures');

select avg(credits) as average_credits
from course_table;

select t1.instructor_id, t1.first_name, t1.last_name
from instructors_table as t1
join departments_table as t2 on t1.department_id = t2.department_id
where t2.department_name = 'computer science';

select max(t1.instructor_id) as max_instructor_id
from instructors_table as t1
where t1.department_id in (
select department_id from departments_table where department_name = 'computer science'
);

select t3.department_name, count(distinct t1.student_id) as student_count
from enrollments_table as t1
join course_table as t2 on t1.course_id = t2.course_id
join departments_table as t3 on t2.department_id = t3.department_id
group by t3.department_name order by student_count desc;

select t1.student_id, t1.first_name, t1.last_name, t3.course_name
from student_table as t1
inner join enrollments_table as t2 on t1.student_id = t2.student_id
inner join course_table as t3 on t2.course_id = t3.course_id;

select t1.student_id, t1.first_name, t1.last_name, t3.course_name
from student_table as t1
left join enrollments_table as t2 on t1.student_id = t2.student_id
left join course_table as t3 on t2.course_id = t3.course_id;

select t1.student_id, t1.first_name, t1.last_name
from student_table as t1
where t1.student_id in (select student_id from enrollments_table
    where course_id in (select course_id
        from enrollments_table group by course_id having count(student_id) > 10
    )
);

select student_id, first_name, last_name, enrollmentdate,
   year(enrollmentdate) as enrollment_year from student_table;

select instructor_id, concat(first_name, ' ', last_name) as full_name from instructors_table;

select enrollment_id, student_id, course_id,
    row_number() over (order by enrollment_id) as enrollment_order,
    count(student_id) over (order by enrollment_id) as running_total_students
from enrollments_table order by enrollment_id;

select student_id, first_name, last_name, enrollmentdate,
    case
        when enrollmentdate < date_sub(curdate(), interval 4 year) then 'senior'
        else 'junior'
    end as enrollment_status
from student_table;
