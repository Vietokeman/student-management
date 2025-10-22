// Màn hình Profile - Thông tin cá nhân
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../viewmodels/auth_viewmodel.dart';
import 'sinhvien_form_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final currentUser = authViewModel.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Chưa đăng nhập')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Chỉnh sửa',
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SinhvienFormPage(sinhvien: currentUser),
                ),
              );

              // Reload user data sau khi edit
              if (result == true && context.mounted) {
                await Provider.of<AuthViewModel>(
                  context,
                  listen: false,
                ).refreshCurrentUser();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  currentUser.anh != null && File(currentUser.anh!).existsSync()
                  ? FileImage(File(currentUser.anh!))
                  : null,
              child:
                  currentUser.anh == null ||
                      !File(currentUser.anh!).existsSync()
                  ? Text(
                      currentUser.ten.isNotEmpty
                          ? currentUser.ten[0].toUpperCase()
                          : 'S',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              currentUser.ten,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(currentUser.role),
              backgroundColor: currentUser.role == 'Admin'
                  ? Colors.red.shade100
                  : Colors.blue.shade100,
            ),
            const SizedBox(height: 24),

            // Thông tin
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(currentUser.email),
                  ),
                  if (currentUser.soDienThoai != null &&
                      currentUser.soDienThoai!.isNotEmpty)
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Số điện thoại'),
                      subtitle: Text(currentUser.soDienThoai!),
                    ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Địa chỉ'),
                    subtitle: Text(currentUser.diaChi),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Nút xóa tài khoản
            ElevatedButton.icon(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Xác nhận xóa tài khoản'),
                    content: const Text(
                      'Bạn có chắc muốn xóa tài khoản? Hành động này không thể hoàn tác.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Xóa'),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  final success = await authViewModel.deleteAccount(
                    currentUser.id!,
                  );
                  if (context.mounted && success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã xóa tài khoản'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }
                }
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text('Xóa tài khoản'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
