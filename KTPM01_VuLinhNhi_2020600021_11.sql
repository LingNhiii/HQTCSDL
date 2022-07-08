use master
go
create database QLSV
on primary(
  name='QLSV_dat',
  filename='Desktop/Hệ CSDL\QLSV\QLSV.mdf',
  size=10MB,
  maxsize=100MB,
  filegrowth=10MB
)
log on (
  name='QLSV_log',
  filename='/Desktop/Hệ QTCSDL\QLSV\QLSV.ldf',
  size=1MB,
  maxsize=5MB,
  filegrowth=20%
)
go
use QLSV
go
create table SV
(
  MaSV nchar(10) not null primary key,
  TenSV nvarchar(30) not null,
  Que nvarchar(20),
)
create table MON
(
  MaMH nchar(10) not null primary key,
  TenMH nvarchar(30) not null,
  Sotc int default(3),
  constraint chk_Sotc check(Sotc>=2 and Sotc<=5),
  constraint unique_MH unique(TenMH)
)
create table KQ
(
  MaSV nchar(10) not null,
  MaMH nchar(10) not null,
  Diem float,
  constraint PK_KQ primary key(MaSV,MaMH),
  constraint chk_Diem check(Diem>=0 and Diem <=10),
  constraint FK_KQ_SV foreign key(MaSV)
    references SV(MaSV),
  constraint FK_KQ_MON foreign key(MaMH)
    references MON(MaMH)
)
insert into SV
values('2020602002', 'Pham Tran Linh Chi', 'Ha Noi')
insert into SV
values('2020560412', 'Vu Linh Nhi', 'Ninh Binh')
insert into SV
values('2020605092', 'Ha Phuong Thao', 'Phu Tho')

insert into MON
values('IT1', 'Toán', 3)
insert into MON
  (MaMH,TenMH)
values('IT2', 'Lập trình hướng đối tượng')
insert into MON
values('IT3', 'Cơ sở dữ liệu', 2)


insert into KQ
  (MaSV,MaMH,Diem)
values('2020602002', 'IT1', 6.25)
insert into KQ
values('2020602002', 'IT3', 7.5)
insert into KQ
values('2020560412', 'IT1', 4.0)
insert into KQ
values('2020560412', 'IT2', 6.5)
insert into KQ
values('2020605092', 'IT2', 4.25)
insert into KQ
values('2020605092', 'IT3', 5.75)

select*
from SV
select*
from MON
select*
from KQ
