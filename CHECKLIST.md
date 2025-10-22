# ✅ CHECKLIST TRƯỚC KHI CHẠY & NỘP BÀI

## 📋 Chuẩn bị môi trường

- [ ] Đã cài đặt Flutter SDK
- [ ] Đã cài đặt Android Studio / VS Code
- [ ] Đã cài đặt Android SDK
- [ ] Thiết bị Android hoặc Emulator sẵn sàng
- [ ] Chạy `flutter doctor` - tất cả đều OK

## 📦 Cài đặt dự án

- [ ] Clone/Copy dự án về máy
- [ ] Mở project trong VS Code/Android Studio
- [ ] Chạy `flutter pub get` - thành công
- [ ] Không có lỗi compile

## 🔍 Kiểm tra file quan trọng

### Models
- [ ] `lib/models/nganh.dart` - ✅ Có
- [ ] `lib/models/sinhvien.dart` - ✅ Có

### Database
- [ ] `lib/db/database_helper.dart` - ✅ Có
- [ ] Database có 2 bảng: Nganh, Sinhvien
- [ ] Có dữ liệu mẫu (3 ngành, 1 admin)

### Repositories
- [ ] `lib/repositories/nganh_repository.dart` - ✅ Có
- [ ] `lib/repositories/sinhvien_repository.dart` - ✅ Có

### Services
- [ ] `lib/services/camera_service.dart` - ✅ Có
- [ ] `lib/services/contact_service.dart` - ✅ Có
- [ ] `lib/services/location_service.dart` - ✅ Có

### ViewModels (Provider)
- [ ] `lib/viewmodels/auth_viewmodel.dart` - ✅ Có
- [ ] `lib/viewmodels/sinhvien_viewmodel.dart` - ✅ Có
- [ ] `lib/viewmodels/nganh_viewmodel.dart` - ✅ Có

### Views (UI)
- [ ] `lib/views/login_page.dart` - ✅ Có
- [ ] `lib/views/register_page.dart` - ✅ Có
- [ ] `lib/views/home_page.dart` - ✅ Có
- [ ] `lib/views/sinhvien_detail_page.dart` - ✅ Có
- [ ] `lib/views/sinhvien_form_page.dart` - ✅ Có
- [ ] `lib/views/profile_page.dart` - ✅ Có
- [ ] `lib/views/nganh_list_page.dart` - ✅ Có
- [ ] `lib/views/map_page.dart` - ✅ Có

### Config
- [ ] `lib/main.dart` - ✅ Có Provider setup
- [ ] `pubspec.yaml` - ✅ Có tất cả dependencies
- [ ] `android/app/src/main/AndroidManifest.xml` - ✅ Có permissions

## 🧪 Test chức năng (quan trọng!)

### 1. Đăng nhập
- [ ] Mở app → Hiện màn hình Login
- [ ] Nhập `admin@fpt.edu.vn` / `admin123`
- [ ] Bấm "Đăng nhập" → Vào được Home
- [ ] Thấy danh sách sinh viên (ít nhất 1 admin)

### 2. Đăng ký tài khoản mới
- [ ] Màn hình Login → Bấm "Đăng ký ngay"
- [ ] Điền đầy đủ thông tin
- [ ] Chọn ngành học từ dropdown
- [ ] Đăng ký thành công → Quay về Login

### 3. CRUD Sinh viên (với Admin)
- [ ] Home → Bấm nút ➕ (thêm SV)
- [ ] Điền form → Lưu thành công
- [ ] Thấy SV mới trong danh sách
- [ ] Bấm vào SV → Xem chi tiết
- [ ] Bấm nút ✏️ → Sửa được
- [ ] Bấm nút 🗑️ → Xóa được

### 4. Camera
- [ ] Form thêm/sửa SV → Bấm vào ảnh đại diện
- [ ] Chọn "Chụp ảnh" → Mở camera
- [ ] Chụp ảnh → Hiển thị ảnh
- [ ] Hoặc chọn "Chọn từ thư viện" → Chọn ảnh
- [ ] Lưu → Ảnh hiển thị trong danh sách

### 5. Bản đồ (OpenStreetMap)
- [ ] Form thêm/sửa SV → Bấm "Lấy vị trí hiện tại"
- [ ] Cho phép quyền Location
- [ ] Hiển thị tọa độ (Lat, Lon)
- [ ] Lưu sinh viên
- [ ] Chi tiết SV → Bấm "Vị trí trên bản đồ"
- [ ] Mở màn hình Map
- [ ] Thấy marker trên bản đồ OSM
- [ ] Bấm nút 📍 → Map center lại

### 6. Đọc danh bạ
- [ ] Form thêm/sửa SV → Trường "Số điện thoại"
- [ ] Bấm icon 📞
- [ ] Cho phép quyền Contacts
- [ ] Chọn một contact
- [ ] SĐT tự động điền vào

### 7. Quản lý Ngành (Admin)
- [ ] Home → Bấm icon 📚
- [ ] Thấy danh sách ngành
- [ ] Bấm ➕ → Thêm ngành mới
- [ ] Bấm ✏️ → Sửa ngành
- [ ] Bấm 🗑️ → Xóa ngành

### 8. Profile
- [ ] Home → Bấm icon 👤
- [ ] Thấy thông tin cá nhân
- [ ] Bấm ✏️ → Sửa được
- [ ] Test "Xóa tài khoản" (tùy chọn)

### 9. Đăng xuất
- [ ] Home → Bấm icon 🚪
- [ ] Xác nhận → Logout
- [ ] Quay về màn hình Login

### 10. Phân quyền Sinh viên
- [ ] Đăng nhập với tài khoản Sinh viên
- [ ] Home → KHÔNG thấy nút ➕
- [ ] Chi tiết SV khác → KHÔNG thấy nút ✏️ và 🗑️
- [ ] Profile → Thấy nút ✏️ (chỉ sửa được của mình)
- [ ] Home → KHÔNG thấy icon 📚 (quản lý ngành)

## 🐛 Kiểm tra lỗi thường gặp

- [ ] Permissions đã được cấp (Location, Camera, Contacts)
- [ ] GPS đã bật (cho location)
- [ ] Internet đã bật (cho OpenStreetMap)
- [ ] Storage có đủ dung lượng (cho ảnh)

## 📱 Build APK (tùy chọn)

- [ ] Chạy `flutter build apk --release`
- [ ] APK nằm ở `build/app/outputs/flutter-apk/app-release.apk`
- [ ] Copy APK để nộp bài

## 📄 Tài liệu đầy đủ

- [ ] README.md - Giới thiệu
- [ ] TONG_KET_DU_AN.md - Tổng quan chi tiết
- [ ] HUONG_DAN_SU_DUNG.md - Hướng dẫn sử dụng
- [ ] README_PROJECT.md - Documentation

## ✅ SẴN SÀNG NỘP BÀI

Khi tất cả các mục trên đã check ✅:
- ✨ Ứng dụng chạy tốt
- ✨ Tất cả tính năng hoạt động
- ✨ Không có lỗi compile
- ✨ UI/UX đẹp, dễ sử dụng
- ✨ Code clean, có cấu trúc

**→ BẠN ĐÃ SẴN SÀNG ĐỂ DEMO VÀ NỘP BÀI! 🎉**

---

## 🎯 Lưu ý khi Demo

1. **Chuẩn bị:**
   - Mở app sẵn
   - Đăng nhập với tài khoản admin
   - Internet đã bật
   - GPS đã bật

2. **Demo theo thứ tự:**
   - Giới thiệu tổng quan
   - Đăng nhập/Đăng ký
   - CRUD Sinh viên
   - Chụp ảnh/Chọn ảnh
   - Lấy vị trí và xem bản đồ
   - Đọc danh bạ
   - CRUD Ngành học
   - Phân quyền

3. **Trả lời câu hỏi:**
   - Giải thích kiến trúc (Clean Architecture)
   - State management (Provider)
   - Database (SQLite)
   - Tại sao dùng flutter_map (không Google Maps)

**CHÚC BẠN THÀNH CÔNG! 🎓✨**
