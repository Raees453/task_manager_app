import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _storage;

  LocalStorage();

  Future<SharedPreferences> initialise() async {
    _storage ??= await SharedPreferences.getInstance();

    return _storage!;
  }

  String? read(String key, {bool decode = false}) {
    if (kDebugMode) {
      log(key, name: 'Local Storage Read: $key', time: DateTime.now());
    }

    return _storage!.get(key)?.toString();
  }

  bool? readBool(String key) {
    if (kDebugMode) {
      log(key, name: 'Local Storage Read: $key', time: DateTime.now());
    }

    return _storage!.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    if (kDebugMode) {
      log(key, name: 'Local Storage Read: $key', time: DateTime.now());
    }

    await _storage!.setBool(key, value);
  }

  Future<void> write(String key, String value) async {
    if (kDebugMode) {
      log(value, name: 'Local Storage Write: $key', time: DateTime.now());
    }

    await _storage!.setString(key, value);
  }

  Future<void> clear(String key) async {
    if (kDebugMode) {
      log(key, name: 'Local Storage Clear: $key', time: DateTime.now());
    }

    await _storage!.remove(key);
  }

  Future<bool> clearAll() async {
    return await _storage!.clear();
  }
}
