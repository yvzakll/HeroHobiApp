import 'dart:convert';

import 'package:heroapp/models/hobby_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HobiYonetimi {
  static SharedPreferences? _prefs;
  static List<Hobi> _hobiler = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadHobiler();
  }

  static void _loadHobiler() {
    String? hobilerJson = _prefs?.getString('hobiler');
    if (hobilerJson != null) {
      Iterable decoded = jsonDecode(hobilerJson);
      _hobiler = List<Hobi>.from(decoded.map((x) => Hobi.fromJson(x)));
    }
  }

  static List<Hobi> getHobiler() {
    return _hobiler;
  }

  static void addHobi(Hobi hobi) {
    _hobiler.add(hobi);
    _save();
  }

  static void removeHobi(String id) {
    _hobiler.removeWhere((h) => h.id == id);
    _save();
  }

  static void updateHobi(Hobi yeniHobi) {
    int index = _hobiler.indexWhere((h) => h.id == yeniHobi.id);
    if (index != -1) {
      _hobiler[index] = yeniHobi;
      _save();
    }
  }

  static void _save() {
    String encodedData = jsonEncode(_hobiler);
    _prefs?.setString('hobiler', encodedData);
  }
}
