// Màn hình quản lý danh sách ngành (chỉ admin)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/nganh_viewmodel.dart';
import '../models/nganh.dart';

class NganhListPage extends StatefulWidget {
  const NganhListPage({Key? key}) : super(key: key);

  @override
  State<NganhListPage> createState() => _NganhListPageState();
}

class _NganhListPageState extends State<NganhListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NganhViewModel>(context, listen: false).loadAllNganh();
    });
  }

  Future<void> _showNganhDialog({Nganh? nganh}) async {
    final tenController = TextEditingController(text: nganh?.tenNganh ?? '');
    final moTaController = TextEditingController(text: nganh?.moTa ?? '');
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(nganh == null ? 'Thêm ngành mới' : 'Chỉnh sửa ngành'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tenController,
                decoration: const InputDecoration(
                  labelText: 'Tên ngành *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên ngành';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: moTaController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả *',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final nganhViewModel = Provider.of<NganhViewModel>(
                  context,
                  listen: false,
                );

                final newNganh = Nganh(
                  id: nganh?.id,
                  tenNganh: tenController.text.trim(),
                  moTa: moTaController.text.trim(),
                );

                bool success;
                if (nganh == null) {
                  success = await nganhViewModel.addNganh(newNganh);
                } else {
                  success = await nganhViewModel.updateNganh(newNganh);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? (nganh == null
                                  ? 'Thêm thành công'
                                  : 'Cập nhật thành công')
                            : 'Lỗi',
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteNganh(Nganh nganh) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa ngành "${nganh.tenNganh}"?'),
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
      final nganhViewModel = Provider.of<NganhViewModel>(
        context,
        listen: false,
      );
      final success = await nganhViewModel.deleteNganh(nganh.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Đã xóa ngành' : 'Lỗi khi xóa'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Ngành học')),
      body: Consumer<NganhViewModel>(
        builder: (context, nganhViewModel, child) {
          if (nganhViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (nganhViewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(nganhViewModel.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => nganhViewModel.loadAllNganh(),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          final nganhList = nganhViewModel.nganhList;

          if (nganhList.isEmpty) {
            return const Center(child: Text('Chưa có ngành nào'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: nganhList.length,
            itemBuilder: (context, index) {
              final nganh = nganhList[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.school)),
                  title: Text(
                    nganh.tenNganh,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(nganh.moTa),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showNganhDialog(nganh: nganh),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNganh(nganh),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNganhDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
