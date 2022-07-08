use QLBH

/*1. Tạo trigger kiểm soát việc nhập dữ liệu cho bảng nhập, hãy kiểm tra các ràng buộc MaSP có trong bảng sản phẩm chưa? Kiểm tra các ràng buộc dữ liệu: SoLuongN và DonGia>0.
Sau khi nhập thì SoLuong ở bảng SanPham sẽ được cập nhật theo */

CREATE TRIGGER TG_CHENDLNHAP
ON NHAP
FOR INSERT 
AS 
DECLARE @maSP char(10), @soLuongNhap int, @donGiaNhap money
SELECT @maSP=MaSP, @soLuongNhap=SoLuongN, @donGiaNhap=DonGiaN
FROM inserted
--kiểm tra xem có MAsp trong bảng sản phẩm chưa?
IF NOT EXISTS(SELECT * FROM SanPham WHERE MaSP=@maSP)
BEGIN
	PRINT N'KHÔNG CÓ SẢN PHẨM TRONG BẢNG SẢN PHẨM'
	ROLLBACK TRANSACTION 
END
ELSE 
	IF (@soLuongNhap <= 0 OR @donGiaNhap<=0)
	BEGIN 
		PRINT N'SỐ LƯỢNG NHẬP VÀ ĐƠN GIÁ NHẬP PHẢI LỚN HƠN 0'
		ROLLBACK TRANSACTION
	END
	ELSE
	UPDATE SanPham
	SET SoLuong=SoLuong+@soLuongNhap
	WHERE MaSP=@maSP

--THỰC THI TRIGGER
--TH1: KHÔNG CÓ SẢN PHẨM TRONG BẢNG SẢN PHẨM
ALTER TABLE Nhap NOCHECK CONSTRAINT ALL /*(bỏ hết các ràng buộc đã thiết lập)*/
INSERT INTO Nhap VALUES('HDN01','SP10', 20, 2000)
--TH2: SỐ LƯỢNG NHẬP <=0
INSERT INTO Nhap VALUES('HDN01', 'SP01', 0,2000)
--TH3: ĐƠN GIÁ NHẬP <=0
INSERT INTO Nhap VALUES('HDN01', 'SP01', 20,0)
--TH4: CHÈN THÀNH CÔNG.
SELECT * FROM SanPham
SELECT * FROM Nhap
INSERT INTO Nhap VALUES('HDN01', 'SP01', 20, 20000)
SELECT * FROM Nhap
SELECT * FROM NhanVien

/*2.Tạo trigger kiểm soát việc nhập dữ liệu cho bảng xuất, hãy kiểm tra các ràng buộc toàn vẹn: MaSP có trong bảng sản phẩm chưa?
Kiểm tra các ràng buộc dữ liệu: SoLuongX <= SoLuong trong bảng SanPham?
Sau khi xuất thì SoLuong ở bảng sản phẩm sẽ được cập nhật theo?*/

CREATE TRIGGER TG_CHENDLXUAT
ON XUAT
FOR INSERT 
AS 
DECLARE @maSP char(10), @soLuongXuat int, @soLuongCo int
SELECT @maSP=MaSP, @soLuongXuat=SoLuongX
FROM inserted
SELECT @soLuongCo=SoLuong FROM SanPham 
--kiểm tra xem có MaSP trong bảng sản phẩm chưa?
IF NOT EXISTS(SELECT * FROM SanPham WHERE MaSP=@maSP)
BEGIN
	/*RAISERROR('N KHÔNG CÓ SẢN PHẨM TRONG BẢNG SẢN PHẨM',16,1) (dùng lệnh này thay print cũng được)*/
	PRINT N'KHÔNG CÓ SẢN PHẨM TRONG BẢNG SẢN PHẨM'
	ROLLBACK TRANSACTION 
END
ELSE 
	IF (@soLuongXuat>@soLuongCo)
	BEGIN 
		PRINT N'SỐ LƯỢNG XUẤT PHẢI NHỎ HƠN HOẶC BẰNG SỐ LƯỢNG CÓ'
		ROLLBACK TRANSACTION
	END
	ELSE
	UPDATE SanPham
	SET SoLuong=SoLuong-@soLuongXuat
	WHERE MaSP=@maSP
--THỰC THI TRIGGER
--TH1: KHÔNG CÓ SẢN PHẨM TRONG BẢNG SẢN PHẨM
ALTER TABLE Xuat NOCHECK CONSTRAINT ALL
INSERT INTO Xuat VALUES('HDX01','SP10',20)
--TH2: SỐ LƯỢNG XUẤT LỚN HƠN SỐ LƯỢNG CÓ
INSERT INTO Xuat VALUES('HDX01','SP01',20000)
--TH3l CHÈN THÀNH CÔNG CẬP NHẬT LẠI SỐ LƯỢNG CÓ TRONG BẢNG SẢN PHẨM
SELECT * FROM Xuat
SELECT * FROM SanPham
INSERT INTO Xuat VALUES('HDX01','SP01',40)
SELECT * FROM Xuat
SELECT * FROM SanPham

/*3.Tạo trigger kiểm soát việc xóa dòng dữ liệu bảng xuất
khi một dòng bảng xuất xóa thì số lượng hàng trong bảng Sanpham sẽ được cập nhật tăng lên*/
CREATE TRIGGER TG_XOAXUAT
ON XUAT
FROM DELETE
AS
DECLARE @soLuongXuat int, @maSP char(10)
SELECT @soLuongXuat=SoLuongX, @maSP=MaSP
FROM deleted
UPDATE SanPham
SET SoLuong





/*Tạo trigger cho việc cập nhật lại số lượng xuất trong bảng xuất,
nếu số bản ghi thay đổi lớn hơn 1 thì thông báo ko được thay đổi
hãy kiểm tra xem số lượng xuất thay đổi có nhỏ hơn SoLuong trong bảng SanPham hay không?
nếu thỏa mãn thì cho phép update bảng xuất và update lại SoLuong trong bảng SanPham*/
CREATE TRIGGER TG_CAPNHATXUAT
ON Xuat
FOR UPDATE 
AS 
DECLARE @soLuongXuatMoi int, @soLuongXuatCu int, @maSP char(10), @soLuongCo int
IF(@@GROWCOUNT>1)
BEGIN
	PRINT N'KHÔNG ĐƯỢC CẬP NHẬT HƠN 1 DÒNG'
	ROLLBACK TRANSACTION 
END
SELECT @soLuongXuatMoi=SoLuongX, @maSP=MaSP
FROM inserted
SELECT @soLuongXuatCu=SoLuongX
FROM deleted
SELECT @S