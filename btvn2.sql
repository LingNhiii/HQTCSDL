create database DeptEmp
go

use DeptEmp
go

create table Department
(
  DepartmentNo integer primary key,
  DepartmentName char(25) not null,
  Location char(25) not null
)

create table Employee
(
  EmpNo integer primary key,
  Fname varchar(15) not null,
  LName varchar(25) not null,
  Job varchar(25) not null,
  HireDate datetime not null,
  Salary numeric not null,
  Commision numeric,
  DepartmentNo integer foreign key(DepartmentNo) references Department(DepartmentNo) on update cascade on delete cascade
)

insert into Department
values
  (10, 'Accounting', 'Melbourne'),
  (20, 'Research', 'Adealide'),
  (30, 'Sales', 'Sydney'),
  (40, 'Operations', 'Perth')
select *
from Department

insert into Employee
values
  (1, 'John', 'Smith', 'Clerk', '1980-12-17', 800, null, 20),
  (2, 'Peter', 'Allen', 'Salesman', '1981-02-20', 1600, 300, 30),
  (3, 'Kate', 'Ward', 'Salesman', '1981-02-22', 1250, 500, 30),
  (4, 'Jack', 'Jones', 'Manager', '1981-04-02', 2975, null, 20),
  (5, 'Joe', 'Martin', 'Salesman', '1981-09-28', 1250, 1400, 30)
select *
from Employee




