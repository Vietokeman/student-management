// SQLite Database Helper - Quản lý database và CRUD operations
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/nganh.dart';
import '../models/sinhvien.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('student_management.db');
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('📍 Database path: $path');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Tạo bảng
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNullable = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL';

    // Tạo bảng Nganh
    await db.execute('''
      CREATE TABLE Nganh (
        Id $idType,
        TenNganh $textType,
        MoTa $textType
      )
    ''');

    // Tạo bảng Sinhvien
    await db.execute('''
      CREATE TABLE Sinhvien (
        Id $idType,
        Ten $textType,
        NgaySinh $textType,
        DiaChi $textType,
        IdNganh $intType,
        Anh $textTypeNullable,
        SoDienThoai $textTypeNullable,
        Email $textType UNIQUE,
        MatKhau $textType,
        Role $textType,
        Latitude $realType,
        Longitude $realType,
        FOREIGN KEY (IdNganh) REFERENCES Nganh (Id) ON DELETE CASCADE
      )
    ''');

    // Thêm dữ liệu mẫu cho Nganh
    await db.insert('Nganh', {
      'TenNganh': 'Kĩ thuật Phần mềm',
      'MoTa': 'Ngành đào tạo kỹ sư phần mềm chuyên nghiệp (SE)',
    });
    await db.insert('Nganh', {
      'TenNganh': 'Trí tuệ Nhân tạo',
      'MoTa': 'Ngành nghiên cứu và ứng dụng AI (IA)',
    });
    await db.insert('Nganh', {
      'TenNganh': 'Thiết kế Đồ họa',
      'MoTa': 'Ngành thiết kế kỹ thuật số và đồ họa (GD)',
    });
    await db.insert('Nganh', {
      'TenNganh': 'Kinh doanh Quốc tế',
      'MoTa': 'Ngành kinh doanh và thương mại quốc tế (IB)',
    });

    // Thêm tài khoản Admin mặc định
    await db.insert('Sinhvien', {
      'Ten': 'Administrator',
      'NgaySinh': DateTime(1990, 1, 1).toIso8601String(),
      'DiaChi': 'FPT University',
      'IdNganh': 1,
      'Anh': null,
      'SoDienThoai': '0123456789',
      'Email': 'admin@fpt.edu.vn',
      'MatKhau': 'admin123',
      'Role': 'Admin',
      'Latitude': 10.8411,
      'Longitude': 106.8098,
    });

    // Thêm 10 sinh viên mẫu
    final sinhvienList = [
      {
        'Ten': 'Trần Quang Nguyên',
        'NgaySinh': DateTime(2001, 3, 15).toIso8601String(),
        'DiaChi': 'TP Hồ Chí Minh',
        'IdNganh': 2,
        'Anh': null,
        'SoDienThoai': '0912345678',
        'Email': 'de180698@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 10.7769,
        'Longitude': 106.7009,
      },
      {
        'Ten': 'Lê Vĩnh Phát',
        'NgaySinh': DateTime(2001, 7, 22).toIso8601String(),
        'DiaChi': 'Cần Thơ',
        'IdNganh': 3,
        'Anh': null,
        'SoDienThoai': '0987654321',
        'Email': 'he179015@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 10.0452,
        'Longitude': 105.7469,
      },
      {
        'Ten': 'Nguyễn Mai Thành Nam',
        'NgaySinh': DateTime(2002, 2, 11).toIso8601String(),
        'DiaChi': 'Đà Nẵng',
        'IdNganh': 4,
        'Anh': null,
        'SoDienThoai': '0909876543',
        'Email': 'se170240@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 16.0471,
        'Longitude': 108.2068,
      },
      {
        'Ten': 'Phan Vũ Khánh Tiến',
        'NgaySinh': DateTime(2001, 10, 8).toIso8601String(),
        'DiaChi': 'Hà Nội',
        'IdNganh': 2,
        'Anh': null,
        'SoDienThoai': '0932123456',
        'Email': 'se170488@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 21.0285,
        'Longitude': 105.8542,
      },
      {
        'Ten': 'Ni Vũ Đức',
        'NgaySinh': DateTime(2002, 5, 27).toIso8601String(),
        'DiaChi': 'Huế',
        'IdNganh': 3,
        'Anh': null,
        'SoDienThoai': '0978123456',
        'Email': 'se172191@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 16.4637,
        'Longitude': 107.5909,
      },
      {
        'Ten': 'Nguyễn Phú Cường',
        'NgaySinh': DateTime(2001, 9, 13).toIso8601String(),
        'DiaChi': 'Biên Hòa',
        'IdNganh': 2,
        'Anh': null,
        'SoDienThoai': '0956123456',
        'Email': 'se173621@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 10.9483,
        'Longitude': 106.8246,
      },
      {
        'Ten': 'Đào Công An Phước',
        'NgaySinh': DateTime(2002, 12, 1).toIso8601String(),
        'DiaChi': 'Vũng Tàu',
        'IdNganh': 4,
        'Anh': null,
        'SoDienThoai': '0911987654',
        'Email': 'se180581@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 10.4114,
        'Longitude': 107.1362,
      },
      {
        'Ten': 'Nguyễn Việt',
        'NgaySinh': DateTime(2002, 3, 30).toIso8601String(),
        'DiaChi': 'TP Thủ Đức',
        'IdNganh': 2,
        'Anh': null,
        'SoDienThoai': '0933322110',
        'Email': 'se180672@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 10.8411,
        'Longitude': 106.8098,
      },
      {
        'Ten': 'Hoàng Quốc An',
        'NgaySinh': DateTime(2001, 8, 17).toIso8601String(),
        'DiaChi': 'Đà Lạt',
        'IdNganh': 3,
        'Anh': null,
        'SoDienThoai': '0944221133',
        'Email': 'se181520@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 11.9404,
        'Longitude': 108.4583,
      },
      {
        'Ten': 'Trần Đình Thịnh',
        'NgaySinh': DateTime(2001, 4, 10).toIso8601String(),
        'DiaChi': 'Nha Trang',
        'IdNganh': 4,
        'Anh': null,
        'SoDienThoai': '0988776655',
        'Email': 'se181531@fpt.edu.vn',
        'MatKhau': '123456',
        'Role': 'Sinhvien',
        'Latitude': 12.2388,
        'Longitude': 109.1967,
      },
    ];

    for (final sv in sinhvienList) {
      await db.insert('Sinhvien', sv);
    }
  }

  // ============ CRUD cho Nganh ============

  // Tạo Ngành mới
  Future<Nganh> createNganh(Nganh nganh) async {
    final db = await instance.database;
    final id = await db.insert('Nganh', nganh.toMap());
    return nganh.copyWith(id: id);
  }

  // Lấy tất cả Ngành
  Future<List<Nganh>> getAllNganh() async {
    final db = await instance.database;
    const orderBy = 'TenNganh ASC';
    final result = await db.query('Nganh', orderBy: orderBy);
    return result.map((json) => Nganh.fromMap(json)).toList();
  }

  // Lấy Ngành theo ID
  Future<Nganh?> getNganhById(int id) async {
    final db = await instance.database;
    final maps = await db.query('Nganh', where: 'Id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Nganh.fromMap(maps.first);
    }
    return null;
  }

  // Cập nhật Ngành
  Future<int> updateNganh(Nganh nganh) async {
    final db = await instance.database;
    return db.update(
      'Nganh',
      nganh.toMap(),
      where: 'Id = ?',
      whereArgs: [nganh.id],
    );
  }

  // Xóa Ngành
  Future<int> deleteNganh(int id) async {
    final db = await instance.database;
    return await db.delete('Nganh', where: 'Id = ?', whereArgs: [id]);
  }

  // ============ CRUD cho Sinhvien ============

  // Tạo Sinh viên mới
  Future<Sinhvien> createSinhvien(Sinhvien sinhvien) async {
    final db = await instance.database;
    final id = await db.insert('Sinhvien', sinhvien.toMap());
    return sinhvien.copyWith(id: id);
  }

  // Lấy tất cả Sinh viên
  Future<List<Sinhvien>> getAllSinhvien() async {
    final db = await instance.database;
    const orderBy = 'Ten ASC';
    final result = await db.query('Sinhvien', orderBy: orderBy);
    return result.map((json) => Sinhvien.fromMap(json)).toList();
  }

  // Lấy Sinh viên theo ID
  Future<Sinhvien?> getSinhvienById(int id) async {
    final db = await instance.database;
    final maps = await db.query('Sinhvien', where: 'Id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Sinhvien.fromMap(maps.first);
    }
    return null;
  }

  // Lấy Sinh viên theo Email (dùng cho đăng nhập)
  Future<Sinhvien?> getSinhvienByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      'Sinhvien',
      where: 'Email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Sinhvien.fromMap(maps.first);
    }
    return null;
  }

  // Lấy Sinh viên theo Ngành
  Future<List<Sinhvien>> getSinhvienByNganh(int idNganh) async {
    final db = await instance.database;
    final result = await db.query(
      'Sinhvien',
      where: 'IdNganh = ?',
      whereArgs: [idNganh],
      orderBy: 'Ten ASC',
    );
    return result.map((json) => Sinhvien.fromMap(json)).toList();
  }

  // Cập nhật Sinh viên
  Future<int> updateSinhvien(Sinhvien sinhvien) async {
    final db = await instance.database;
    return db.update(
      'Sinhvien',
      sinhvien.toMap(),
      where: 'Id = ?',
      whereArgs: [sinhvien.id],
    );
  }

  // Xóa Sinh viên
  Future<int> deleteSinhvien(int id) async {
    final db = await instance.database;
    return await db.delete('Sinhvien', where: 'Id = ?', whereArgs: [id]);
  }

  // Kiểm tra email đã tồn tại chưa
  Future<bool> isEmailExists(String email, {int? excludeId}) async {
    final db = await instance.database;
    String whereClause = 'Email = ?';
    List<dynamic> whereArgs = [email];

    if (excludeId != null) {
      whereClause += ' AND Id != ?';
      whereArgs.add(excludeId);
    }

    final result = await db.query(
      'Sinhvien',
      where: whereClause,
      whereArgs: whereArgs,
    );
    return result.isNotEmpty;
  }

  // Đóng database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
