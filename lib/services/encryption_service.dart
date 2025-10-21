import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class EncryptionService {
  final _secureStorage = const FlutterSecureStorage();

  Future<Uint8List> getEncryptionKey() async {
    String? encodedKey = await _secureStorage.read(key: 'hive_encryption_key');
    if (encodedKey == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
        key: 'hive_encryption_key',
        value: base64UrlEncode(key),
      );
      return Uint8List.fromList(key);
    }
    return base64Url.decode(encodedKey);
  }
}