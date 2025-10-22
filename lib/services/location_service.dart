// Service xử lý Location và Geolocator
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Kiểm tra và xin quyền truy cập vị trí
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  // Lấy vị trí hiện tại
  Future<Position?> getCurrentLocation() async {
    try {
      // Kiểm tra dịch vụ vị trí có bật không
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Dịch vụ vị trí chưa được bật');
        // Thử mở cài đặt
        await Geolocator.openLocationSettings();
        return null;
      }

      // Kiểm tra quyền hiện tại
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Quyền truy cập vị trí bị từ chối');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Quyền truy cập vị trí bị từ chối vĩnh viễn');
        await Geolocator.openAppSettings();
        return null;
      }

      // Lấy vị trí với timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      print('Vị trí hiện tại: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('Lỗi khi lấy vị trí: $e');
      return null;
    }
  }

  // Tính khoảng cách giữa 2 điểm (theo mét)
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  // Mở cài đặt vị trí
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
}
