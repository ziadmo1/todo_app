import 'package:flutter/material.dart';

class MyTheme{

  static Color primaryBlue = Color(0xFF5D9CEC);
  static Color lightGreen = Color(0xFFDFECDB);
  static Color darkColor = Color(0xFF060E1E);
  static Color bottomColor = Color(0xFF141922);


  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      shape: StadiumBorder(
         side: BorderSide(color: Colors.white,width: 3)
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF61E757)
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: primaryBlue,
        fontWeight: FontWeight.bold
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
      titleMedium: TextStyle(
        fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
      labelSmall: TextStyle(
          fontSize: 20,
          color: lightGreen,
          fontWeight: FontWeight.bold
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: primaryBlue,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(
        size: 32
      ),
    ),
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: lightGreen,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white
      ),
        toolbarHeight: 100,
        color: primaryBlue,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    ),
    bottomAppBarColor: Colors.white

  );

  static ThemeData darkTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        shape: StadiumBorder(
            side: BorderSide(color: Colors.black,width: 3)
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          displaySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          bodyMedium: TextStyle(
              fontSize: 18,
              color: primaryBlue,
              fontWeight: FontWeight.bold
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontSize: 20,
            color: lightGreen,
            fontWeight: FontWeight.bold
          ),
          titleMedium: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        titleSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF61E757)
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(
            size: 32
        ),
      ),
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: darkColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
          toolbarHeight: 100,
          color: primaryBlue,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),

      ),
        bottomAppBarColor: bottomColor
  );

}