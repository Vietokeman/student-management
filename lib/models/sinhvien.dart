// Model cho Sinh viên
class Sinhvien {
  final int? id;
  final String ten;
  final DateTime ngaySinh;
  final String diaChi;
  final int idNganh;
  final String? anh; // Đường dẫn ảnh
  final String? soDienThoai;
  final String email;
  final String matKhau;
  final String role; // 'Admin' hoặc 'Sinhvien'
  final double? latitude;
  final double? longitude;

  Sinhvien({
    this.id,
    required this.ten,
    required this.ngaySinh,
    required this.diaChi,
    required this.idNganh,
    this.anh,
    this.soDienThoai,
    required this.email,
    required this.matKhau,
    this.role = 'Sinhvien',
    this.latitude,
    this.longitude,
  });

  // Chuyển từ Map sang Object
  factory Sinhvien.fromMap(Map<String, dynamic> map) {
    return Sinhvien(
      id: map['Id'] as int?,
      ten: map['Ten'] as String,
      ngaySinh: DateTime.parse(map['NgaySinh'] as String),
      diaChi: map['DiaChi'] as String,
      idNganh: map['IdNganh'] as int,
      anh: map['Anh'] as String?,
      soDienThoai: map['SoDienThoai'] as String?,
      email: map['Email'] as String,
      matKhau: map['MatKhau'] as String,
      role: map['Role'] as String? ?? 'Sinhvien',
      latitude: map['Latitude'] as double?,
      longitude: map['Longitude'] as double?,
    );
  }

  // Chuyển từ Object sang Map
  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Ten': ten,
      'NgaySinh': ngaySinh.toIso8601String(),
      'DiaChi': diaChi,
      'IdNganh': idNganh,
      'Anh': anh,
      'SoDienThoai': soDienThoai,
      'Email': email,
      'MatKhau': matKhau,
      'Role': role,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }

  // Copy với các thuộc tính có thể thay đổi
  Sinhvien copyWith({
    int? id,
    String? ten,
    DateTime? ngaySinh,
    String? diaChi,
    int? idNganh,
    String? anh,
    String? soDienThoai,
    String? email,
    String? matKhau,
    String? role,
    double? latitude,
    double? longitude,
  }) {
    return Sinhvien(
      id: id ?? this.id,
      ten: ten ?? this.ten,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      diaChi: diaChi ?? this.diaChi,
      idNganh: idNganh ?? this.idNganh,
      anh: anh ?? this.anh,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      email: email ?? this.email,
      matKhau: matKhau ?? this.matKhau,
      role: role ?? this.role,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'Sinhvien{id: $id, ten: $ten, email: $email, role: $role}';
  }
}
