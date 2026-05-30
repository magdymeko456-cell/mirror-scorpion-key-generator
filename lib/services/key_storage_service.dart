import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Service for storing generated keys locally
class KeyStorageService {
  static final KeyStorageService _instance = KeyStorageService._internal();
  static const String _keysKey = 'generated_keys';

  factory KeyStorageService() => _instance;
  KeyStorageService._internal();

  Future<List<Map<String, dynamic>>> getStoredKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final keysJson = prefs.getStringList(_keysKey) ?? [];
    
    return keysJson
        .map((key) => jsonDecode(key) as Map<String, dynamic>)
        .toList();
  }

  Future<void> saveKey(Map<String, dynamic> keyData) async {
    final prefs = await SharedPreferences.getInstance();
    final keysJson = prefs.getStringList(_keysKey) ?? [];
    
    keysJson.insert(0, jsonEncode(keyData));
    
    // Keep only last 100 keys
    if (keysJson.length > 100) {
      keysJson.removeRange(100, keysJson.length);
    }
    
    await prefs.setStringList(_keysKey, keysJson);
  }

  Future<void> clearAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keysKey);
  }

  Future<void> deleteKey(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final keysJson = prefs.getStringList(_keysKey) ?? [];
    
    if (index >= 0 && index < keysJson.length) {
      keysJson.removeAt(index);
      await prefs.setStringList(_keysKey, keysJson);
    }
  }
}
