// Repository cho Ngành - Tầng trung gian giữa DB và ViewModel
import '../db/database_helper.dart';
import '../models/nganh.dart';

class NganhRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Nganh>> getAllNganh() async {
    return await _dbHelper.getAllNganh();
  }

  Future<Nganh?> getNganhById(int id) async {
    return await _dbHelper.getNganhById(id);
  }

  Future<Nganh> createNganh(Nganh nganh) async {
    return await _dbHelper.createNganh(nganh);
  }

  Future<int> updateNganh(Nganh nganh) async {
    return await _dbHelper.updateNganh(nganh);
  }

  Future<int> deleteNganh(int id) async {
    return await _dbHelper.deleteNganh(id);
  }
}
