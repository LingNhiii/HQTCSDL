CREATE DATABASE QLBanHangThi
GO
USE QLBanHangThi
GO

CREATE TABLE CONGTY
(
	MaCT char(15) PRIMARY KEY,
	TenCT nvarchar(30) NOT NULL,
	trangthai nvarchar(30) NOT NULL,
	ThanhPho nvarchar(30) NOT NULL
)

CREATE TABLE SANPHAM
(
	MaSP char(15) PRIMARY KEY,
	TenSP nvarchar(30) NOT NULL,
	mausac nvarchar(15) NOT NULL,
	soluong int NOT NULL,
	giaban money NOT NULL
)

CREATE TABLE CUNGUNG
(
	MaCT char(15) FOREIGN KEY (MaCT) REFERENCES CONGTY(MaCT) ON UPDATE CASCADE ON DELETE CASCADE,
	MaSP char(15) FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP) ON UPDATE CASCADE ON DELETE CASCADE,
	SLCU int NOT NULL,
	NgayCU date,
	PRIMARY KEY(MaCT, MaSP)
)

INSERT INTO CONGTY VALUES
	('CT1', 'ABC', N'Hoạt Động', N'Hà nội'),
	('CT2', 'XYZ', N'Tạm Ngưng', N'Hồ Chí Minh'),
	('CT3', 'DEC', N'Hoạt Động', N'Đà Nẵng')

SELECT * FROM CONGTY

INSERT INTO SANPHAM VALUES
	('SP1', N'Sản phẩm 1', N'Đỏ', 10, 1000),
	('SP2', N'Sản phẩm 2', N'Xanh', 15, 2000),
	('SP3', N'Sản phẩm 3', N'Đen', 20, 3000)

SELECT * FROM SANPHAM

INSERT INTO CUNGUNG VALUES
	('CT1', 'SP1', 5, '2022/06/15'),
	('CT1', 'SP2', 10, '2022/06/16'),
	('CT2', 'SP1', 5, '2022/06/16'),
	('CT2', 'SP3', 20, '2022/06/17'),
	('CT3', 'SP2', 5, '2022/06/15')

SELECT * FROM CUNGUNG

--câu 2
create function fn_cau2(@TenCT nvarchar(30))
RETURNS money
AS
BEGIN
	DECLARE @tongTien money
	SET @tongTien = (SELECT sum(SLCU*giaban)
	FROM CUNGUNG INNER JOIN SANPHAM ON CUNGUNG.MaSP=SANPHAM.MaSP
	INNER JOIN CONGTY ON CUNGUNG.MaCT=CONGTY.MaCT
	WHERE TenCT=@TenCT)
	RETURN @tongTien
END

SELECT dbo.fn_cau2('ABC')

/*create FUNCTION cau_2(@TenCT nvarchar(30))
returns money
as 
BEGIN
    declare @tong money
    set @tong = (select sum( SLCU * giaban )
    from CUNGUNG inner join SANPHAM 
    on CUNGUNG.MaSP = SANPHAM.MaSP
    inner join CONGTY
    on CUNGUNG.MaCT = CONGTY.MaCT
    where TenCT = @TenCT)
    return @tong
END

SELECT dbo.cau_2('ABC')
*/

--cau3
CREATE proc cau3 (@masp char(15),
				@TenSP nvarchar(30),
				@mausac nvarchar(15),
				@soluong int,
				@giaban money)
AS
BEGIN
	IF(EXISTS(SELECT TenSP FROM SANPHAM WHERE TenSP=@TenSP))
		PRINT N'Sản phẩm đã tồn tại!'
	ELSE
		BEGIN
			INSERT INTO SANPHAM VALUES (@masp, @TenSP, @mausac, @soluong, @giaban)
		END
END

exec cau3 'SP4', N'Sản phẩm 4', N'Tím', 10, 2500

--cau 4
CREATE TRIGGER cau4
ON CUNGUNG
FOR INSERT
AS
	DECLARE @masp char(15)
	SELECT @masp = MaSP , @SLCU=SLCU
	FROM inserted
	SELECT @soluong= soluong FROM SANPHAM
	IF NOT EXISTS(SELECT 



/*
	--cau4
create trigger cau_4
on CUNGUNG
for insert
as
BEGIN
    declare @MaSP char(15)
    set @MaSP = (select MaSP from inserted)
    declare @SLCU INT
    set @SLCU = (select SLCU from inserted)
    declare @soluong int 
    set @soluong = (select soluong from SANPHAM  where MaSP = @MaSP)
    if(@SLCU <= @soluong)
        BEGIN
            declare @soluongmoi int
            set @soluongmoi = @soluong - @SLCU
            update SANPHAM set soluong = @soluongmoi where MaSP = @MaSP
        end
        
    else
        BEGIN
            RAISERROR(N'Số lượng cung ứng lơn hơn số lượng sản phẩm!', 16, 1)
            ROLLBACK TRANSACTION
        END
end

INSERT INTO CUNGUNG VALUES
	('CT3', 'SP1', 15, '2022/06/15')
select * from CUNGUNG
select * from SANPHAM

INSERT INTO CUNGUNG VALUES
	('CT3', 'SP3', 15, '2022/06/15')
select * from CUNGUNG
select * from SANPHAM
*/