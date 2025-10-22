// Model cho Ngành học
class Nganh {
  final int? id;
  final String tenNganh;
  final String moTa;

  Nganh({this.id, required this.tenNganh, required this.moTa});

  // Chuyển từ Map sang Object
  factory Nganh.fromMap(Map<String, dynamic> map) {
    return Nganh(
      id: map['Id'] as int?,
      tenNganh: map['TenNganh'] as String,
      moTa: map['MoTa'] as String,
    );
  }

  // Chuyển từ Object sang Map
  Map<String, dynamic> toMap() {
    return {'Id': id, 'TenNganh': tenNganh, 'MoTa': moTa};
  }

  // Copy với các thuộc tính có thể thay đổi
  Nganh copyWith({int? id, String? tenNganh, String? moTa}) {
    return Nganh(
      id: id ?? this.id,
      tenNganh: tenNganh ?? this.tenNganh,
      moTa: moTa ?? this.moTa,
    );
  }

  @override
  String toString() {
    return 'Nganh{id: $id, tenNganh: $tenNganh, moTa: $moTa}';
  }
}
