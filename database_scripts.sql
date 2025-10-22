-- ============================================
-- SQL Scripts cho DBeaver - Student Management
-- ============================================

-- =============================================
-- 1. RESET DATABASE (Xóa tất cả dữ liệu)
-- =============================================

-- Xóa tất cả sinh viên
DELETE FROM Sinhvien;

-- Xóa tất cả ngành
DELETE FROM Nganh;

-- Reset auto increment counter
DELETE FROM sqlite_sequence WHERE name='Sinhvien';
DELETE FROM sqlite_sequence WHERE name='Nganh';

-- =============================================
-- 2. SEED DATABASE (Thêm dữ liệu mẫu)
-- =============================================

-- Thêm Ngành học
INSERT INTO Nganh (TenNganh, MoTa) VALUES
('Kĩ thuật Phần mềm', 'Ngành đào tạo kỹ sư phần mềm chuyên nghiệp (SE)'),
('Trí tuệ Nhân tạo', 'Ngành nghiên cứu và ứng dụng AI (IA)'),
('Thiết kế Đồ họa', 'Ngành thiết kế kỹ thuật số và đồ họa (GD)'),
('Kinh doanh Quốc tế', 'Ngành kinh doanh và thương mại quốc tế (IB)');

-- Thêm tài khoản Admin
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Administrator', '1990-01-01T00:00:00.000', 'FPT University, Hà Nội', 1, '0123456789', 'admin@fpt.edu.vn', 'admin123', 'Admin', 21.0285, 105.8542, NULL);

-- Thêm Sinh viên mẫu - Ngành Kĩ thuật Phần mềm (SE)
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Nguyễn Văn Anh', '2003-01-15T00:00:00.000', '123 Đường Láng, Đống Đa, Hà Nội', 1, '0987654321', 'nguyenvananh@fpt.edu.vn', '123456', 'Sinhvien', 21.0285, 105.8542, NULL),
('Trần Minh Tuấn', '2003-03-22T00:00:00.000', '456 Nguyễn Trãi, Thanh Xuân, Hà Nội', 1, '0912345678', 'tranminhtuan@fpt.edu.vn', '123456', 'Sinhvien', 21.0031, 105.8163, NULL),
('Lê Thị Hương', '2003-05-10T00:00:00.000', '789 Giải Phóng, Hoàng Mai, Hà Nội', 1, '0923456789', 'lethihuong@fpt.edu.vn', '123456', 'Sinhvien', 20.9805, 105.8468, NULL);

-- Thêm Sinh viên mẫu - Ngành Trí tuệ Nhân tạo (IA)
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Phạm Thị Lan', '2003-02-18T00:00:00.000', '234 Lê Văn Lương, Thanh Xuân, Hà Nội', 2, '0934567890', 'phamthilan@fpt.edu.vn', '123456', 'Sinhvien', 21.0101, 105.8010, NULL),
('Hoàng Đức Nam', '2003-04-25T00:00:00.000', '567 Cầu Giấy, Cầu Giấy, Hà Nội', 2, '0945678901', 'hoangducnam@fpt.edu.vn', '123456', 'Sinhvien', 21.0333, 105.7944, NULL);

-- Thêm Sinh viên mẫu - Ngành Thiết kế Đồ họa (GD)
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Vũ Minh Quang', '2003-06-30T00:00:00.000', '890 Hoàng Quốc Việt, Cầu Giấy, Hà Nội', 3, '0956789012', 'vuminhquang@fpt.edu.vn', '123456', 'Sinhvien', 21.0468, 105.7951, NULL),
('Đỗ Thu Trang', '2003-08-12T00:00:00.000', '123 Trần Duy Hưng, Cầu Giấy, Hà Nội', 3, '0967890123', 'dothutrang@fpt.edu.vn', '123456', 'Sinhvien', 21.0179, 105.7899, NULL);

-- Thêm Sinh viên mẫu - Ngành Kinh doanh Quốc tế (IB)
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Bùi Văn Hải', '2003-09-05T00:00:00.000', '456 Phạm Văn Đồng, Bắc Từ Liêm, Hà Nội', 4, '0978901234', 'buivanhai@fpt.edu.vn', '123456', 'Sinhvien', 21.0538, 105.7708, NULL),
('Ngô Thị Mai', '2003-11-20T00:00:00.000', '789 Xuân Thủy, Cầu Giấy, Hà Nội', 4, '0989012345', 'ngothimai@fpt.edu.vn', '123456', 'Sinhvien', 21.0412, 105.7876, NULL);

-- Thêm Admin phụ
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude, Anh) VALUES
('Quản Trị Viên', '1992-06-15T00:00:00.000', 'FPT University, TP.HCM', 1, '0912345678', 'admin2@fpt.edu.vn', 'admin123', 'Admin', 10.8411, 106.8098, NULL);

-- =============================================
-- 3. QUERIES THỐNG KÊ
-- =============================================

-- Đếm tổng số sinh viên
SELECT COUNT(*) as TongSinhVien 
FROM Sinhvien 
WHERE Role = 'Sinhvien';

-- Thống kê số sinh viên theo ngành
SELECT 
    n.TenNganh,
    COUNT(s.Id) as SoSinhVien
FROM Nganh n
LEFT JOIN Sinhvien s ON n.Id = s.IdNganh AND s.Role = 'Sinhvien'
GROUP BY n.Id, n.TenNganh
ORDER BY SoSinhVien DESC;

-- Danh sách sinh viên với thông tin ngành
SELECT 
    s.Id,
    s.Ten,
    s.Email,
    s.SoDienThoai,
    n.TenNganh,
    s.Role,
    CASE 
        WHEN s.Latitude IS NOT NULL AND s.Longitude IS NOT NULL 
        THEN 'Có vị trí GPS'
        ELSE 'Chưa có vị trí'
    END as TrangThaiGPS,
    CASE 
        WHEN s.Anh IS NOT NULL 
        THEN 'Có ảnh'
        ELSE 'Chưa có ảnh'
    END as TrangThaiAnh
FROM Sinhvien s
INNER JOIN Nganh n ON s.IdNganh = n.Id
ORDER BY s.Role DESC, s.Ten ASC;

-- Danh sách Admin
SELECT 
    Id,
    Ten,
    Email,
    SoDienThoai
FROM Sinhvien
WHERE Role = 'Admin';

-- Top 5 ngành có nhiều sinh viên nhất
SELECT 
    n.TenNganh,
    COUNT(s.Id) as SoSinhVien
FROM Nganh n
LEFT JOIN Sinhvien s ON n.Id = s.IdNganh AND s.Role = 'Sinhvien'
GROUP BY n.Id, n.TenNganh
ORDER BY SoSinhVien DESC
LIMIT 5;

-- =============================================
-- 4. QUERIES TÌM KIẾM
-- =============================================

-- Tìm sinh viên theo tên
SELECT * FROM Sinhvien 
WHERE Ten LIKE '%Nguyễn%';

-- Tìm sinh viên theo email
SELECT * FROM Sinhvien 
WHERE Email LIKE '%@fpt.edu.vn';

-- Tìm sinh viên theo ngành
SELECT s.* 
FROM Sinhvien s
INNER JOIN Nganh n ON s.IdNganh = n.Id
WHERE n.TenNganh = 'Công nghệ Phần mềm';

-- Tìm sinh viên có vị trí GPS
SELECT * FROM Sinhvien 
WHERE Latitude IS NOT NULL 
  AND Longitude IS NOT NULL;

-- =============================================
-- 5. QUERIES CẬP NHẬT
-- =============================================

-- Cập nhật thông tin sinh viên
UPDATE Sinhvien 
SET 
    Ten = 'Nguyễn Văn An',
    SoDienThoai = '0999999999',
    DiaChi = 'Địa chỉ mới'
WHERE Id = 2;

-- Cập nhật vị trí GPS
UPDATE Sinhvien 
SET 
    Latitude = 21.0285,
    Longitude = 105.8542
WHERE Email = 'nguyenvananh@fpt.edu.vn';

-- Cập nhật vai trò (nâng lên Admin)
UPDATE Sinhvien 
SET Role = 'Admin'
WHERE Id = 3;

-- Cập nhật mật khẩu
UPDATE Sinhvien 
SET MatKhau = 'newpassword123'
WHERE Email = 'nguyenvananh@fpt.edu.vn';

-- =============================================
-- 6. QUERIES XÓA
-- =============================================

-- Xóa sinh viên theo ID
DELETE FROM Sinhvien WHERE Id = 10;

-- Xóa sinh viên theo email
DELETE FROM Sinhvien WHERE Email = 'test@fpt.edu.vn';

-- Xóa tất cả sinh viên thuộc một ngành (cẩn thận!)
-- DELETE FROM Sinhvien WHERE IdNganh = 5;

-- =============================================
-- 7. KIỂM TRA DATABASE
-- =============================================

-- Kiểm tra cấu trúc bảng Nganh
PRAGMA table_info(Nganh);

-- Kiểm tra cấu trúc bảng Sinhvien
PRAGMA table_info(Sinhvien);

-- Kiểm tra Foreign Keys
PRAGMA foreign_key_list(Sinhvien);

-- Kiểm tra integrity
PRAGMA integrity_check;

-- Xem danh sách tất cả bảng
SELECT name FROM sqlite_master WHERE type='table';

-- =============================================
-- 8. OPTIMIZE DATABASE
-- =============================================

-- Vacuum (tối ưu kích thước)
VACUUM;

-- Analyze (tối ưu queries)
ANALYZE;

-- =============================================
-- 9. BACKUP & RESTORE
-- =============================================

-- Export to CSV (trong DBeaver: Right-click table → Export Data)

-- Import from CSV (trong DBeaver: Right-click table → Import Data)

-- =============================================
-- LƯU Ý QUAN TRỌNG:
-- - Email phải UNIQUE (không trùng lặp)
-- - Ngày sinh theo format ISO8601: YYYY-MM-DDTHH:MM:SS.SSS
-- - Role chỉ có 2 giá trị: 'Admin' hoặc 'Sinhvien'
-- - Khi xóa Ngành sẽ xóa cả Sinh viên (CASCADE)
-- - Latitude/Longitude có thể NULL
-- - Anh (đường dẫn ảnh) có thể NULL
-- =============================================
