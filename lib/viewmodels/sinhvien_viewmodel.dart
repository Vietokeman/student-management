// ViewModel quản lý danh sách Sinh viên
import 'package:flutter/foundation.dart';
import '../models/sinhvien.dart';
import '../repositories/sinhvien_repository.dart';

class SinhvienViewModel extends ChangeNotifier {
  final SinhvienRepository _repository = SinhvienRepository();

  List<Sinhvien> _sinhvienList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Sinhvien> get sinhvienList => _sinhvienList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Lấy tất cả sinh viên
  Future<void> loadAllSinhvien() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sinhvienList = await _repository.getAllSinhvien();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Lỗi tải danh sách: $e';
      _sinhvienList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load chỉ sinh viên hiện tại (cho sinh viên thường)
  Future<void> loadCurrentUserOnly(Sinhvien currentUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      _sinhvienList = [currentUser];
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Lỗi tải thông tin: $e';
      _sinhvienList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Lấy sinh viên theo ID
  Future<Sinhvien?> getSinhvienById(int id) async {
    try {
      return await _repository.getSinhvienById(id);
    } catch (e) {
      _errorMessage = 'Lỗi tải thông tin: $e';
      notifyListeners();
      return null;
    }
  }

  // Lấy sinh viên theo ngành
  Future<void> loadSinhvienByNganh(int idNganh) async {
    _isLoading = true;
    notifyListeners();

    try {
      _sinhvienList = await _repository.getSinhvienByNganh(idNganh);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Lỗi tải danh sách: $e';
      _sinhvienList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Thêm sinh viên mới
  Future<bool> addSinhvien(Sinhvien sinhvien) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Kiểm tra email
      final emailExists = await _repository.isEmailExists(sinhvien.email);
      if (emailExists) {
        _errorMessage = 'Email đã được sử dụng';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await _repository.createSinhvien(sinhvien);
      await loadAllSinhvien(); // Tải lại danh sách
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi thêm sinh viên: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cập nhật sinh viên
  Future<bool> updateSinhvien(Sinhvien sinhvien) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Kiểm tra email (trừ email của chính sinh viên này)
      final emailExists = await _repository.isEmailExists(
        sinhvien.email,
        excludeId: sinhvien.id,
      );
      if (emailExists) {
        _errorMessage = 'Email đã được sử dụng';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await _repository.updateSinhvien(sinhvien);

      // Cập nhật trong list nếu sinh viên đang có trong list
      final index = _sinhvienList.indexWhere((s) => s.id == sinhvien.id);
      if (index != -1) {
        _sinhvienList[index] = sinhvien;
      }

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

  // Xóa sinh viên
  Future<bool> deleteSinhvien(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteSinhvien(id);

      // Xóa khỏi list hiện tại
      _sinhvienList.removeWhere((s) => s.id == id);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi xóa sinh viên: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
