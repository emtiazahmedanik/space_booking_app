import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';
  static const String _userIdKey = 'userIdKey';

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null;
  }

  static Future<void> saveToken(String token, String? id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id ?? '');
  }


  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_idKey);
  }


  static Future<void> saveUserId(String userId) async {
    await _preferences?.setString(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    String? id = _preferences?.getString(_userIdKey);
    return id;
  }

  static String? get userId => _preferences?.getString(_idKey);

  static String? get token => _preferences?.getString(_tokenKey);
}
