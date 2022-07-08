/*
create vw_cau3
as 
    select manv, count(mada)as 'soluongDA' from PHANCONG
        GROUP by manv */

/*câu 4
select tennv from NHANVIEN inner join vw_cau3 on NHANVIEN.manv = vw_cau3.manv where soluongDA = (select count(mada) from DUAN)
*/
/*cau5
create function fn_cau5(@manv nchar(10))
returns @bang table (
    manv kieudlcuamv,
    tennv kieudulieucuatennv,
    mada kdlmada,
    tenda kdltenda,
    nhiemvu kdlnhiemvu
)
as 
BEGIN
    insert into @bang
                select NHANVIEN.manv,tennv,mada,tenda,nhiemvu FROM NHANVIEN
                inner join PHANCONG ON PHANCONG.manv = NHANVIEN.manv
                inner join DUAN ON PHANCONG.mada = DUAN.mada
                where NHANVIEN.manv = @manv
        return 
end

*/