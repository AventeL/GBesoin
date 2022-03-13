import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final storage = const FlutterSecureStorage();

  void storeIdGroup(int value) async {
    await storage.write(key: 'idGroup', value: value.toString());
  }

  Future<String?> readIdGroup() async {
    return await storage.read(key: 'idGroup');
  }

  void setToNullIdGroup() async {
    await storage.write(key: 'idGroup', value: null);
  }
}
