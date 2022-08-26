import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigTheme extends ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;
  String locale = 'en';
  changeLang(String newLang)async{
    if(locale == newLang)return;
    locale = newLang;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLang',newLang);
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme)async{
    if(themeMode == newTheme)return;
    themeMode = newTheme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
 }

}