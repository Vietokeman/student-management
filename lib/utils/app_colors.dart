// App Colors - Theo Figma Design "Quản Lý Hồ Sơ Sinh Viên"
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Màu chủ đạo
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color secondaryBlue = Color(0xFF64B5F6);
  static const Color lightBlue = Color(0xFF90CAF9);
  static const Color darkBlue = Color(0xFF2196F3);

  // Neutral Colors - Màu trung tính
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color gray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
  static const Color black = Color(0xFF000000);

  // Status Colors - Màu trạng thái
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Text Colors - Màu chữ
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Background Colors - Màu nền
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Role Colors - Màu theo vai trò
  static const Color adminBg = Color(0xFFFFEBEE);
  static const Color adminText = Color(0xFFF44336);
  static const Color studentBg = Color(0xFFE3F2FD);
  static const Color studentText = Color(0xFF2196F3);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90E2), Color(0xFF64B5F6)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4A90E2), Color(0xFF90CAF9)],
  );
}
