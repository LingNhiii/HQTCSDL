CREATE DATABASE QLBH
ON ( 
	NAME = QLBH,
	FILENAME = 'D:\QLBH.mdf',
	SIZE = 50MB,
	MAXSIZE = 200MB,
	FILEGROWTH = 10MB )
LOG ON (
	NAME = QLVT_log,
	FILENAME = 'D:\QLBH.ldf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 5MB )
USE QLBH
GO
--Cau1a--
CREATE VIEW vw_Cau1
as
SELECT Nhap.SoHDN, SanPham.MaSP, TenSP, SoLuongN, DonGiaN, NgayNhap, TenNV, TenPhong
FROM Nhap INNER JOIN SanPham on Nhap.MaSP= SanPham.MaSP
INNER JOIN PNhap on Nhap.SoHDN=PNhap.SoHDN
INNER JOIN NhanVien on PNhap.MaNV=NhanVien.MaNV
INNER JOIN HangSX on SanPham.MaHangSX=HangSX.MaHangSX
WHERE TenHang='Samsung' And Year(NgayNhap)=2017

--Câu 1b--
CREATE VIEW vw_Cau2
as
SELECT MaSP, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
FROM SanPham INNER JOIN HangSX on SanPham.MaHangSX=HangSX
Where TenHang='Samsung' And GiaBan Between 100.000 And 500.000

--Câu c--
CREATE VIEW vw_Cau3
as
Select Sum(SoLuongN*DonGiaN) As N'Tổng tiền nhập'
From Nhap INNER JOIN SanPham on Nhap.MaSP = SanPHam.MaSP 
INNER JOIN HangSX on SanPham.MaHangSX = HangSX.MaHangSX
INNER JOIN PNhap on Nhap.SoHDN=PNhap.SoHDN
Where YEAR(NgayNhap) = 2020 And TenHang='Samsung'

--Câu d--
CREATE VIEW vw_Cau4
as
Select Sum(SoLuongX*GiaBan) As N'Tổng tiền xuất'
FROM Xuat INNER JOIN SanPham on Xuat.MaSP = SanPham.MaSP
INNER JOIN PXuat on Xuat.SoHDX=PXuat.SoHDX
where NgayXuat='06/14/2020'

--Câu e--
CREATE VIEW vw_Cau5
as
Select Nhap.SoHDN, NgayNhap
FROM Nhap INNER JOIN PNhap on Nhap.SoHDN=PNhap.SoHDN
Where Year(NgayNhap)=2020 And SoLuongN*DonGiaN = (Select MAX(SoLuongN*DonGiaN)
From Nhap INNER JOIN PNhap on Nhap.SoHDN=PNhap.SoHDN
Where Year(NgayNhap)=2020)

--Câu f--
CREATE VIEW vw_Cau6
as
Select HangSX.MaHangSX, TenHang, Count(*) As N'Số lượng sp'
From SanPham INNER JOIN HangSX on SanPham.MaHangSX=HangSX.MaHangSX
Group by HangSX.MaHangSX, TenHang

--Câu g--
CREATE VIEW vw_Cau7
as
Select SanPham.MaSP, TenSP, sum(SoLuongN*DonGiaN) As N'Tổng tiền nhập'
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP
Inner join PNhap on PNhap.SoHDN=Nhap.SoHDN
Where Year(NgayXuat)=2018 And TenHang='Samsung'
Group by SanPham.MaSP, TenSP
Having Sum(SoLuongX)>=10000