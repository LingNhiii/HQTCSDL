CREATE DATABASE QLPDC
GO
USE QLPDC
GO

CREATE TABLE PHIM
(
	MaPhim nvarchar(15) PRIMARY KEY,
	TenPhim nvarchar(30) NOT NULL,
	TheLoai nvarchar(30) NOT NULL,
	NamPhatHanh int NOT NULL,
	DonViSX nvarchar(30) DEFAULT N'Hãng phim Việt Nam'
)

CREATE TABLE GIAITHUONG
(
	MaGiaiThuong nvarchar(15) PRIMARY KEY CONSTRAINT magt_check CHECK (MaGiaiThuong LIKE 'GT%'),
	TenGiaiThuong nvarchar(30) NOT NULL,
	CongTyTaiTro nvarchar(30) NOT NULL,
)

CREATE TABLE DECU
(
	MaPhim nvarchar(15) FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim) ON UPDATE CASCADE ON DELETE CASCADE,
	MaGiaiThuong nvarchar(15) FOREIGN KEY (MaGiaiThuong) REFERENCES GIAITHUONG(MaGiaiThuong) ON UPDATE CASCADE ON DELETE CASCADE,
	HangMuc nvarchar(30) NOT NULL,
	KetQua nvarchar(15) NOT NULL,
	PRIMARY KEY(MaPhim,MaGiaiThuong)
)
INSERT INTO PHIM(MaPhim,TenPhim,TheLoai,NamPhatHanh) VALUES
	('001',N'Hoa vàng', N'Tình cảm', 2022),
	('002',N'Nắng hồng', N'Trinh thám', 2020),
	('003',N'Buông', N'Kinh dị', 2021)

SELECT * FROM PHIM

INSERT INTO GIAITHUONG VALUES
	('GT001', N'Bông sen vàng', 'CTX'),
	('GT002', N'Hoa mai vàng', 'CTY'),
	('GT003', N'Cây hoa hồng', 'CTZ')

SELECT * FROM GIAITHUONG

INSERT INTO DECU VALUES
	('001', 'GT001', N'Phim tài liệu', N'Đạt giải'),
	('001', 'GT002', N'Phim tài liệu', N'Không đạt giải'),
	('002', 'GT001', N'Phim tình cảm', N'Không đạt giải'),
	('002', 'GT003', N'Phim tình cảm', N'Đạt giải'),
	('003', 'GT002', N'Phim kinh dị', N'Đạt giải'),
	('003', 'GT003', N'Phim kinh dị', N'Không đạt giải')

SELECT * FROM DECU

--câu 2
SELECT TenPhim FROM PHIM INNER JOIN DECU ON PHIM.MaPhim=DECU.MaPhim
	INNER JOIN GIAITHUONG ON DECU.MaGiaiThuong=GIAITHUONG.MaGiaiThuong
	WHERE TenPhim LIKE 'H%' AND TenGiaiThuong= N'Bông sen vàng' AND HangMuc= N'Phim tài liệu'


--câu 3
CREATE VIEW vw_cau3 
AS 
SELECT PHIM.DonViSX, COUNT(PHIM.MaPhim) AS SoLuongPhim FROM PHIM INNER JOIN DECU ON PHIM.MaPhim=DECU.MaPhim
	GROUP BY PHIM.DonViSX

SELECT * FROM vw_cau3

--câu 4
SELECT DonViSX FROM vw_cau3 GROUP BY DonViSX HAVING COUNT(SoLuongPhim) = (SELECT MIN(SoLuongPhim) FROM vw_cau3)

--câu5
CREATE FUNCTION fn_cau5(@donvisx nvarchar(30))
RETURNS @bang table (
	DonViSX nvarchar(30),
	MaPhim nvarchar(15),
	TenPhim nvarchar(30),
	MaGiaiThuong nvarchar(15),
	TenGiaiThuong nvarchar(30),
	KetQua nvarchar(15)
)
AS
BEGIN
	INSERT INTO @bang
				SELECT DonViSX, PHIM.MaPhim, TenPhim, GIAITHUONG.MaGiaiThuong, TenGiaiThuong, KetQua
				FROM PHIM INNER JOIN DECU ON PHIM.MaPhim=DECU.MaPhim 
				INNER JOIN GIAITHUONG ON DECU.MaGiaiThuong=GIAITHUONG.MaGiaiThuong
				WHERE DonViSX=@donvisx
		RETURN 
END

SELECT * FROM dbo.fn_cau5(N'Hãng phim Việt Nam')