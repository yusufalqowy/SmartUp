import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage('ThemeStorage');
  final _key = 'isThemeMode';

  ThemeMode get theme {
    bool? isDarkMode = _box.read(_key);
    if(isDarkMode == null){
      return ThemeMode.system;
    }
    if(isDarkMode){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }

  ChatTheme chatTheme(BuildContext context){
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    bool? isDarkMode = _box.read(_key);
    if(isDarkMode == null){
      return isDark ? const DarkChatTheme() : const DefaultChatTheme();
    }
    if(isDarkMode){
      return const DarkChatTheme();
    }else{
      return const DefaultChatTheme();
    }
  }

  bool isDarkMode() => _box.read(_key) ?? false;

  void saveThemeToBox(bool isDarkMode){
    _box.write(_key, isDarkMode);
  }


}