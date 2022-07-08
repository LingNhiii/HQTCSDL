/* Cho CSDL
NXB(MaNXB, TenNXB)
TACGIA(MaTG, TenTG)
SACH(MaSach, TenSach,NamXB, SoLuong, DonGia, MaTG, MaNXB)
1.Tạo View Thống kê số lượng xuất bản theo từng NXB gồm các thông tin: MaNXB, TenNXB, Tổng số lượng sách. Tạo test cho view.
2. Tạo 1 hàm đưa ra mã sách, tên sách, tên tác giả, đơn giá với đầu vào là tên nhà xuất bản và năm xuất bản và năm xuất bản từ năm x tới năm y. Tạo test cho hàm.
3. Tạo thủ tục để tìm kiếm sách theo tên tác giả và năm xuất bản. Kiểm tra nếu không có sách có tên tác giả đó thì đưa ra thống báo. Nếu có sẽ trả về danh sách các thông tin bao gồm: MaSach, TenSach, NamXB, SoLuong, DonGia. Tạo test cho thủ tục.
4. Tạo trigger update bảng Sách. Biết: - Không cho phép Update trường MaSach 
										- Số lượng sách không được tạo quá 100
										Tạo test cho trigger
*/

CREATE DATABASE QLSACH
GO
USE QLSACH
GO
CREATE TABLE NXB
(
	MaNXB nvarchar(15) PRIMARY KEY,
	TenNXB nvarchar(30) NOT NULL
)
CREATE TABLE TACGIA
(
	MaTG nvarchar(15) PRIMARY KEY,
	TenTG nvarchar(30) NOT NULL
)
CREATE TABLE SACH
(
	MaSach nvarchar(15) PRIMARY KEY,
	TenSach nvarchar(30) NOT NULL,
	NamXB date,
	SoLuong int,
	DonGia money,
	MaTG nvarchar(15) FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG) ON UPDATE CASCADE ON DELETE CASCADE,
	MaNXB nvarchar(15) FOREIGN KEY (MaNXB) REFERENCES NXB(MaNXB) ON UPDATE CASCADE ON DELETE CASCADE
)
INSERT INTO NXB VALUES 
	('NXB01', 'abc'),
	('NXB02', 'xyz'),
	('NXB03', 'ikm')
SELECT * FROM NXB

INSERT INTO TACGIA VALUES
	('TG01', N'Nguyễn Văn A'),
	('TG02', N'Nguyễn Thị B'),
	('TG03', N'Nguyễn Văn C')
SELECT * FROM TACGIA

INSERT INTO SACH VALUES
	('S1', 'Sach1', '2019', 5, '10000', 'TG01', 'NXB01'),
	('S2', 'Sach2', '2022', 15, '20000', 'TG02', 'NXB02'),
	('S3', 'Sach3', '2022', 25, '40000', 'TG03', 'NXB03')
SELECT * FROM SACH
drop table SACH
--CÂU 1
CREATE VIEW vw_cau1
AS 
SELECT NXB.MaNXB, TenNXB, SUM(SoLuong) AS N'TỔNG SỐ LƯỢNG SÁCH' FROM NXB INNER JOIN SACH ON NXB.MaNXB = SACH.MaNXB
GROUP BY NXB.MaNXB, TenNXB

SELECT * FROM vw_cau1

--CÂU 2
CREATE FUNCTION fn_cau2(@tennxb nvarchar(30), @x date, @y date )
RETURNS @bang table (
	MaSach nvarchar(15),
	TenSach nvarchar(30),
	TenTG nvarchar(30),
	DonGia money
) 
AS
BEGIN
	INSERT INTO @bang
			SELECT MaSach, TenSach, TenTG, DonGia 
			FROM TACGIA INNER JOIN SACH ON TACGIA.MaTG = SACH.MaTG
			INNER JOIN NXB ON SACH.MaNXB=NXB.MaNXB
			WHERE TenNXB = @tennxb AND NamXB BETWEEN @x ANd @y
		RETURN 
END

SELECT * FROM dbo.fn_cau2('abc', '2018', '2020')

--Câu 3

CREATE PROCEDURE pro_cau3 (@tenTG nvarchar(30), @namXB date)
AS
BEGIN
	IF (NOT EXISTS (SELECT * FROM SACH INNER JOIN TACGIA ON SACH.MaSach = TACGIA.MaTG WHERE TenTG=@tenTG))
	BEGIN
	PRINT N'Không có thông tin sách này'
	End
	ELSE
	SELECT MaSach, TenSach, NamXB, SoLuong,DonGia
	FROM SACH INNER JOIN TACGIA ON SACH.MaTG= TACGIA.MaTG
	WHERE TenTG= @tenTG And NamXB = @namXB
END

pro_cau3 @tenTG = N'Nguyễn Văn A', @namXB = '2022' 


--Câu 4

CREATE TRIGGER Cau4
ON SACH
FOR UPDATE
AS BEGIN
	DECLARE @SLSau int
	SELECT @SLSau=SoLuong FROM inserted
	IF UPDATE (MaSach)
	BEGIN
		RAISERROR (N'KHÔNG ĐƯỢC UPDATE MÃ SÁCH', 16,1)
		ROLLBACK TRANSACTION
	END
	ELSE IF(@SLSau>100)
	BEGIN 
		RAISERROR(N'SỐ LƯỢNG SÁCH UPDATE KHÔNG ĐƯỢC QUÁ 100', 16,1)
		ROLLBACK TRANSACTION
	END
END
UPDATE SACH
SET SoLuong =110 FROM SACH
WHERE MaSach=('S1')
SELECT * FROM SACH
/*phải có các trường hợp test. có bao nhiều if thì có bấy nhiều trường hợp test
sửa lại kiểu dữ liệu của namxb thành int
*/
