CREATE DATABASE QL_BANSACH;
GO
USE QL_BANSACH;
GO

-- 1. Bảng ChuDe
CREATE TABLE ChuDe (
    MaChuDe INT PRIMARY KEY NOT NULL,
    TenChuDe NVARCHAR(100) NOT NULL,
);
GO

-- 2. Bảng NhaXuatBan
CREATE TABLE NhaXuatBan (
    MaNXB INT NOT NULL,
    TenNXB NVARCHAR(200) NOT NULL,
    DiaChi NVARCHAR(255),
    DienThoai VARCHAR(15),
    CONSTRAINT PK_NhaXuatBan PRIMARY KEY (MaNXB)
);
GO

-- 3. Bảng TacGia
CREATE TABLE TacGia (
    MaTacGia INT NOT NULL,
    TenTacGia NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    TieuSu NVARCHAR(MAX),
    DienThoai VARCHAR(15),
    CONSTRAINT PK_TacGia PRIMARY KEY (MaTacGia)
);
GO

-- 4. Bảng KhachHang
CREATE TABLE KhachHang (
    MaKH INT NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    TaiKhoan VARCHAR(50) UNIQUE NOT NULL,
    MatKhau VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DiaChi NVARCHAR(255),
    DienThoai VARCHAR(15),
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    CONSTRAINT PK_KhachHang PRIMARY KEY (MaKH)
);
GO

-- 5. Bảng Sach 
CREATE TABLE Sach (
    MaSach INT NOT NULL,
    TenSach NVARCHAR(255) NOT NULL,
    GiaBan DECIMAL(18, 0) DEFAULT 0,
    MoTa NVARCHAR(MAX),
    AnhBia VARCHAR(255), -- Lưu đường dẫn đến file ảnh
    NgayCapNhat DATETIME,
    SoLuongTon INT DEFAULT 0,
    MaChuDe INT,
    MaNXB INT,
    CONSTRAINT PK_Sach PRIMARY KEY (MaSach),
    CONSTRAINT FK_Sach_ChuDe FOREIGN KEY (MaChuDe) REFERENCES ChuDe(MaChuDe),
    CONSTRAINT FK_Sach_NhaXuatBan FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB)
);
GO

-- 6. Bảng DonHang 
CREATE TABLE DonHang (
    MaDonHang INT NOT NULL,
    DaThanhToan BIT DEFAULT 0, -- 0: Chưa, 1: Đã thanh toán
    TinhTrangGiaoHang NVARCHAR(50),
    NgayDat DATETIME DEFAULT GETDATE(),
    NgayGiao DATETIME,
    MaKH INT,
    CONSTRAINT PK_DonHang PRIMARY KEY (MaDonHang),
    CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);
GO

-- 7. Bảng ChiTietDonHang
CREATE TABLE ChiTietDonHang (
    MaDonHang INT NOT NULL,
    MaSach INT NOT NULL,
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18, 0) NOT NULL,
    CONSTRAINT PK_ChiTietDonHang PRIMARY KEY (MaDonHang, MaSach),
    CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    CONSTRAINT FK_ChiTietDonHang_Sach FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);
GO

-- 8. Bảng ThamGia 
CREATE TABLE ThamGia (
    MaTacGia INT NOT NULL,
    MaSach INT NOT NULL,
    VaiTro NVARCHAR(50),
    ViTri NVARCHAR(50),
    CONSTRAINT PK_ThamGia PRIMARY KEY (MaTacGia, MaSach),
    CONSTRAINT FK_ThamGia_TacGia FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia),
    CONSTRAINT FK_ThamGia_Sach FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);
GO

-- 1. Thêm dữ liệu cho bảng ChuDe
INSERT INTO ChuDe (MaChuDe, TenChuDe) VALUES
(1, N'Âm nhạc'),
(2, N'Công nghệ thông tin'),
(3, N'Danh nhân'),
(4, N'Du lịch'),
(5, N'Khoa học kỹ thuật'),
(6, N'Khoa học vật lý'),
(7, N'Khoa học xã hội');
GO

-- 2. Thêm dữ liệu cho bảng NhaXuatBan
INSERT INTO NhaXuatBan (MaNXB, TenNXB, DiaChi, DienThoai) VALUES
(1, N'Đại học Quốc gia', N'123 Nguyễn Trãi, Hà Nội', '0243111222'),
(2, N'Khoa học & Kỹ thuật', N'456 Trần Hưng Đạo, Q1, TPHCM', '0283444555'),
(3, N'Kim Đồng', N'789 Quang Trung, Hà Nội', '0243777888'),
(4, N'Nhà xuất bản Trẻ', N'1A Võ Văn Tần, Q3, TPHCM', '0283999111'),
(5, N'NXB Hồng Đức', N'55 Lê Lợi, Huế', '02343222333'),
(6, N'NXB Lao động - Xã hội', N'99 Trần Duy Hưng, Hà Nội', '0243666777'),
(7, N'NXB Phụ nữ', N'33 Nguyễn Thị Minh Khai, Q1, TPHCM', '0283111999');
GO

-- 3. Thêm dữ liệu cho bảng TacGia
INSERT INTO TacGia (MaTacGia, TenTacGia, DiaChi, TieuSu, DienThoai) VALUES
(1, N'Nguyễn Nhật Ánh', N'Quận 3, TPHCM', N'Nhà văn nổi tiếng với các tác phẩm dành cho thanh thiếu niên.', '090111222'),
(2, N'Trịnh Công Sơn', N'Huế', N'Nhạc sĩ, nhà thơ, họa sĩ tài hoa.', '090333444'),
(3, N'Yuval Noah Harari', N'Israel', N'Nhà sử học, giáo sư tại Đại học Hebrew của Jerusalem.', 'N/A'),
(4, N'Stephen Hawking', N'Anh', N'Nhà vật lý lý thuyết, vũ trụ học.', 'N/A'),
(5, N'Phạm Hữu Cương', N'Đà Nẵng', N'Chuyên gia về lập trình .NET.', '091555666');
GO

-- 4. Thêm dữ liệu cho bảng KhachHang
INSERT INTO KhachHang (MaKH, HoTen, TaiKhoan, MatKhau, Email, DiaChi, DienThoai, GioiTinh, NgaySinh) VALUES
(1, N'Trần Văn An', 'an.tran', 'an123', 'an.tran@email.com', N'12 Bùi Thị Xuân, Q1, TPHCM', '0987654321', N'Nam', '1990-05-15'),
(2, N'Lê Thị Bình', 'binh.le', 'binh456', 'binh.le@email.com', N'45 Nguyễn Văn Cừ, Q5, TPHCM', '0912345678', N'Nữ', '1995-10-20'),
(3, N'Nguyễn Hữu Cường', 'cuong.nguyen', 'cuong789', 'cuong.nguyen@email.com', N'78 Lý Thường Kiệt, Hà Nội', '0977888999', N'Nam', '1988-01-30');
GO

-- 5. Thêm dữ liệu cho bảng Sach (Tham chiếu đến MaChuDe và MaNXB đã tạo)
INSERT INTO Sach (MaSach, TenSach, GiaBan, MoTa, NgayCapNhat, AnhBia, SoLuongTon, MaChuDe, MaNXB) VALUES
(1, N'Lập trình C# cơ bản', 150000, N'Sách hướng dẫn lập trình C# từ A-Z.', '2025-01-10', 'anh1.jpg', 50, 2, 2), -- CNTT, KHKT
(2, N'Sapiens: Lược sử loài người', 250000, N'Một cái nhìn về lịch sử nhân loại.', '2025-02-15', 'anh2.jpg', 100, 7, 4), -- KH Xã hội, NXB Trẻ
(3, N'Vũ trụ trong vỏ hạt dẻ', 180000, N'Khám phá các lý thuyết vật lý hiện đại.', '2025-03-01','anh3.jpg', 70, 6, 1), -- KH Vật lý, ĐHQG
(4, N'Một đời như kẻ tìm đường', 120000, N'Tuyển tập nhạc và thơ Trịnh Công Sơn.', '2025-04-05','anh4.jpg', 30, 1, 6), -- Âm nhạc, LĐ-XH
(5, N'Cho tôi xin một vé đi tuổi thơ', 90000, N'Hồi ức về tuổi thơ.', '2025-05-20','anh5.jpg', 150, 3, 3), -- Danh nhân (Nguyễn Nhật Ánh), Kim Đồng
(6, N'Khám phá Cố đô Huế', 110000, N'Cẩm nang du lịch chi tiết về Huế và các lăng tẩm.', '2025-06-15', 'anh6.jpg', 80, 4, 5), -- Du lịch, NXB Hồng Đức
(7, N'Marie Curie: Nhà khoa học vĩ đại', 135000, N'Cuộc đời và sự nghiệp của nhà khoa học hai lần đoạt giải Nobel.', '2025-07-01', 'anh7.jpg', 65, 3, 7), -- Danh nhân, NXB Phụ nữ
(8, N'Cấu trúc dữ liệu và giải thuật', 220000, N'Giáo trình cơ bản và nâng cao cho sinh viên CNTT.', '2025-08-10', 'anh8.jpg', 120, 2, 1), -- CNTT, ĐH Quốc gia
(9, N'Nhập môn Trí tuệ nhân tạo', 300000, N'Các khái niệm cơ bản về AI và Machine Learning.', '2025-09-05', 'anh9.jpg', 40, 5, 2), -- KHKT, Khoa học & Kỹ thuật
(10, N'Tâm lý học đám đông', 140000, N'Phân tích hành vi xã hội và các hiệu ứng đám đông.', '2025-10-01', 'anh10.jpg', 90, 7, 6); -- KH Xã hội, NXB Lao động - Xã hội
GO

-- 6. Thêm dữ liệu cho bảng ThamGia 
INSERT INTO ThamGia (MaTacGia, MaSach, VaiTro, ViTri) VALUES
(5, 1, N'Tác giả chính', 'Bìa sách'), 
(3, 2, N'Tác giả', 'Bìa sách'), 
(4, 3, N'Tác giả', 'Bìa sách'), 
(2, 4, N'Tác giả', 'Bìa sách'), 
(1, 5, N'Tác giả', 'Bìa sách'); 
GO

-- 7. Thêm dữ liệu cho bảng DonHang 
INSERT INTO DonHang (MaDonHang, DaThanhToan, TinhTrangGiaoHang, NgayDat, NgayGiao, MaKH) VALUES
(1, 1, N'Đã giao', '2025-10-01', '2025-10-05', 1), 
(2, 0, N'Đang xử lý', '2025-10-28', NULL, 2), 
(3, 1, N'Đang giao', '2025-10-27', NULL, 1); 
GO

-- 8. Thêm dữ liệu cho bảng ChiTietDonHang 
INSERT INTO ChiTietDonHang (MaDonHang, MaSach, SoLuong, DonGia) VALUES
(1, 2, 1, 250000), 
(1, 3, 1, 180000), 
(2, 5, 2, 90000),  
(3, 1, 1, 150000); 
GO

