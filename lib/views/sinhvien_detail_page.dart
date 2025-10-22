// Màn hình chi tiết sinh viên
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/sinhvien_viewmodel.dart';
import '../viewmodels/nganh_viewmodel.dart';
import '../models/sinhvien.dart';
import '../models/nganh.dart';
import 'sinhvien_form_page.dart';
import 'map_page.dart';

class SinhvienDetailPage extends StatefulWidget {
  final int sinhvienId;

  const SinhvienDetailPage({Key? key, required this.sinhvienId})
    : super(key: key);

  @override
  State<SinhvienDetailPage> createState() => _SinhvienDetailPageState();
}

class _SinhvienDetailPageState extends State<SinhvienDetailPage> {
  Sinhvien? _sinhvien;
  Nganh? _nganh;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final sinhvienViewModel = Provider.of<SinhvienViewModel>(
      context,
      listen: false,
    );
    final nganhViewModel = Provider.of<NganhViewModel>(context, listen: false);

    final sinhvien = await sinhvienViewModel.getSinhvienById(widget.sinhvienId);
    if (sinhvien != null) {
      final nganh = await nganhViewModel.getNganhById(sinhvien.idNganh);
      setState(() {
        _sinhvien = sinhvien;
        _nganh = nganh;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteSinhvien() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa sinh viên này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final sinhvienViewModel = Provider.of<SinhvienViewModel>(
        context,
        listen: false,
      );
      final success = await sinhvienViewModel.deleteSinhvien(widget.sinhvienId);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã xóa sinh viên'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true); // Quay về và refresh
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lỗi khi xóa sinh viên'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isAdmin = authViewModel.isAdmin;
    final currentUserId = authViewModel.currentUser?.id;

    // Kiểm tra quyền chỉnh sửa: Admin hoặc chính sinh viên đó
    final canEdit = isAdmin || currentUserId == widget.sinhvienId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sinh viên'),
        actions: [
          if (canEdit && _sinhvien != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Chỉnh sửa',
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SinhvienFormPage(sinhvien: _sinhvien),
                  ),
                );
                if (result == true) {
                  _loadData(); // Reload dữ liệu
                }
              },
            ),
          if (isAdmin && _sinhvien != null)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Xóa',
              onPressed: _deleteSinhvien,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sinhvien == null
          ? const Center(child: Text('Không tìm thấy sinh viên'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ảnh đại diện
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _sinhvien!.anh != null &&
                              File(_sinhvien!.anh!).existsSync()
                          ? FileImage(File(_sinhvien!.anh!))
                          : null,
                      child:
                          _sinhvien!.anh == null ||
                              !File(_sinhvien!.anh!).existsSync()
                          ? Text(
                              _sinhvien!.ten.isNotEmpty
                                  ? _sinhvien!.ten[0].toUpperCase()
                                  : 'S',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Thông tin chi tiết
                  _buildInfoCard('Thông tin cá nhân', [
                    _buildInfoRow(Icons.person, 'Họ tên', _sinhvien!.ten),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Ngày sinh',
                      DateFormat('dd/MM/yyyy').format(_sinhvien!.ngaySinh),
                    ),
                    _buildInfoRow(Icons.email, 'Email', _sinhvien!.email),
                    if (_sinhvien!.soDienThoai != null &&
                        _sinhvien!.soDienThoai!.isNotEmpty)
                      _buildInfoRow(
                        Icons.phone,
                        'Số điện thoại',
                        _sinhvien!.soDienThoai!,
                      ),
                    _buildInfoRow(Icons.home, 'Địa chỉ', _sinhvien!.diaChi),
                    _buildInfoRow(
                      Icons.admin_panel_settings,
                      'Vai trò',
                      _sinhvien!.role,
                      valueColor: _sinhvien!.role == 'Admin'
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Thông tin ngành học
                  if (_nganh != null)
                    _buildInfoCard('Thông tin ngành học', [
                      _buildInfoRow(Icons.school, 'Ngành', _nganh!.tenNganh),
                      _buildInfoRow(Icons.description, 'Mô tả', _nganh!.moTa),
                    ]),
                  const SizedBox(height: 16),

                  // Vị trí trên bản đồ
                  if (_sinhvien!.latitude != null &&
                      _sinhvien!.longitude != null)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.map, color: Colors.green),
                        title: const Text('Vị trí trên bản đồ'),
                        subtitle: Text(
                          'Lat: ${_sinhvien!.latitude!.toStringAsFixed(4)}, Lon: ${_sinhvien!.longitude!.toStringAsFixed(4)}',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MapPage(
                                latitude: _sinhvien!.latitude!,
                                longitude: _sinhvien!.longitude!,
                                title: _sinhvien!.ten,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
