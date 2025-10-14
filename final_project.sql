create database final_project;
use final_project;

create table student_table(
student_id int primary key,
first_name varchar(90),
last_name varchar(90),
email varchar(90),
birthdate date,
enrollmentdate date
);

insert into student_table(student_id,  first_name, last_name, email, birthdate, enrollmentdate)
values

  (1, 'john', 'doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
  (2, 'jane', 'smith', 'jane.smith@email.com', '1999-05-25','2021-08-01'),
  (3, 'meet', 'aadeshara', 'meet.aadheshara@gmail.com', '2006-11-23', '2021-09-14'),
  (4, 'gippi', 'meggi', 'gippi.meggi@gmail.com', '2000-12-12', '2023-02-21'),
  (5, 'herit', 'tan', 'herit.tan@gmial.com', '1900-12-09', '2025-10-10'),
  (6, 'rutvik', 'makwana', 'rutvik.makwana@gmail.com', '1898-04-27', '2017-05-30');
  










  
  