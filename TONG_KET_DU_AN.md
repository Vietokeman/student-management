# 🎓 DỰ ÁN QUẢN LÝ SINH VIÊN - PRM392

## ✅ HOÀN THÀNH

Dự án đã được xây dựng hoàn chỉnh với đầy đủ các tính năng theo yêu cầu.

---

## 📁 CẤU TRÚC DỰ ÁN

```
prm392_student_management/
│
├── lib/
│   ├── models/                    # Data Models
│   │   ├── nganh.dart            # Model Ngành học
│   │   └── sinhvien.dart         # Model Sinh viên
│   │
│   ├── db/                        # Database Layer
│   │   └── database_helper.dart  # SQLite Helper (CRUD)
│   │
│   ├── repositories/              # Repository Layer
│   │   ├── nganh_repository.dart
│   │   └── sinhvien_repository.dart
│   │
│   ├── services/                  # Business Logic Services
│   │   ├── camera_service.dart   # Camera & Image Picker
│   │   ├── contact_service.dart  # Đọc danh bạ
│   │   └── location_service.dart # GPS Location
│   │
│   ├── viewmodels/               # State Management (Provider)
│   │   ├── auth_viewmodel.dart   # Authentication
│   │   ├── sinhvien_viewmodel.dart
│   │   └── nganh_viewmodel.dart
│   │
│   ├── views/                    # UI Screens
│   │   ├── login_page.dart       # Đăng nhập
│   │   ├── register_page.dart    # Đăng ký
│   │   ├── home_page.dart        # Danh sách SV
│   │   ├── sinhvien_detail_page.dart  # Chi tiết SV
│   │   ├── sinhvien_form_page.dart    # Thêm/Sửa SV
│   │   ├── profile_page.dart     # Profile cá nhân
│   │   ├── nganh_list_page.dart  # Quản lý ngành
│   │   └── map_page.dart         # Bản đồ OSM
│   │
│   └── main.dart                 # Entry Point
│
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml   # Đã thêm Permissions
│
├── assets/images/                # Assets folder
├── README_PROJECT.md             # Tài liệu dự án (EN)
└── HUONG_DAN_SU_DUNG.md         # Hướng dẫn sử dụng (VI)
```

---

## ✨ TÍNH NĂNG ĐÃ HOÀN THÀNH

### 1. ✅ Authentication & Authorization
- [x] Đăng nhập
- [x] Đăng ký tài khoản
- [x] Phân quyền Admin/Sinh viên
- [x] Đăng xuất
- [x] Xóa tài khoản

### 2. ✅ Quản lý Sinh viên (CRUD)
- [x] Xem danh sách sinh viên
- [x] Xem chi tiết sinh viên
- [x] Thêm sinh viên mới (Admin)
- [x] Sửa thông tin sinh viên (Admin: all, Sinh viên: self)
- [x] Xóa sinh viên (Admin)
- [x] Lọc sinh viên theo ngành

### 3. ✅ Quản lý Ngành học (CRUD)
- [x] Xem danh sách ngành
- [x] Thêm ngành mới (Admin)
- [x] Sửa ngành (Admin)
- [x] Xóa ngành (Admin)

### 4. ✅ Camera & Image
- [x] Chụp ảnh từ camera
- [x] Chọn ảnh từ thư viện
- [x] Cập nhật ảnh đại diện sinh viên
- [x] Hiển thị ảnh trong danh sách và chi tiết

### 5. ✅ Bản đồ (OpenStreetMap)
- [x] Tích hợp flutter_map (không dùng Google Maps)
- [x] Hiển thị vị trí sinh viên trên bản đồ
- [x] Lấy vị trí hiện tại (GPS)
- [x] Lưu tọa độ (Latitude, Longitude)
- [x] Marker với label

### 6. ✅ Đọc Danh bạ
- [x] Xin quyền truy cập danh bạ
- [x] Đọc danh sách contacts
- [x] Chọn contact để lấy số điện thoại
- [x] Tự động điền số vào form

### 7. ✅ Database (SQLite)
- [x] Tạo database local
- [x] Bảng Nganh (Id, TenNganh, MoTa)
- [x] Bảng Sinhvien (Id, Ten, NgaySinh, DiaChi, IdNganh, Anh, SoDienThoai, Email, MatKhau, Role, Lat, Lon)
- [x] CRUD operations đầy đủ
- [x] Foreign Key relationship
- [x] Data validation

### 8. ✅ UI/UX
- [x] Material Design 3
- [x] Theme màu xanh dương
- [x] Responsive layout
- [x] Loading indicators
- [x] Error handling
- [x] Snackbar notifications
- [x] Form validation
- [x] Confirmation dialogs

### 9. ✅ Permissions (Android)
- [x] CAMERA
- [x] LOCATION (FINE & COARSE)
- [x] CONTACTS
- [x] STORAGE (READ & WRITE)
- [x] INTERNET
- [x] Runtime permission handling

---

## 🏗️ KIẾN TRÚC

**Clean Architecture với Provider:**

```
View (UI)
    ↓
ViewModel (Provider - State Management)
    ↓
Repository (Data Logic)
    ↓
Database Helper / Services
    ↓
SQLite / System APIs
```

**State Management:** Provider (ChangeNotifier)
**Database:** SQLite (sqflite package)
**Map:** OpenStreetMap (flutter_map + latlong2)

---

## 📦 DEPENDENCIES

```yaml
dependencies:
  sqflite: ^2.3.0              # SQLite database
  path: ^1.8.3                 # Path utilities
  provider: ^6.1.1             # State management
  flutter_map: ^6.1.0          # OpenStreetMap
  latlong2: ^0.9.0             # Coordinates
  image_picker: ^1.0.5         # Camera & Gallery
  permission_handler: ^11.1.0  # Runtime permissions
  contacts_service: ^0.6.3     # Read contacts
  geolocator: ^10.1.0          # Location services
  intl: ^0.19.0                # Date formatting
```

---

## 🔐 TÀI KHOẢN MẶC ĐỊNH

**Admin:**
- Email: `admin@fpt.edu.vn`
- Password: `admin123`
- Role: Admin

**Ngành học mặc định:**
1. Công nghệ Phần mềm
2. Hệ thống Thông tin
3. Trí tuệ Nhân tạo

---

## 🚀 HƯỚNG DẪN CHẠY

### Bước 1: Cài đặt dependencies
```bash
flutter pub get
```

### Bước 2: Chạy trên Android
```bash
flutter run
```

### Bước 3: Build APK
```bash
flutter build apk --release
```

APK sẽ nằm ở: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📱 YÊU CẦU HỆ THỐNG

- **Flutter:** >=3.9.2
- **Dart:** >=3.9.2
- **Android:** API Level 21+ (Android 5.0+)
- **iOS:** 12.0+ (chưa test)

---

## 🎯 PHÂN QUYỀN

| Chức năng | Admin | Sinh viên |
|-----------|-------|-----------|
| Xem danh sách SV | ✅ | ✅ |
| Xem chi tiết SV | ✅ | ✅ |
| Thêm SV | ✅ | ❌ |
| Sửa SV (all) | ✅ | ❌ |
| Sửa SV (self) | ✅ | ✅ |
| Xóa SV (all) | ✅ | ❌ |
| Xóa tài khoản (self) | ✅ | ✅ |
| Quản lý Ngành | ✅ | ❌ |
| Thay đổi Role | ✅ | ❌ |

---

## 📊 DATABASE SCHEMA

### Bảng: Nganh
```sql
CREATE TABLE Nganh (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  TenNganh TEXT NOT NULL,
  MoTa TEXT NOT NULL
)
```

### Bảng: Sinhvien
```sql
CREATE TABLE Sinhvien (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Ten TEXT NOT NULL,
  NgaySinh TEXT NOT NULL,
  DiaChi TEXT NOT NULL,
  IdNganh INTEGER NOT NULL,
  Anh TEXT,
  SoDienThoai TEXT,
  Email TEXT NOT NULL UNIQUE,
  MatKhau TEXT NOT NULL,
  Role TEXT NOT NULL,
  Latitude REAL,
  Longitude REAL,
  FOREIGN KEY (IdNganh) REFERENCES Nganh (Id)
)
```

---

## 🧪 TEST

### Đã kiểm tra:
- ✅ Đăng nhập với tài khoản admin
- ✅ Đăng ký tài khoản mới
- ✅ CRUD sinh viên
- ✅ CRUD ngành học
- ✅ Camera và chọn ảnh
- ✅ Lấy vị trí GPS
- ✅ Đọc danh bạ
- ✅ Hiển thị bản đồ
- ✅ Phân quyền

### Chưa test:
- ⚠️ iOS (chỉ test trên Android)
- ⚠️ Tablet layout
- ⚠️ Dark mode

---

## 📝 GHI CHÚ

### Điểm mạnh:
- ✅ Code clean, có cấu trúc rõ ràng
- ✅ Tách biệt concerns (Model-View-ViewModel)
- ✅ State management hiệu quả với Provider
- ✅ Error handling đầy đủ
- ✅ UI/UX thân thiện
- ✅ Đầy đủ tính năng theo yêu cầu

### Có thể cải tiến:
- 🔄 Thêm search/filter nâng cao
- 🔄 Export/Import dữ liệu
- 🔄 Thống kê, báo cáo
- 🔄 Dark mode
- 🔄 Multi-language (i18n)
- 🔄 Unit tests & Integration tests

---

## 🎓 THÔNG TIN

**Môn học:** PRM392 - Mobile Programming  
**Đề tài:** Ứng dụng Quản lý Sinh viên  
**Lớp:** SE1716  
**Năm:** 2025  
**Platform:** Android (Flutter)  

---

## 📚 TÀI LIỆU THAM KHẢO

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [sqflite Package](https://pub.dev/packages/sqflite)
- [flutter_map Package](https://pub.dev/packages/flutter_map)
- [OpenStreetMap](https://www.openstreetmap.org/)

---

## 🏆 KẾT LUẬN

Dự án đã hoàn thành đầy đủ các yêu cầu:
1. ✅ CRUD Sinh viên & Ngành học
2. ✅ SQLite local database
3. ✅ Camera & Image Picker
4. ✅ OpenStreetMap (không dùng Google Maps)
5. ✅ Đọc danh bạ
6. ✅ GPS Location
7. ✅ Đăng nhập/Đăng ký
8. ✅ Phân quyền Admin/Sinh viên
9. ✅ Material Design 3
10. ✅ Clean Architecture

**Ứng dụng sẵn sàng nộp và demo!** 🎉

---

## 📞 HỖ TRỢ

Nếu có vấn đề khi chạy:
1. Đọc file `HUONG_DAN_SU_DUNG.md`
2. Chạy `flutter doctor` để kiểm tra môi trường
3. Chạy `flutter clean && flutter pub get`
4. Kiểm tra permissions trong Settings

**Chúc bạn thành công với bài Practical Exam!** 🎓✨
