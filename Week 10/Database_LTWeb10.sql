create database tuan10
go

use  tuan10
go

create table SanPham
(
	MaSP int primary key,
	TenSP nvarchar(50),
	DonGia decimal,
	HinhAnh varchar(100),
	MoTa nvarchar(200),
	SoLuongTon int
);

create table KhachHang
(
	MaKH int primary key,
	TenKH nvarchar(100),
	DiaChi nvarchar(100),
	SoDienThoai varchar(15),
	MatKhau varchar(20)
);

create table HoaDon
(
	MaHD int primary key,
	NgayHoaDon date,
	MaKH int,
	constraint FK_HD_KH foreign key (MAKH) references KhachHang(MAKH)
);

create table ChiTiet
(
	MaHD int,
	MaSP int,
	SoLuong int,
	primary key(MaHD, MaSP),
	constraint FK_CT_HD foreign key (MAHD) references HoaDon(MaHD),
	constraint FK_CT_SP foreign key (MASP) references SanPham(MaSP) 
);

select * from SanPham;

INSERT INTO SanPham(MaSP, TenSP, DonGia, HinhAnh, MoTa, SoLuongTon)
VALUES
(1, N'Lẽ Nào Em Không Biết', 64200, 'anh1.png', N'Sách văn học', 50),
(2, N'Đạo Tình', 77000, 'anh2.png', N'Tiểu thuyết tình cảm', 50),
(3, N'Em Là Nhà', 58800, 'anh3.png', N'Sách tình cảm', 50),
(4, N'Yêu', 52200, 'anh4.png', N'Sách văn học', 50),
(5, N'Khu Vườn Ngôn Từ', 71250, 'anh5.png', N'Truyện - light novel', 50),
(6, N'Kỳ Án Ánh Trăng', 115500, 'anh6.png', N'Truyện trinh thám', 50),
(7, N'Người Truyền Ký Ức', 49640, 'anh7.png', N'Truyện giả tưởng', 50),
(8, N'Cuộc Sống Không Giới Hạn', 74000, 'anh8.png', N'Sách phát triển bản thân', 50);

select * from SanPham;


INSERT INTO KhachHang(MaKH, TenKH, DiaChi, SoDienThoai, MatKhau)
VALUES
(1, N'Nguyễn Minh Long', N'TP. Hồ Chí Minh', '0909123456', '123456'),
(2, N'Lê Thị Thu Hà', N'Hà Nội', '0911222333', 'abcdef'),
(3, N'Phạm Quốc Trí', N'Đà Nẵng', '0988777666', 'matkhau'),
(4, N'Trần Thanh Tùng', N'Cần Thơ', '0977555444', '123abc');

INSERT INTO HoaDon(MaHD, NgayHoaDon, MaKH)
VALUES
(1, '2025-11-05', 1),
(2, '2025-11-05', 2),
(3, '2025-11-06', 3),
(4, '2025-11-06', 4);

INSERT INTO ChiTiet(MaHD, MaSP, SoLuong)
VALUES
-- Hóa đơn 1
(1, 1, 1),   
(1, 3, 2),   

-- Hóa đơn 2
(2, 2, 1),   
(2, 8, 1),  

-- Hóa đơn 3
(3, 6, 1),  
(3, 7, 1),   

-- Hóa đơn 4
(4, 4, 1),  
(4, 5, 1);   

select * from KhachHang;