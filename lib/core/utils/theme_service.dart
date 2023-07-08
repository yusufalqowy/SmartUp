import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isThemeMode';

  ThemeMode get theme => isDarkMode() ? ThemeMode.dark : ThemeMode.light;

  bool isDarkMode() => _box.read(_key) ?? false;


  void saveThemeToBox(bool isDarkMode){
    _box.write(_key, isDarkMode);
  }


}