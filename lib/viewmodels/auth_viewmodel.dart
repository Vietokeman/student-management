// ViewModel quản lý Authentication (Đăng nhập/Đăng ký)
import 'package:flutter/foundation.dart';
import '../models/sinhvien.dart';
import '../repositories/sinhvien_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final SinhvienRepository _repository = SinhvienRepository();

  Sinhvien? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  Sinhvien? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.role == 'Admin';

  // Đăng nhập
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _repository.authenticate(email, password);
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Email hoặc mật khẩu không đúng';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Lỗi đăng nhập: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Đăng ký
  Future<bool> register(Sinhvien sinhvien) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Kiểm tra email đã tồn tại
      final emailExists = await _repository.isEmailExists(sinhvien.email);
      if (emailExists) {
        _errorMessage = 'Email đã được sử dụng';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Tạo tài khoản mới
      final newUser = await _repository.createSinhvien(sinhvien);
      _currentUser = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi đăng ký: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Đăng xuất
  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Cập nhật thông tin user hiện tại
  Future<bool> updateCurrentUser(Sinhvien updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateSinhvien(updatedUser);
      _currentUser = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi cập nhật: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Xóa tài khoản
  Future<bool> deleteAccount(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteSinhvien(id);
      if (_currentUser?.id == id) {
        logout();
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi xóa tài khoản: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Refresh current user data from database
  Future<void> refreshCurrentUser() async {
    if (_currentUser == null) return;

    try {
      final updatedUser = await _repository.getSinhvienById(_currentUser!.id!);
      if (updatedUser != null) {
        _currentUser = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Lỗi làm mới dữ liệu: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
