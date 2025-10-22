// Repository cho Sinh viên - Tầng trung gian giữa DB và ViewModel
import '../db/database_helper.dart';
import '../models/sinhvien.dart';

class SinhvienRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Sinhvien>> getAllSinhvien() async {
    return await _dbHelper.getAllSinhvien();
  }

  Future<Sinhvien?> getSinhvienById(int id) async {
    return await _dbHelper.getSinhvienById(id);
  }

  Future<Sinhvien?> getSinhvienByEmail(String email) async {
    return await _dbHelper.getSinhvienByEmail(email);
  }

  Future<List<Sinhvien>> getSinhvienByNganh(int idNganh) async {
    return await _dbHelper.getSinhvienByNganh(idNganh);
  }

  Future<Sinhvien> createSinhvien(Sinhvien sinhvien) async {
    return await _dbHelper.createSinhvien(sinhvien);
  }

  Future<int> updateSinhvien(Sinhvien sinhvien) async {
    return await _dbHelper.updateSinhvien(sinhvien);
  }

  Future<int> deleteSinhvien(int id) async {
    return await _dbHelper.deleteSinhvien(id);
  }

  Future<bool> isEmailExists(String email, {int? excludeId}) async {
    return await _dbHelper.isEmailExists(email, excludeId: excludeId);
  }

  // Xác thực đăng nhập
  Future<Sinhvien?> authenticate(String email, String password) async {
    final sinhvien = await _dbHelper.getSinhvienByEmail(email);
    if (sinhvien != null && sinhvien.matKhau == password) {
      return sinhvien;
    }
    return null;
  }
}
