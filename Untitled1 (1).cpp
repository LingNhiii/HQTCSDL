--�? 4 CREATE DATABASE QLPDC
		 GO
			 USE QLPDC
				 GO

					 CREATE TABLE
					 PHIM(
						 MaPhim char(15) PRIMARY KEY,
						 TenPhim nvarchar(30) NOT NULL,
						 TheLoai nvarchar(15) NOT NULL,
						 TGPH date NOT NULL,
						 DonViSX nvarchar(30) NOT NULL)

						 CREATE TABLE GIAITHUONG(
							 MaGiaiThuong char(15) PRIMARY KEY,
							 TenGiaiThuong nvarchar(30) NOT NULL,
							 CongTyTT nvarchar(30) NOT NULL)

							 CREATE TABLE DECU(
								 MaPhim char(15) FOREIGN KEY(MaPhim) REFERENCES PHIM(MaPhim) ON DELETE CASCADE ON UPDATE CASCADE,
								 MaGiaiThuong char(15) FOREIGN KEY(MaGiaiThuong) REFERENCES GIAITHUONG(MaGiaiThuong) ON DELETE CASCADE ON UPDATE CASCADE,
								 TGDC date NOT NULL,
								 HangMuc nvarchar(30) NOT NULL,
								 KetQua nvarchar(30) NOT NULL,
								 PRIMARY KEY(MaPhim, MaGiaiThuong))

								 INSERT INTO PHIM VALUES('P1', N 'Phim th? nh?t', N 'T�nh c?m', '5/04/2022', N 'Vi?t Nam'),
	('P2', N 'Phim th? hai', N 'Kinh d?', '2/02/2022', N 'Vi?t Nam'),
	('P3', N 'Phim th? ba', N 'H�i k?ch', '4/10/2022', N 'Vi?t Nam')

		INSERT INTO GIAITHUONG VALUES('GT1', N 'GT th? nh?t', 'ABC'),
	('GT2', N 'GT th? hai', 'XYZ'),
	('GT3', N 'GT th? ba', 'BCD')

		INSERT INTO DECU VALUES('P1', 'GT1', '5/12/2022', N 'Phim hay', N '�?t gi?i'),
	('P1', 'GT2', '7/12/2022', N 'Phim xu?t s?c', N 'Kh�ng d?t gi?i'),
	('P2', 'GT1', '6/12/2022', N 'Phim hay', N '�?t gi?i'),
	('P2', 'GT3', '8/12/2022', N 'Phim xu?t s?c', N 'Kh�ng d?t gi?i'),
	('P3', 'GT2', '2/12/2022', N 'Phim hay', N 'Kh�ng �?t gi?i'),
	('P3', 'GT3', '1/12/2022', N 'Phim xu?t s?c', N '�?t gi?i')

		SELECT *FROM PHIM
	SELECT *FROM GIAITHUONG
	SELECT *FROM DECU

	-- cau2
	CREATE PROC SP_PHIMDECU
	AS
	BEGIN
	SELECT MaPhim,
	COUNT(MaGiaiThuong) AS SLDECU
	INTO BANGTAM
	FROM DECU
	GROUP BY MaPhim
	SELECT TenPhim
	FROM PHIM INNER JOIN BANGTAM ON
	PHIM.MaPhim = BANGTAM.MaPhim
				  WHERE SLDECU = (SELECT MAX(SLDECU) FROM BANGTAM)
		DROP TABLE BANGTAM
	END

	exec SP_PHIMDECU

	-- cau3
	CREATE TRIGGER tg_update
	ON DECU
	FOR UPDATE
	AS
	BEGIN
	IF(@ @ROWCOUNT > 1)
		BEGIN
	RAISERROR(N 'Kh�ng du?c update nhi?u d�ng', 16, 1)
		ROLLBACK TRANSACTION
	END
	ELSE IF UPDATE(MaPhim)
BEGIN
RAISERROR(N 'Kh�ng du?c update c?t M� Phim', 16, 1)
ROLLBACK TRANSACTION
	END
