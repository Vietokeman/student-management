# 🎨 DESIGN SYSTEM - Màu sắc theo Figma

## 🖌️ Bảng màu chính (Primary Colors)

Dựa trên Figma design "Quản Lý Hồ Sơ Sinh Viên":

### Màu chính
```dart
Primary Blue:     #4A90E2  (74, 144, 226)
Secondary Blue:   #64B5F6  (100, 181, 246)
Light Blue:       #90CAF9  (144, 202, 249)
Dark Blue:        #2196F3  (33, 150, 243)
```

### Màu phụ
```dart
White:            #FFFFFF  (255, 255, 255)
Light Gray:       #F5F5F5  (245, 245, 245)
Gray:             #E0E0E0  (224, 224, 224)
Dark Gray:        #757575  (117, 117, 117)
```

### Màu trạng thái
```dart
Success Green:    #4CAF50  (76, 175, 80)
Warning Orange:   #FF9800  (255, 152, 0)
Error Red:        #F44336  (244, 67, 54)
Info Blue:        #2196F3  (33, 150, 243)
```

---

## 🎯 Sử dụng trong Flutter

### 1. Định nghĩa màu (Tạo file colors.dart)

```dart
// lib/utils/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color secondaryBlue = Color(0xFF64B5F6);
  static const Color lightBlue = Color(0xFF90CAF9);
  static const Color darkBlue = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color gray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
  static const Color black = Color(0xFF000000);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4A90E2),
      Color(0xFF64B5F6),
    ],
  );
}
```

### 2. Cập nhật Theme trong main.dart

File `main.dart` đã được cập nhật với màu mới ✅

### 3. Sử dụng màu trong widgets

```dart
// Ví dụ 1: AppBar
AppBar(
  backgroundColor: AppColors.primaryBlue,
  foregroundColor: AppColors.white,
  title: const Text('Quản lý Sinh viên'),
)

// Ví dụ 2: Button
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.white,
  ),
  onPressed: () {},
  child: const Text('Đăng nhập'),
)

// Ví dụ 3: Card
Card(
  color: AppColors.cardBackground,
  elevation: 2,
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: AppColors.primaryBlue,
      child: Icon(Icons.person, color: AppColors.white),
    ),
    title: Text(
      'Nguyễn Văn A',
      style: TextStyle(color: AppColors.textPrimary),
    ),
  ),
)

// Ví dụ 4: SnackBar
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Thành công!'),
    backgroundColor: AppColors.success,
  ),
)

// Ví dụ 5: Container với gradient
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Center(
    child: Text(
      'Quản Lý Hồ Sơ Sinh Viên',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
```

---

## 🎨 Component Colors

### AppBar
```dart
backgroundColor: Color(0xFF4A90E2)
foregroundColor: Color(0xFFFFFFFF)
elevation: 0
```

### FloatingActionButton
```dart
backgroundColor: Color(0xFF4A90E2)
foregroundColor: Color(0xFFFFFFFF)
```

### Card
```dart
color: Color(0xFFFFFFFF)
elevation: 2
shadowColor: Colors.black26
```

### TextField/TextFormField
```dart
fillColor: Color(0xFFF5F5F5)
borderColor: Color(0xFFE0E0E0)
focusedBorderColor: Color(0xFF4A90E2)
errorBorderColor: Color(0xFFF44336)
```

### Button
```dart
// Primary Button
backgroundColor: Color(0xFF4A90E2)
foregroundColor: Color(0xFFFFFFFF)

// Secondary Button
backgroundColor: Color(0xFFE0E0E0)
foregroundColor: Color(0xFF212121)

// Danger Button
backgroundColor: Color(0xFFF44336)
foregroundColor: Color(0xFFFFFFFF)
```

### Avatar/Icon
```dart
backgroundColor: Color(0xFF4A90E2)
iconColor: Color(0xFFFFFFFF)
```

### Chip/Badge
```dart
// Admin
backgroundColor: Color(0xFFFFEBEE)  // Red tint
labelColor: Color(0xFFF44336)

// Sinh viên
backgroundColor: Color(0xFFE3F2FD)  // Blue tint
labelColor: Color(0xFF2196F3)
```

---

## 📱 Áp dụng cho từng màn hình

### 1. Login/Register Screen
- Background: Gradient (primaryBlue → secondaryBlue)
- Card: White với shadow nhẹ
- Button: primaryBlue
- TextField: lightGray background

### 2. Home Screen (Danh sách SV)
- AppBar: primaryBlue
- Background: lightGray
- Card: White
- FAB: primaryBlue

### 3. Detail Screen
- AppBar: primaryBlue
- Background: White
- Card: lightGray
- Action buttons: primaryBlue

### 4. Form Screen
- AppBar: primaryBlue
- Background: White
- TextField: lightGray fill
- Save button: primaryBlue

### 5. Map Screen
- Marker color: primaryBlue
- FAB: primaryBlue

---

## 🎯 Typography

### Font sizes
```dart
Heading 1:      32sp (Bold)
Heading 2:      24sp (Bold)
Heading 3:      20sp (SemiBold)
Body 1:         16sp (Regular)
Body 2:         14sp (Regular)
Caption:        12sp (Regular)
Button:         16sp (Medium)
```

### Text Styles
```dart
// lib/utils/text_styles.dart
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
```

---

## 🌈 Dark Mode (Optional - Future)

```dart
// Nếu muốn thêm Dark Mode sau này
class AppColorsDark {
  static const Color primaryBlue = Color(0xFF64B5F6);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
}
```

---

## 📦 Cài đặt đầy đủ

### Bước 1: Tạo file colors.dart
```bash
# Tạo thư mục utils
mkdir lib/utils

# Tạo file
touch lib/utils/app_colors.dart
```

### Bước 2: Copy code colors vào file

### Bước 3: Import và sử dụng
```dart
import 'package:prm392_student_management/utils/app_colors.dart';

// Sử dụng
Container(
  color: AppColors.primaryBlue,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.white),
  ),
)
```

---

## ✅ Checklist áp dụng màu

- [x] Cập nhật Theme trong main.dart
- [ ] Tạo file app_colors.dart
- [ ] Cập nhật màu AppBar trong tất cả screens
- [ ] Cập nhật màu Button
- [ ] Cập nhật màu FAB
- [ ] Cập nhật màu Card
- [ ] Cập nhật màu TextField
- [ ] Cập nhật màu SnackBar (success/error)
- [ ] Cập nhật màu Chip/Badge (Admin/Sinhvien)
- [ ] Test trên nhiều screens

---

## 🎨 Preview màu

Bạn có thể test màu tại: https://www.color-hex.com/color/4a90e2

**Màu chính #4A90E2 là màu xanh dương sáng, phù hợp với theme giáo dục!** ✨
