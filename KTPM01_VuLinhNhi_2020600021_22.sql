use master
go
create database QLBH
on primary(
  name='QLBH_dat',
  filename='C:\Users\Asus\Contacts\Desktop\QLBH\QLBH.mdf',
  size=10MB,
  maxsize=100MB,
  filegrowth=10MB
)
log on(
  name='QLBH_log',
  filename='C:\Users\Asus\Contacts\Desktop\QLBH\QLBH.ldf',
  size=1MB,
  maxsize=5MB,
  filegrowth=20%
)
go
use QLBH
go
create table CongTy(
  MaCT nchar(10) not null primary key,
  TenCT nvarchar(20) not null,
  TrangThai nvarchar(20),
  ThanhPho nvarchar(20)
)
create table SanPham(
  MaSP nchar(10) not null primary key,
  TenSP nvarchar(20) not null,
  MauSac nchar(10) default N'Đỏ',
  Gia money,
  SoLuongCo int,
  constraint unique_SP unique(TenSP)
)
create table CungUng(
  MaCT nchar(10) not null,
  MaSP nchar(10) not null,
  SoLuongBan int,
  constraint pk_CU primary key(MaCT,MaSp),
  constraint chk_SLB check(SoLuongBan>0),
  constraint FK_CU_CT foreign key(MaCT)
    references CongTy(MaCT),
  constraint FK_CU_SP foreign key(MaSP)
    references SanPham(MaSP)
)

insert into CongTy values('1101001','Vinamilk','Open','HaNoi')
insert into CongTy values('1200300','VinGroup','Closed','HoChiMinh')
insert into CongTy values('2567980','Garena','Open','HaNoi')
select *from CongTy

insert into SanPham values('1001','MyHaoHao','Cam','3500','50')
insert into SanPham values('1052','KemDanhRangPS','Xanh','14000','20')
insert into SanPham(MaSP,TenSP,Gia,SoLuongCo) values('1121','ThitHop','35000','16')
select *from SanPham

insert into CungUng values('1101001','1001','7')
insert into CungUng values('1101001','1052','4')
insert into CungUng values('1200300','1001','6')
insert into CungUng values('1200300','1121','8')
insert into CungUng values('2567980','1052','15')
insert into CungUng values('2567980','1121','2')
select *from CungUng