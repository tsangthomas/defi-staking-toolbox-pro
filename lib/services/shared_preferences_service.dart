import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _isPaidKey = 'is_paid';

  Future<bool> isPaid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPaidKey) ?? false;
  }

  Future<void> setPaid(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPaidKey, value);
  }
}