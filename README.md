# 🎓 Ứng dụng Quản lý Sinh viên - PRM392

Ứng dụng Flutter quản lý sinh viên với SQLite, Camera, OpenStreetMap và đọc danh bạ.

## 🚀 Chạy nhanh

```bash
flutter pub get
flutter run
```

## 🔑 Đăng nhập

**Tài khoản Admin mặc định:**
- Email: `admin@fpt.edu.vn`
- Mật khẩu: `admin123`

## ✨ Tính năng

- ✅ CRUD Sinh viên & Ngành học
- ✅ SQLite local database
- ✅ Camera & Image Picker
- ✅ OpenStreetMap (flutter_map)
- ✅ **🆕 Chọn vị trí trên bản đồ (Location Picker)**
- ✅ Đọc danh bạ điện thoại
- ✅ GPS Location
- ✅ Đăng nhập/Đăng ký
- ✅ Phân quyền Admin/Sinh viên
- ✅ **🆕 Hỗ trợ gõ tiếng Việt hoàn hảo**
- ✅ Material Design 3

## 🆕 Cập nhật mới nhất (22/10/2025)

### **1. Sửa lỗi gõ tiếng Việt bị mất chữ** 🇻🇳
- ✅ Khi gõ "Nguyễn" không còn bị mất chữ
- ✅ Hỗ trợ tất cả bộ gõ: Gboard, SwiftKey, Laban Key
- ✅ Sửa ở các trường: Họ tên, Địa chỉ
- 📖 Chi tiết: [SUA_LOI_TIENG_VIET.md](SUA_LOI_TIENG_VIET.md)

### **2. Thêm 10 sinh viên mẫu vào database** 👥
- ✅ Tự động tạo 10 sinh viên khi khởi tạo database lần đầu
- ✅ Tên, email, địa chỉ tiếng Việt có dấu
- ✅ Phân bố 10 thành phố khác nhau: HCM, Hà Nội, Đà Nẵng, Huế, Cần Thơ, Biên Hòa, Vũng Tàu, Thủ Đức, Đà Lạt, Nha Trang
- ✅ Đã có tọa độ GPS sẵn
- 📋 Danh sách: [TINH_NANG_MOI_NOMINATIM.md](TINH_NANG_MOI_NOMINATIM.md)

### **3. Thêm tính năng tìm kiếm địa điểm với Nominatim API** 🔍🗺️
- ✅ Tìm kiếm địa điểm bằng tiếng Việt: "Hà Nội", "Đà Nẵng", "Bến Thành"
- ✅ Hiển thị 5 kết quả gần nhất
- ✅ Nhấn vào kết quả → Bản đồ zoom đến đó
- ✅ Hiển thị tên địa chỉ bằng tiếng Việt
- 📖 Chi tiết: [TINH_NANG_MOI_NOMINATIM.md](TINH_NANG_MOI_NOMINATIM.md)

### **2. Thêm tính năng chọn vị trí trên bản đồ** 🗺️
- ✅ Chọn vị trí bằng cách chạm vào bản đồ
- ✅ Lấy vị trí hiện tại tự động (GPS)
- ✅ Hiển thị marker đỏ và tọa độ chi tiết
- ✅ Tích hợp vào form thêm/sửa sinh viên
- 📖 Chi tiết: [HUONG_DAN_SU_DUNG_MAP.md](HUONG_DAN_SU_DUNG_MAP.md)

## 📚 Tài liệu

### **Tài liệu chính:**
- **[TONG_KET_DU_AN.md](TONG_KET_DU_AN.md)** - Tổng quan dự án
- **[HUONG_DAN_SU_DUNG.md](HUONG_DAN_SU_DUNG.md)** - Hướng dẫn chi tiết
- **[README_PROJECT.md](README_PROJECT.md)** - Documentation (English)

### **Tài liệu cập nhật mới:**
- **[TOM_TAT_HOAN_THANH.md](TOM_TAT_HOAN_THANH.md)** - 🆕 Tóm tắt tất cả thay đổi
- **[CAP_NHAT_MOI.md](CAP_NHAT_MOI.md)** - Lịch sử cập nhật
- **[SUA_LOI_TIENG_VIET.md](SUA_LOI_TIENG_VIET.md)** - 🆕 Hướng dẫn gõ tiếng Việt
- **[TINH_NANG_MOI_NOMINATIM.md](TINH_NANG_MOI_NOMINATIM.md)** - 🆕 Tính năng Nominatim + 10 sinh viên
- **[HUONG_DAN_SU_DUNG_MAP.md](HUONG_DAN_SU_DUNG_MAP.md)** - 🆕 Hướng dẫn chọn vị trí bản đồ
- **[HUONG_DAN_NHANH_TINH_NANG_MOI.md](HUONG_DAN_NHANH_TINH_NANG_MOI.md)** - 🆕 Hướng dẫn nhanh
- **[CHECKLIST_TEST_CAP_NHAT_MOI.md](CHECKLIST_TEST_CAP_NHAT_MOI.md)** - 🆕 Checklist test tính năng mới

## 🏗️ Cấu trúc

```
lib/
├── models/          # Data models
├── db/              # SQLite database
├── repositories/    # Data layer
├── services/        # Camera, Location, Contacts
├── viewmodels/      # State management (Provider)
├── views/           # UI screens
└── main.dart        # Entry point
```

## 📱 Môn học

- **Môn:** PRM392 - Mobile Programming
- **Lớp:** SE1716
- **Platform:** Android (Flutter)

---

**Made with ❤️ using Flutter**
