create database MarkManagement
go

use MarkManagement
go

create table Students
(
  StudentID nvarchar(12) primary key,
  StudentName nvarchar(25) not null,
  DateOfBirth datetime not null,
  Email nvarchar(40),
  Phone nvarchar(12),
  Class nvarchar(10)
)

create table Subjects
(
  SubjectID nvarchar(10) primary key,
  SubjectName nvarchar(25) not null
)

create table Mark
(
  StudentID nvarchar(12) foreign key(StudentID) references Students(StudentID) on update cascade on delete cascade,
  SubjectID nvarchar(10) foreign key(SubjectID) references Subjects(SubjectID) on update cascade on delete cascade,
  Theory tinyint,
  Practical tinyint,
  Date datetime,
  primary key(StudentID, SubjectID)
)

insert into Students
values
  ('AV0807005', N'Mai Trung Hiếu', '1989-10-11', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
  ('AV0807006', N'Nguyễn Quý Hùng', '1988-12-02', 'quyhung@yahoo.com', '0909565116', 'AV2'),
  ('AV0807007', N'Đỗ Đắc Huỳnh', '1990-01-02', 'dachuynh@yahoo.com', '0904115167', 'AV2'),
  ('AV0807009', N'An Đăng Khuê', '1986-03-06', 'dangkhue@yahoo.com', '0904115189', 'AV1'),
  ('AV0807010', N'Nguyễn T. Tuyết Lan', '1989-07-12', 'tuyetlan@yahoo.com', '0934515116', 'AV2'),
  ('AV0807011', N'Đinh Phụng Long', '1990-12-02', 'phunglong@yahoo.com', '', 'AV1'),
  ('AV0807012', N'Nguyễn Tuấn Nam', '1990-03-02', 'tuannam@yahoo.com', '', 'AV1')
select *
from Students

insert into Subjects
values
  ('S001', 'SQL'),
  ('S002', 'Java Simplefield'),
  ('S003', 'Active Server Page')
select *
from Subjects

insert into Mark
values
  ('AV0807005', 'S001', 8, 25, '2008-05-06'),
  ('AV0807006', 'S002', 16, 30, '2008-05-06'),
  ('AV0807007', 'S001', 10, 25, '2008-05-06'),
  ('AV0807009', 'S003', 7, 13, '2008-05-06'),
  ('AV0807010', 'S003', 9, 16, '2008-05-06'),
  ('AV0807011', 'S002', 8, 30, '2008-05-06'),
  ('AV0807012', 'S001', 7, 31, '2008-05-06'),
  ('AV0807005', 'S002', 12, 11, '2008-06-06'),
  ('AV0807010', 'S001', 7, 6, '2008-06-06')
select *
from Mark





