// Màn hình Home - Hiển thị danh sách sinh viên
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/sinhvien_viewmodel.dart';
import '../viewmodels/nganh_viewmodel.dart';
import '../models/sinhvien.dart';
import 'login_page.dart';
import 'sinhvien_detail_page.dart';
import 'sinhvien_form_page.dart';
import 'nganh_list_page.dart';
import 'profile_page.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load dữ liệu khi khởi động
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final sinhvienViewModel = Provider.of<SinhvienViewModel>(
        context,
        listen: false,
      );

      print('🔐 Current User: ${authViewModel.currentUser?.ten}');
      print('🔐 Role: ${authViewModel.currentUser?.role}');
      print('🔐 Is Admin: ${authViewModel.isAdmin}');

      // Admin thấy tất cả, Sinh viên chỉ thấy chính mình
      if (authViewModel.isAdmin) {
        print('📋 Loading ALL students (Admin mode)');
        sinhvienViewModel.loadAllSinhvien();
      } else {
        print('👤 Loading CURRENT USER only (Student mode)');
        sinhvienViewModel.loadCurrentUserOnly(authViewModel.currentUser!);
      }

      Provider.of<NganhViewModel>(context, listen: false).loadAllNganh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final isAdmin = authViewModel.isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Sinh viên'),
        actions: [
          // Nút quản lý ngành (chỉ admin)
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.category),
              tooltip: 'Quản lý ngành',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NganhListPage()),
                );
              },
            ),
          // Nút profile
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Thông tin cá nhân',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          ),
          // Nút đăng xuất
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Đăng xuất'),
                  content: const Text('Bạn có chắc muốn đăng xuất?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        authViewModel.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                          (route) => false,
                        );
                      },
                      child: const Text('Đăng xuất'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<SinhvienViewModel>(
        builder: (context, sinhvienViewModel, child) {
          if (sinhvienViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (sinhvienViewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(sinhvienViewModel.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      sinhvienViewModel.loadAllSinhvien();
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          final sinhvienList = sinhvienViewModel.sinhvienList;

          if (sinhvienList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Chưa có sinh viên nào',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (authViewModel.isAdmin) {
                await sinhvienViewModel.loadAllSinhvien();
              } else {
                await sinhvienViewModel.loadCurrentUserOnly(
                  authViewModel.currentUser!,
                );
              }
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: sinhvienList.length,
              itemBuilder: (context, index) {
                final sinhvien = sinhvienList[index];
                return _buildSinhvienCard(context, sinhvien, isAdmin);
              },
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SinhvienFormPage()),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildSinhvienCard(
    BuildContext context,
    Sinhvien sinhvien,
    bool isAdmin,
  ) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final currentUser = authViewModel.currentUser;

    // Sinh viên chỉ được xem detail của chính mình
    final canViewDetail = isAdmin || (currentUser?.id == sinhvien.id);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              sinhvien.anh != null && File(sinhvien.anh!).existsSync()
              ? FileImage(File(sinhvien.anh!))
              : null,
          child: sinhvien.anh == null || !File(sinhvien.anh!).existsSync()
              ? Text(
                  sinhvien.ten.isNotEmpty ? sinhvien.ten[0].toUpperCase() : 'S',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        title: Text(
          sinhvien.ten,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sinhvien.email),
            Text(
              sinhvien.role,
              style: TextStyle(
                color: sinhvien.role == 'Admin' ? Colors.red : Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: canViewDetail
            ? Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: canViewDetail
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        SinhvienDetailPage(sinhvienId: sinhvien.id!),
                  ),
                );
              }
            : null,
      ),
    );
  }
}
