// Màn hình Form thêm/sửa sinh viên
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/sinhvien_viewmodel.dart';
import '../viewmodels/nganh_viewmodel.dart';
import '../models/sinhvien.dart';
import '../models/nganh.dart';
import '../services/camera_service.dart';
import '../services/contact_service.dart';
import '../services/location_service.dart';
import 'location_picker_page.dart';

class SinhvienFormPage extends StatefulWidget {
  final Sinhvien? sinhvien; // null = thêm mới, có giá trị = sửa

  const SinhvienFormPage({Key? key, this.sinhvien}) : super(key: key);

  @override
  State<SinhvienFormPage> createState() => _SinhvienFormPageState();
}

class _SinhvienFormPageState extends State<SinhvienFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tenController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _diaChiController;
  late TextEditingController _soDienThoaiController;

  DateTime _ngaySinh = DateTime.now().subtract(const Duration(days: 6570));
  int? _selectedNganhId;
  String? _anhPath;
  String _role = 'Sinhvien';
  double? _latitude;
  double? _longitude;

  final CameraService _cameraService = CameraService();
  final ContactService _contactService = ContactService();
  final LocationService _locationService = LocationService();

  bool get isEditMode => widget.sinhvien != null;

  @override
  void initState() {
    super.initState();
    _tenController = TextEditingController(text: widget.sinhvien?.ten ?? '');
    _emailController = TextEditingController(
      text: widget.sinhvien?.email ?? '',
    );
    _passwordController = TextEditingController(
      text: widget.sinhvien?.matKhau ?? '',
    );
    _diaChiController = TextEditingController(
      text: widget.sinhvien?.diaChi ?? '',
    );
    _soDienThoaiController = TextEditingController(
      text: widget.sinhvien?.soDienThoai ?? '',
    );

    if (widget.sinhvien != null) {
      _ngaySinh = widget.sinhvien!.ngaySinh;
      _selectedNganhId = widget.sinhvien!.idNganh;
      _anhPath = widget.sinhvien!.anh;
      _role = widget.sinhvien!.role;
      _latitude = widget.sinhvien!.latitude;
      _longitude = widget.sinhvien!.longitude;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NganhViewModel>(context, listen: false).loadAllNganh();
    });
  }

  @override
  void dispose() {
    _tenController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _diaChiController.dispose();
    _soDienThoaiController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _ngaySinh,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _ngaySinh = picked;
      });
    }
  }

  Future<void> _pickImage(bool fromCamera) async {
    final file = await _cameraService.pickImage(fromCamera: fromCamera);
    if (file != null) {
      setState(() {
        _anhPath = file.path;
      });
    }
  }

  Future<void> _pickContact() async {
    final contact = await _contactService.pickContact();
    if (contact != null) {
      final phone = _contactService.getPhoneNumber(contact);
      if (phone != null) {
        setState(() {
          _soDienThoaiController.text = phone;
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã cập nhật vị trí'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không thể lấy vị trí'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickLocationFromMap() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationPickerPage(
          initialLatitude: _latitude,
          initialLongitude: _longitude,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _latitude = result['latitude'];
        _longitude = result['longitude'];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đã chọn vị trí: ${_latitude!.toStringAsFixed(4)}, ${_longitude!.toStringAsFixed(4)}',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedNganhId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ngành học'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final sinhvienViewModel = Provider.of<SinhvienViewModel>(
        context,
        listen: false,
      );

      final sinhvien = Sinhvien(
        id: widget.sinhvien?.id,
        ten: _tenController.text.trim(),
        ngaySinh: _ngaySinh,
        diaChi: _diaChiController.text.trim(),
        idNganh: _selectedNganhId!,
        anh: _anhPath,
        soDienThoai: _soDienThoaiController.text.trim(),
        email: _emailController.text.trim(),
        matKhau: _passwordController.text,
        role: _role,
        latitude: _latitude,
        longitude: _longitude,
      );

      bool success;
      if (isEditMode) {
        success = await sinhvienViewModel.updateSinhvien(sinhvien);
      } else {
        success = await sinhvienViewModel.addSinhvien(sinhvien);
      }

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditMode ? 'Cập nhật thành công' : 'Thêm thành công',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sinhvienViewModel.errorMessage ?? 'Lỗi'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Chỉnh sửa sinh viên' : 'Thêm sinh viên'),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ảnh đại diện
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _anhPath != null && File(_anhPath!).existsSync()
                          ? FileImage(File(_anhPath!))
                          : null,
                      child: _anhPath == null || !File(_anhPath!).existsSync()
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text('Chụp ảnh'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(true);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Chọn từ thư viện'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(false);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Họ tên
              TextFormField(
                controller: _tenController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                enabled: !isEditMode, // Không cho sửa email
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!value.contains('@')) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mật khẩu (chỉ hiện khi thêm mới)
              if (!isEditMode)
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu *',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
              if (!isEditMode) const SizedBox(height: 16),

              // Số điện thoại với nút chọn từ danh bạ
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _soDienThoaiController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.contacts),
                    onPressed: _pickContact,
                    tooltip: 'Chọn từ danh bạ',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ngày sinh
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Ngày sinh *',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(DateFormat('dd/MM/yyyy').format(_ngaySinh)),
                ),
              ),
              const SizedBox(height: 16),

              // Địa chỉ với nút chọn trên bản đồ
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _diaChiController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Địa chỉ *',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập địa chỉ';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: _pickLocationFromMap,
                        tooltip: 'Chọn trên bản đồ',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      if (_latitude != null && _longitude != null)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ngành học
              Consumer<NganhViewModel>(
                builder: (context, nganhViewModel, child) {
                  return DropdownButtonFormField<int>(
                    value: _selectedNganhId,
                    decoration: const InputDecoration(
                      labelText: 'Ngành học *',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    items: nganhViewModel.nganhList.map((Nganh nganh) {
                      return DropdownMenuItem<int>(
                        value: nganh.id,
                        child: Text(nganh.tenNganh),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedNganhId = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Vai trò (chỉ admin mới được thay đổi)
              if (isAdmin)
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(
                    labelText: 'Vai trò',
                    prefixIcon: Icon(Icons.admin_panel_settings),
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Sinhvien',
                      child: Text('Sinh viên'),
                    ),
                    DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _role = value;
                      });
                    }
                  },
                ),
              if (isAdmin) const SizedBox(height: 16),

              // Vị trí
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.my_location),
                label: Text(
                  _latitude != null && _longitude != null
                      ? 'Cập nhật vị trí (${_latitude!.toStringAsFixed(4)}, ${_longitude!.toStringAsFixed(4)})'
                      : 'Lấy vị trí hiện tại',
                ),
              ),
              const SizedBox(height: 24),

              // Nút lưu
              Consumer<SinhvienViewModel>(
                builder: (context, sinhvienViewModel, child) {
                  return ElevatedButton(
                    onPressed: sinhvienViewModel.isLoading ? null : _save,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: sinhvienViewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEditMode ? 'Cập nhật' : 'Thêm mới'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
