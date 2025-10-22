// Service xử lý Contacts (Danh bạ)
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  // Xin quyền truy cập danh bạ
  Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  // Lấy tất cả danh bạ
  Future<List<Contact>> getAllContacts() async {
    try {
      final hasPermission = await requestContactsPermission();
      if (!hasPermission) {
        print('Không có quyền truy cập danh bạ');
        return [];
      }

      List<Contact> contacts = await FlutterContacts.getContacts();
      return contacts;
    } catch (e) {
      print('Lỗi khi đọc danh bạ: $e');
      return [];
    }
  }

  // Chọn một contact
  Future<Contact?> pickContact() async {
    try {
      final hasPermission = await requestContactsPermission();
      if (!hasPermission) {
        print('Không có quyền truy cập danh bạ');
        return null;
      }

      Contact? contact = await FlutterContacts.openExternalPick();
      return contact;
    } catch (e) {
      print('Lỗi khi chọn contact: $e');
      return null;
    }
  }

  // Lấy số điện thoại từ contact
  String? getPhoneNumber(Contact contact) {
    if (contact.phones.isNotEmpty) {
      return contact.phones.first.number;
    }
    return null;
  }

  // Lấy email từ contact
  String? getEmail(Contact contact) {
    if (contact.emails.isNotEmpty) {
      return contact.emails.first.address;
    }
    return null;
  }
}
