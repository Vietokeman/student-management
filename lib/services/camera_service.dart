// Service xử lý Camera và chọn ảnh
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  // Kiểm tra và xin quyền camera
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Kiểm tra và xin quyền thư viện ảnh
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.photos.request();
      return status.isGranted || status.isLimited;
    }
    return true;
  }

  // Chụp ảnh từ camera
  Future<File?> takePhoto() async {
    try {
      // Xin quyền camera
      final hasPermission = await requestCameraPermission();
      if (!hasPermission) {
        print('Không có quyền truy cập camera');
        return null;
      }

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      print('Lỗi khi chụp ảnh: $e');
      return null;
    }
  }

  // Chọn ảnh từ thư viện
  Future<File?> pickImageFromGallery() async {
    try {
      // Xin quyền thư viện
      final hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        print('Không có quyền truy cập thư viện ảnh');
        return null;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Lỗi khi chọn ảnh: $e');
      return null;
    }
  }

  // Hiển thị dialog cho phép chọn camera hoặc thư viện
  Future<File?> pickImage({bool fromCamera = false}) async {
    if (fromCamera) {
      return await takePhoto();
    } else {
      return await pickImageFromGallery();
    }
  }
}
