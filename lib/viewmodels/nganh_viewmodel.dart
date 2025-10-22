// ViewModel quản lý danh sách Ngành
import 'package:flutter/foundation.dart';
import '../models/nganh.dart';
import '../repositories/nganh_repository.dart';

class NganhViewModel extends ChangeNotifier {
  final NganhRepository _repository = NganhRepository();

  List<Nganh> _nganhList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Nganh> get nganhList => _nganhList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Lấy tất cả ngành
  Future<void> loadAllNganh() async {
    _isLoading = true;
    notifyListeners();

    try {
      _nganhList = await _repository.getAllNganh();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Lỗi tải danh sách ngành: $e';
      _nganhList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Lấy ngành theo ID
  Future<Nganh?> getNganhById(int id) async {
    try {
      return await _repository.getNganhById(id);
    } catch (e) {
      _errorMessage = 'Lỗi tải thông tin ngành: $e';
      notifyListeners();
      return null;
    }
  }

  // Thêm ngành mới
  Future<bool> addNganh(Nganh nganh) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.createNganh(nganh);
      await loadAllNganh(); // Tải lại danh sách
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi thêm ngành: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cập nhật ngành
  Future<bool> updateNganh(Nganh nganh) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateNganh(nganh);
      await loadAllNganh(); // Tải lại danh sách
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi cập nhật ngành: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Xóa ngành
  Future<bool> deleteNganh(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteNganh(id);
      await loadAllNganh(); // Tải lại danh sách
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi xóa ngành: $e';
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
