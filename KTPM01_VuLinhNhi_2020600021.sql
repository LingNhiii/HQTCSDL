create database QLBH
go

use QLBH
go

create table HangSX
(
  MaHangSX char(10) primary key,
  TenHang nvarchar(30) not null,
  DiaChi nvarchar(50) not null,
  SoDT varchar(11),
  Email varchar(40)
)

create table SanPham
(
  MaSP char(10) primary key,
  MaHangSX char(10) foreign key(MaHangSX) references HangSX(MaHangSX) on update cascade on delete cascade,
  TenSP nvarchar(30) not null,
  SoLuong int,
  MauSac nvarchar(10),
  GiaBan money,
  DonViTinh nvarchar(20),
  MoTa nvarchar(100)
)

alter table SanPham add DonViTinh nvarchar(20)

alter table SanPham
  alter column MaHangSX varchar(9)
-- khong chay duoc do con vuong rang buoc khoa ngoai tren cot

select *
from SanPham
drop table SanPham

create table NhanVien
(
  MaNV char(10) primary key,
  TenNV nvarchar(30) not null,
  GioiTinh bit,
  DiaChi nvarchar(100) not null,
  SoDT varchar(11) not null unique,
  Email varchar(40),
  TenPhong nvarchar(20) not null
)

create table PNhap
(
  SoHDN char(10) primary key,
  NgayNhap date,
  MaNV char(10) foreign key(MaNV) references NhanVien(MaNV) on update cascade on delete cascade
)

create table Nhap
(
  SoHDN char(10) foreign key(SoHDN) references PNhap(SoHDN) on update cascade on delete cascade,
  MaSP char(10) foreign key(MaSP) references SanPham(MaSP) on update cascade on delete cascade,
  SoLuongN int not null,
  DonGiaN money not null
    primary key(SoHDN, MaSP)
)

create table PXuat
(
  SoHDX char(10) primary key,
  NgayXuat date not null,
  MaNV char(10) foreign key(MaNV) references NhanVien(MaNV) on update cascade on delete cascade
)

create table Xuat
(
  SoHDX char(10) foreign key(SoHDX) references PXuat(SoHDX) on update cascade on delete cascade,
  MaSP char(10) foreign key(MaSP) references SanPham(MaSP) on update cascade on delete cascade,
  SoLuongX int
    primary key(SoHDX, MaSP)
)

insert into HangSX
values('HSX01', N'Hải Hà', N'Hà Nội', '01234567', 'haiha@ht.vn')
insert into HangSX
values('HSX02', 'Hải Châu', 'Hà Nội', '0247896', 'hc@gmail.com')
insert into HangSX
values
  ('HSX03', N'Tiền Phong', N'Hà Nội', '02847896', 'tc@gmail.com'),
  ('HSX04', N'Phong Châu', N'Hà Nội', '02467896', 'pc@gmail.com')
select *
from HangSX

select *
from HangSX
where DiaChi = N'Hà Nội'

update HangSX
set TenHang = N'Hải Châu',
  DiaChi = N'Hà Nội'
where MaHangSX = 'HSX02'

update HangSX
set DiaChi = N'Hồ Chí Minh'

delete from HangSX
where DiaChi = N'Hà Nội'

delete from HangSX

insert into SanPham
values
  ('SP01', 'HSX01', N'Kẹo dẻo', 20, N'đỏ', 20000, N'Gói', N'cho trẻ em'),
  ('SP02', 'HSX01', N'Kẹo cứng', 10, N'trắng', 20000, N'Gói', N'cho trẻ em'),
  ('SP03', 'HSX03', N'Bút bi', 10, N'đỏ', 10000, N'Chiếc', N'cho trẻ em'),
  ('SP04', 'HSX03', N'Bút mực', 30, N'đỏ', 10000, N'Hộp', N'cho trẻ em')
select *
from SanPham

insert into NhanVien
values
  ('NV01', N'Phạm Văn Hà', 0, N'Hà Nội', '0123344', 'ha@gmail.com', N'Hành chính')
insert into NhanVien
values
  ('NV02', N'Phạm Thị Hải', 1, N'Hà Nội', '0126734', 'hai@gmail.com', N'Kinh doanh'),
  ('NV03', N'Phạm Thị A', 1, N'Hà Nam', '0155734', 'pc@gmail.com', N'Nhân sự'),
  ('NV04', N'Phạm Thị B', 0, N'Hà Nội', '0122234', 'hi@gmail.com', N'Kinh doanh')
select *
from NhanVien

insert into PNhap
values
  ('HDN01', '2022-03-15', 'NV02'),
  ('HDN02', '2022-07-25', 'NV03'),
  ('HDN03', '2022-03-03', 'NV01'),
  ('HDN04', '2022-04-15', 'NV04')
select getdate()
--Hàm trả về ngày tháng hiện tại của hệ thống
select *
from PNhap

insert into PXuat
values
  ('HDX01', '2021-03-15', 'NV01'),
  ('HDX02', '2020-07-25', 'NV02'),
  ('HDX03', '2022-04-03', 'NV01'),
  ('HDX04', '2022-04-15', 'NV04')
select *
from PXuat

insert into Nhap
values
  ('HDN01', 'SP01', 3, 5000),
  ('HDN02', 'SP03', 5, 2000),
  ('HDN03', 'SP04', 7, 6000),
  ('HDN04', 'SP04', 1, 5000)
select *
from Nhap

insert into Xuat
values
  ('HDX01', 'SP04', 7),
  ('HDX02', 'SP02', 8),
  ('HDX03', 'SP02', 9),
  ('HDX04', 'SP01', 3)
select *
from Xuat

select 
