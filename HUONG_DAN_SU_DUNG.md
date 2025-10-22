# 📘 HƯỚNG DẪN SỬ DỤNG ỨNG DỤNG QUẢN LÝ SINH VIÊN

## 🎓 Giới thiệu
Ứng dụng quản lý sinh viên được xây dựng bằng Flutter, sử dụng SQLite để lưu trữ dữ liệu cục bộ, tích hợp camera, bản đồ OpenStreetMap và đọc danh bạ.

## ⚡ Chạy ứng dụng nhanh

```bash
flutter pub get
flutter run
```

## 🔑 Đăng nhập lần đầu

Sử dụng tài khoản Admin có sẵn:
- **Email:** admin@fpt.edu.vn
- **Mật khẩu:** admin123

## 👤 Vai trò trong hệ thống

### 🔴 ADMIN
**Quyền hạn:**
- ✅ Xem tất cả sinh viên
- ✅ Thêm sinh viên mới
- ✅ Sửa thông tin bất kỳ sinh viên nào
- ✅ Xóa sinh viên
- ✅ Quản lý ngành học (CRUD)
- ✅ Thay đổi vai trò (Admin/Sinh viên)

**Các chức năng:**
1. Vào màn hình Home → Có nút ➕ để thêm sinh viên
2. Bấm vào sinh viên → Xem chi tiết → Có nút ✏️ Sửa và 🗑️ Xóa
3. Bấm icon 📚 trên AppBar → Quản lý ngành học

### 🔵 SINH VIÊN
**Quyền hạn:**
- ✅ Xem danh sách sinh viên
- ✅ Xem thông tin chi tiết sinh viên khác
- ✅ Chỉnh sửa thông tin CÁ NHÂN của mình
- ✅ Xóa tài khoản của mình
- ❌ KHÔNG thể thêm/sửa/xóa sinh viên khác
- ❌ KHÔNG thể quản lý ngành học

**Các chức năng:**
1. Xem danh sách sinh viên
2. Bấm icon 👤 → Xem/Sửa thông tin cá nhân
3. Trong Profile → Có nút "Xóa tài khoản"

## 📋 Hướng dẫn các chức năng

### 1️⃣ Đăng ký tài khoản mới

1. Màn hình Login → Bấm "Chưa có tài khoản? Đăng ký ngay"
2. Điền đầy đủ thông tin:
   - Họ tên *
   - Email * (phải unique)
   - Số điện thoại
   - Ngày sinh * (bấm vào để chọn)
   - Địa chỉ *
   - Ngành học * (chọn từ dropdown)
   - Mật khẩu * (ít nhất 6 ký tự)
   - Xác nhận mật khẩu *
3. Bấm "Đăng ký"
4. Tài khoản mới sẽ có vai trò "Sinh viên" mặc định

### 2️⃣ Thêm sinh viên mới (Admin)

1. Màn hình Home → Bấm nút ➕ (góc dưới bên phải)
2. Điền thông tin như đăng ký
3. **Đặc biệt:**
   - Bấm vào ảnh đại diện → Chọn "Chụp ảnh" hoặc "Chọn từ thư viện"
   - Bấm icon 📞 bên cạnh số điện thoại → Chọn từ danh bạ
   - Bấm "Lấy vị trí hiện tại" → Lưu tọa độ GPS
   - Admin có thể chọn "Vai trò" (Admin/Sinh viên)
4. Bấm "Thêm mới" hoặc icon 💾

### 3️⃣ Xem chi tiết sinh viên

1. Màn hình Home → Bấm vào một sinh viên
2. Hiển thị:
   - Ảnh đại diện
   - Thông tin cá nhân (tên, ngày sinh, email, SĐT, địa chỉ, vai trò)
   - Thông tin ngành học
   - Vị trí trên bản đồ (nếu có)
3. Bấm vào "Vị trí trên bản đồ" → Xem vị trí trên OpenStreetMap

### 4️⃣ Chỉnh sửa sinh viên

**Admin:** Có thể sửa bất kỳ ai
**Sinh viên:** Chỉ sửa được thông tin của mình

1. Chi tiết sinh viên → Bấm icon ✏️
2. Sửa thông tin cần thiết
3. Có thể:
   - Đổi ảnh (bấm vào ảnh đại diện)
   - Cập nhật vị trí mới
   - Chọn SĐT từ danh bạ
4. Bấm "Cập nhật"

### 5️⃣ Xóa sinh viên (Admin)

1. Chi tiết sinh viên → Bấm icon 🗑️
2. Xác nhận xóa
3. Sinh viên sẽ bị xóa khỏi database

### 6️⃣ Quản lý Ngành học (Admin)

1. Màn hình Home → Bấm icon 📚
2. Xem danh sách ngành
3. **Thêm ngành mới:**
   - Bấm nút ➕
   - Nhập tên ngành và mô tả
   - Bấm "Lưu"
4. **Sửa ngành:**
   - Bấm icon ✏️ bên cạnh ngành
   - Sửa thông tin
   - Bấm "Lưu"
5. **Xóa ngành:**
   - Bấm icon 🗑️
   - Xác nhận xóa
   - ⚠️ Lưu ý: Không thể xóa ngành nếu còn sinh viên thuộc ngành đó

### 7️⃣ Xem Profile và Xóa tài khoản

1. Màn hình Home → Bấm icon 👤
2. Xem thông tin cá nhân
3. Bấm icon ✏️ → Sửa thông tin
4. **Xóa tài khoản:**
   - Scroll xuống → Bấm "Xóa tài khoản" (màu đỏ)
   - Xác nhận
   - Tài khoản sẽ bị xóa và tự động logout

### 8️⃣ Đăng xuất

1. Màn hình Home → Bấm icon 🚪
2. Xác nhận đăng xuất
3. Quay về màn hình Login

## 🗺️ Sử dụng Bản đồ

1. Khi thêm/sửa sinh viên → Bấm "Lấy vị trí hiện tại"
2. App sẽ xin quyền truy cập vị trí
3. Cho phép → Vị trí GPS sẽ được lưu
4. Trong chi tiết sinh viên → Bấm "Vị trí trên bản đồ"
5. Xem vị trí trên OpenStreetMap
6. Bấm nút 📍 để center lại bản đồ

## 📷 Sử dụng Camera

1. Khi thêm/sửa sinh viên → Bấm vào ảnh đại diện
2. Chọn:
   - **Chụp ảnh:** Mở camera để chụp ảnh mới
   - **Chọn từ thư viện:** Chọn ảnh có sẵn
3. Ảnh sẽ được hiển thị ngay lập tức
4. Lưu thông tin → Ảnh được lưu vào database

## 📱 Đọc Danh bạ

1. Khi thêm/sửa sinh viên → Ở trường "Số điện thoại"
2. Bấm icon 📞 bên cạnh
3. App xin quyền truy cập danh bạ
4. Cho phép → Chọn contact từ danh sách
5. Số điện thoại tự động điền vào

## ⚠️ Lưu ý quan trọng

### Permissions (Quyền)
Ứng dụng cần các quyền sau:
- 📷 **Camera** - Để chụp ảnh
- 📍 **Location** - Để lấy vị trí GPS
- 📞 **Contacts** - Để đọc danh bạ
- 💾 **Storage** - Để lưu ảnh

**Nếu từ chối quyền:**
- Vào Settings → Apps → Quản lý Sinh viên → Permissions
- Bật tất cả quyền cần thiết

### Validation (Kiểm tra dữ liệu)
- Email phải có @ và unique
- Mật khẩu tối thiểu 6 ký tự
- Các trường có dấu * là bắt buộc
- Không thể xóa ngành nếu còn sinh viên

### Database
- Dữ liệu lưu cục bộ (SQLite)
- Không cần Internet (trừ bản đồ)
- Dữ liệu mặc định:
  - 3 ngành học
  - 1 tài khoản Admin

## 🐛 Xử lý lỗi thường gặp

### 1. Không hiển thị ảnh
- Kiểm tra quyền Storage
- Thử chụp ảnh mới

### 2. Không lấy được vị trí
- Bật GPS trên thiết bị
- Cho phép quyền Location
- Thử ở ngoài trời (GPS tốt hơn)

### 3. Không đọc được danh bạ
- Cho phép quyền Contacts
- Kiểm tra có danh bạ trong điện thoại không

### 4. Lỗi đăng nhập
- Kiểm tra email/password
- Email có @ chưa?
- Password đủ 6 ký tự chưa?

### 5. Không build được
```bash
flutter clean
flutter pub get
flutter run
```

## 📊 Cấu trúc dữ liệu

### Ngành học
- Công nghệ Phần mềm
- Hệ thống Thông tin
- Trí tuệ Nhân tạo

### Sinh viên
- Thông tin cá nhân
- Ngành học (Foreign Key)
- Ảnh đại diện (File path)
- Vị trí GPS (Latitude, Longitude)
- Vai trò (Admin/Sinhvien)

## 🎯 Kết luận

Ứng dụng đã tích hợp đầy đủ các chức năng:
- ✅ CRUD sinh viên và ngành học
- ✅ Camera và chọn ảnh
- ✅ Bản đồ OpenStreetMap
- ✅ Đọc danh bạ
- ✅ Lấy vị trí GPS
- ✅ Phân quyền Admin/Sinh viên
- ✅ SQLite local database
- ✅ Material Design 3

**Chúc bạn sử dụng thành công! 🎉**
