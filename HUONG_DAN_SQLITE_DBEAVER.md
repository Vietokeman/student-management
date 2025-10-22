# 🗄️ HƯỚNG DẪN SỬ DỤNG SQLite VÀ DBeaver

## 📍 Tìm file Database SQLite

### Trên Android Device/Emulator:

Database của app được lưu tại:
```
/data/data/com.example.prm392_student_management/databases/student_management.db
```

### Cách lấy file database về máy:

**Bước 1: Chạy app một lần**
```bash
flutter run
```

**Bước 2: Tìm đường dẫn database**
Thêm dòng này vào `database_helper.dart` (trong hàm `_initDB`):
```dart
print('📍 Database path: $path');
```

**Bước 3: Pull database từ device**
```bash
# Xem devices
flutter devices

# Pull database
adb pull /data/data/com.example.prm392_student_management/databases/student_management.db ./student_management.db

# Hoặc kéo cả thư mục
adb pull /data/data/com.example.prm392_student_management/databases/ ./databases/
```

---

## 🔧 Cài đặt và Sử dụng DBeaver

### 1. Mở Database trong DBeaver

**Bước 1: Mở DBeaver**
- Bạn đã có DBeaver rồi ✅

**Bước 2: Tạo kết nối mới**
1. Click `Database` → `New Database Connection`
2. Chọn `SQLite`
3. Click `Next`

**Bước 3: Cấu hình**
- **Path:** Browse đến file `student_management.db` (vừa pull về)
- Hoặc: `D:\Ki7fpt\PRM\prm392_student_management\student_management.db`
- Click `Test Connection`
- Click `Finish`

**Bước 4: Mở và xem**
- Double click vào database
- Mở `Schemas` → `Tables`
- Sẽ thấy 2 bảng: `Nganh` và `Sinhvien`

---

## 📊 Cấu trúc Database

### Bảng 1: Nganh

```sql
CREATE TABLE Nganh (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TenNganh TEXT NOT NULL,
    MoTa TEXT NOT NULL
);
```

**Dữ liệu mặc định:**
```sql
INSERT INTO Nganh (TenNganh, MoTa) VALUES
('Công nghệ Phần mềm', 'Ngành đào tạo kỹ sư phần mềm chuyên nghiệp'),
('Hệ thống Thông tin', 'Ngành quản lý và phát triển hệ thống thông tin'),
('Trí tuệ Nhân tạo', 'Ngành nghiên cứu và ứng dụng AI');
```

### Bảng 2: Sinhvien

```sql
CREATE TABLE Sinhvien (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Ten TEXT NOT NULL,
    NgaySinh TEXT NOT NULL,           -- ISO8601 format: 2003-01-15T00:00:00.000
    DiaChi TEXT NOT NULL,
    IdNganh INTEGER NOT NULL,
    Anh TEXT,                          -- Đường dẫn file ảnh
    SoDienThoai TEXT,
    Email TEXT NOT NULL UNIQUE,
    MatKhau TEXT NOT NULL,
    Role TEXT NOT NULL,                -- 'Admin' hoặc 'Sinhvien'
    Latitude REAL,                     -- GPS Latitude
    Longitude REAL,                    -- GPS Longitude
    FOREIGN KEY (IdNganh) REFERENCES Nganh(Id) ON DELETE CASCADE
);
```

**Dữ liệu mặc định (Admin):**
```sql
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, Anh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Administrator', '1990-01-01T00:00:00.000', 'FPT University', 1, NULL, '0123456789', 'admin@fpt.edu.vn', 'admin123', 'Admin', 10.8411, 106.8098);
```

---

## 🔨 Thao tác với DBeaver

### 1. Xem dữ liệu (SELECT)

**Cách 1: Double click vào table**
- Mở bảng `Sinhvien` → Click `Data`

**Cách 2: Viết SQL**
```sql
-- Xem tất cả sinh viên
SELECT * FROM Sinhvien;

-- Xem sinh viên với thông tin ngành
SELECT 
    s.Id,
    s.Ten,
    s.Email,
    s.Role,
    n.TenNganh
FROM Sinhvien s
INNER JOIN Nganh n ON s.IdNganh = n.Id;

-- Đếm số sinh viên theo ngành
SELECT 
    n.TenNganh,
    COUNT(s.Id) as SoSinhVien
FROM Nganh n
LEFT JOIN Sinhvien s ON n.Id = s.IdNganh
GROUP BY n.Id;
```

### 2. Thêm dữ liệu (INSERT)

**Thêm ngành mới:**
```sql
INSERT INTO Nganh (TenNganh, MoTa) VALUES
('An ninh Mạng', 'Ngành bảo mật và an ninh thông tin');
```

**Thêm sinh viên mới:**
```sql
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Nguyễn Văn A', '2003-05-15T00:00:00.000', 'Hà Nội', 1, '0987654321', 'nguyenvana@fpt.edu.vn', '123456', 'Sinhvien', 21.0285, 105.8542);

INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Trần Thị B', '2003-08-20T00:00:00.000', 'Hồ Chí Minh', 2, '0912345678', 'tranthib@fpt.edu.vn', '123456', 'Sinhvien', 10.7769, 106.7009);

INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Lê Văn C', '2002-12-10T00:00:00.000', 'Đà Nẵng', 3, '0923456789', 'levanc@fpt.edu.vn', '123456', 'Sinhvien', 16.0544, 108.2022);
```

### 3. Cập nhật dữ liệu (UPDATE)

```sql
-- Cập nhật thông tin sinh viên
UPDATE Sinhvien 
SET 
    Ten = 'Nguyễn Văn An',
    SoDienThoai = '0999999999'
WHERE Id = 2;

-- Cập nhật vị trí GPS
UPDATE Sinhvien 
SET 
    Latitude = 10.8231,
    Longitude = 106.6297
WHERE Email = 'nguyenvana@fpt.edu.vn';

-- Thay đổi role
UPDATE Sinhvien 
SET Role = 'Admin'
WHERE Id = 2;
```

### 4. Xóa dữ liệu (DELETE)

```sql
-- Xóa sinh viên theo ID
DELETE FROM Sinhvien WHERE Id = 3;

-- Xóa sinh viên theo email
DELETE FROM Sinhvien WHERE Email = 'test@fpt.edu.vn';

-- Xóa tất cả sinh viên (cẩn thận!)
-- DELETE FROM Sinhvien;
```

### 5. Tìm kiếm (SEARCH)

```sql
-- Tìm theo tên (có dấu)
SELECT * FROM Sinhvien 
WHERE Ten LIKE '%Nguyễn%';

-- Tìm theo email
SELECT * FROM Sinhvien 
WHERE Email LIKE '%@fpt.edu.vn';

-- Tìm sinh viên thuộc ngành cụ thể
SELECT s.* FROM Sinhvien s
INNER JOIN Nganh n ON s.IdNganh = n.Id
WHERE n.TenNganh = 'Công nghệ Phần mềm';

-- Tìm admin
SELECT * FROM Sinhvien WHERE Role = 'Admin';
```

---

## 🔄 Workflow làm việc với Database

### Quy trình chuẩn:

```
1. Chạy app → Database tự động tạo
2. Pull database về máy (adb pull)
3. Mở trong DBeaver
4. Thêm/Sửa dữ liệu test
5. Push database lại lên device (adb push)
6. Khởi động lại app
7. Test các chức năng
```

### Lệnh chi tiết:

```bash
# Bước 1: Pull database
adb pull /data/data/com.example.prm392_student_management/databases/student_management.db ./

# Bước 2: Chỉnh sửa trong DBeaver
# (Thêm data, test queries...)

# Bước 3: Push lại lên device
adb push ./student_management.db /data/data/com.example.prm392_student_management/databases/

# Bước 4: Khởi động lại app
flutter run
```

---

## 📝 SQL Scripts hữu ích

### Script 1: Reset Database (xóa tất cả data)

```sql
-- Xóa tất cả sinh viên
DELETE FROM Sinhvien;

-- Xóa tất cả ngành
DELETE FROM Nganh;

-- Reset auto increment
DELETE FROM sqlite_sequence WHERE name='Sinhvien';
DELETE FROM sqlite_sequence WHERE name='Nganh';
```

### Script 2: Seed Database (thêm data mẫu)

```sql
-- Thêm ngành
INSERT INTO Nganh (TenNganh, MoTa) VALUES
('Công nghệ Phần mềm', 'Ngành đào tạo kỹ sư phần mềm chuyên nghiệp'),
('Hệ thống Thông tin', 'Ngành quản lý và phát triển hệ thống thông tin'),
('Trí tuệ Nhân tạo', 'Ngành nghiên cứu và ứng dụng AI'),
('An ninh Mạng', 'Ngành bảo mật và an ninh thông tin'),
('Khoa học Dữ liệu', 'Ngành phân tích và xử lý dữ liệu lớn');

-- Thêm Admin
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Administrator', '1990-01-01T00:00:00.000', 'FPT University', 1, '0123456789', 'admin@fpt.edu.vn', 'admin123', 'Admin', 10.8411, 106.8098);

-- Thêm sinh viên mẫu
INSERT INTO Sinhvien (Ten, NgaySinh, DiaChi, IdNganh, SoDienThoai, Email, MatKhau, Role, Latitude, Longitude) VALUES
('Nguyễn Văn Anh', '2003-01-15T00:00:00.000', '123 Đường ABC, Hà Nội', 1, '0987654321', 'nguyenvananh@fpt.edu.vn', '123456', 'Sinhvien', 21.0285, 105.8542),
('Trần Thị Bình', '2003-05-20T00:00:00.000', '456 Đường XYZ, TP.HCM', 2, '0912345678', 'tranthibinh@fpt.edu.vn', '123456', 'Sinhvien', 10.7769, 106.7009),
('Lê Văn Cường', '2002-11-10T00:00:00.000', '789 Đường MNO, Đà Nẵng', 3, '0923456789', 'levancuong@fpt.edu.vn', '123456', 'Sinhvien', 16.0544, 108.2022),
('Phạm Thị Dung', '2003-03-25T00:00:00.000', '321 Đường PQR, Hà Nội', 1, '0934567890', 'phamthidung@fpt.edu.vn', '123456', 'Sinhvien', 21.0245, 105.8412),
('Hoàng Văn Em', '2003-07-18T00:00:00.000', '654 Đường STU, TP.HCM', 4, '0945678901', 'hoangvanem@fpt.edu.vn', '123456', 'Sinhvien', 10.8231, 106.6297);
```

### Script 3: Queries thống kê

```sql
-- Tổng số sinh viên
SELECT COUNT(*) as TongSV FROM Sinhvien WHERE Role = 'Sinhvien';

-- Số lượng sinh viên theo ngành
SELECT 
    n.TenNganh,
    COUNT(s.Id) as SoLuong
FROM Nganh n
LEFT JOIN Sinhvien s ON n.Id = s.IdNganh AND s.Role = 'Sinhvien'
GROUP BY n.Id
ORDER BY SoLuong DESC;

-- Danh sách sinh viên có đầy đủ thông tin
SELECT 
    s.Ten,
    s.Email,
    s.SoDienThoai,
    n.TenNganh,
    CASE 
        WHEN s.Latitude IS NOT NULL THEN 'Có vị trí'
        ELSE 'Chưa có vị trí'
    END as TrangThaiViTri,
    CASE 
        WHEN s.Anh IS NOT NULL THEN 'Có ảnh'
        ELSE 'Chưa có ảnh'
    END as TrangThaiAnh
FROM Sinhvien s
INNER JOIN Nganh n ON s.IdNganh = n.Id
WHERE s.Role = 'Sinhvien';
```

---

## 🎯 Tips & Best Practices

### 1. Backup Database

```bash
# Backup trước khi thay đổi
adb pull /data/data/com.example.prm392_student_management/databases/student_management.db ./backup/student_management_backup_$(date +%Y%m%d).db
```

### 2. Export Data

Trong DBeaver:
- Right click vào table → `Export Data`
- Chọn format: CSV, JSON, SQL, Excel...
- Chọn đường dẫn lưu

### 3. Import Data

Trong DBeaver:
- Right click vào table → `Import Data`
- Chọn file (CSV, JSON, SQL...)
- Map columns → Import

### 4. Kiểm tra Integrity

```sql
-- Kiểm tra Foreign Key
PRAGMA foreign_keys;

-- Kiểm tra integrity
PRAGMA integrity_check;

-- Xem cấu trúc bảng
PRAGMA table_info(Sinhvien);
PRAGMA table_info(Nganh);
```

### 5. Optimize Database

```sql
-- Vacuum (optimize size)
VACUUM;

-- Analyze (optimize queries)
ANALYZE;
```

---

## 🐛 Troubleshooting

### Lỗi: "Database is locked"
```bash
# Stop app trước khi pull/push
adb shell am force-stop com.example.prm392_student_management
```

### Lỗi: "Permission denied"
```bash
# Chạy với root (nếu cần)
adb root
adb pull /data/data/...
```

### Lỗi: "File not found"
```bash
# Kiểm tra app đã chạy chưa
flutter run

# List files
adb shell ls /data/data/com.example.prm392_student_management/databases/
```

---

## 📚 Tài liệu tham khảo

- **SQLite Documentation:** https://www.sqlite.org/docs.html
- **DBeaver Documentation:** https://dbeaver.com/docs/
- **ADB Commands:** https://developer.android.com/studio/command-line/adb

---

## 💡 Lưu ý quan trọng

1. ⚠️ **Luôn backup** trước khi thay đổi database
2. ⚠️ **Test trên emulator** trước khi test trên device thật
3. ⚠️ **Đóng app** trước khi pull/push database
4. ⚠️ **Kiểm tra Foreign Key** khi xóa ngành (sẽ xóa sinh viên)
5. ⚠️ **Email phải unique** - không trùng lặp

---

**Chúc bạn làm việc hiệu quả với SQLite và DBeaver!** 🎉
