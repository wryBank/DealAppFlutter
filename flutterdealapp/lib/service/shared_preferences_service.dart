import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShardPreferencesService {
  Future writeCacghe({required String key, required value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSave = await prefs.setString('email', value);
    debugPrint('isSave: $isSave');
  }

  Future<String?> readCache({
    required String key,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    if (value != null) {
      return value;
    }
    return null;
  }

  Future<bool> removeCache({
    required String key,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRemove = await prefs.remove(key);
    
    return isRemove;
  }
}
