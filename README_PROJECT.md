# Ứng dụng Quản lý Sinh viên - PRM392

Ứng dụng Flutter quản lý sinh viên với đầy đủ tính năng CRUD, camera, bản đồ OpenStreetMap, đọc danh bạ và phân quyền Admin/Sinh viên.

## 🎯 Tính năng chính

### 🔐 Xác thực
- Đăng nhập/Đăng ký tài khoản
- Phân quyền: Admin và Sinh viên
- Xóa tài khoản

### 👨‍🎓 Quản lý Sinh viên
- Xem danh sách sinh viên (cả Admin và Sinh viên)
- Thêm sinh viên mới (chỉ Admin)
- Xem chi tiết sinh viên
- Chỉnh sửa thông tin (Admin: tất cả, Sinh viên: chỉ thông tin của mình)
- Xóa sinh viên (chỉ Admin)

### 📚 Quản lý Ngành học
- CRUD ngành học (chỉ Admin)
- Xem danh sách ngành

### 📷 Tính năng Camera
- Chụp ảnh từ camera
- Chọn ảnh từ thư viện
- Cập nhật ảnh đại diện sinh viên

### 🗺️ Bản đồ (OpenStreetMap)
- Hiển thị vị trí sinh viên trên bản đồ
- Sử dụng flutter_map (không dùng Google Maps)
- Lấy vị trí hiện tại

### 📱 Đọc danh bạ
- Đọc danh bạ điện thoại
- Chọn contact để cập nhật số điện thoại

## 🏗️ Kiến trúc dự án

```
lib/
├── models/           # Data models (Sinhvien, Nganh)
├── db/              # SQLite Database Helper
├── repositories/    # Repository layer
├── services/        # Services (Camera, Location, Contact)
├── viewmodels/      # State management với Provider
├── views/           # UI Screens
└── main.dart        # Entry point
```

## 📦 Dependencies

- **sqflite**: SQLite database
- **provider**: State management
- **flutter_map**: OpenStreetMap
- **latlong2**: Coordinate handling
- **image_picker**: Camera & Gallery
- **permission_handler**: Runtime permissions
- **contacts_service**: Read contacts
- **geolocator**: Location services
- **intl**: Date formatting

## 🚀 Cài đặt và Chạy

1. **Clone hoặc mở project:**
   ```bash
   cd prm392_student_management
   ```

2. **Cài đặt dependencies:**
   ```bash
   flutter pub get
   ```

3. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

## 🔑 Tài khoản mặc định

**Admin:**
- Email: `admin@fpt.edu.vn`
- Mật khẩu: `admin123`

## 📊 Cơ sở dữ liệu SQLite

### Bảng Nganh
- Id (INTEGER PRIMARY KEY)
- TenNganh (TEXT)
- MoTa (TEXT)

### Bảng Sinhvien
- Id (INTEGER PRIMARY KEY)
- Ten (TEXT)
- NgaySinh (TEXT/ISO8601)
- DiaChi (TEXT)
- IdNganh (INTEGER - Foreign Key)
- Anh (TEXT - Path to image)
- SoDienThoai (TEXT)
- Email (TEXT UNIQUE)
- MatKhau (TEXT)
- Role (TEXT: 'Admin' hoặc 'Sinhvien')
- Latitude (REAL)
- Longitude (REAL)

## 🔐 Permissions (Android)

Đã cấu hình trong `android/app/src/main/AndroidManifest.xml`:
- INTERNET
- ACCESS_FINE_LOCATION
- ACCESS_COARSE_LOCATION
- CAMERA
- READ_CONTACTS
- WRITE_EXTERNAL_STORAGE
- READ_EXTERNAL_STORAGE

## 📱 Màn hình

1. **Login** - Đăng nhập
2. **Register** - Đăng ký tài khoản mới
3. **Home** - Danh sách sinh viên
4. **Detail** - Chi tiết sinh viên
5. **Form** - Thêm/Sửa sinh viên
6. **Profile** - Thông tin cá nhân
7. **Map** - Xem vị trí trên bản đồ
8. **Nganh List** - Quản lý ngành học (Admin)

## 🎨 UI/UX

- Material Design 3
- Theme màu xanh dương
- Responsive layout
- Snackbar notifications
- Loading indicators
- Error handling

## 👨‍💻 Phát triển bởi

**Môn học:** PRM392 - Mobile Programming  
**Lớp:** SE1716  
**Năm:** 2025

## 📝 Ghi chú

- Ứng dụng chạy hoàn toàn offline với SQLite
- Không sử dụng backend API
- Dữ liệu được lưu cục bộ trên thiết bị
- Hỗ trợ đầy đủ CRUD operations
- Phân quyền rõ ràng giữa Admin và Sinh viên

## 🐛 Troubleshooting

Nếu gặp lỗi khi build:
```bash
flutter clean
flutter pub get
flutter run
```

Nếu lỗi permissions trên Android:
- Vào Settings > Apps > [App name] > Permissions
- Bật tất cả permissions cần thiết
