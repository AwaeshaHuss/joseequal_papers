import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme =>
      ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: const ColorScheme.light(),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0.0
          ));

/*
  static const primaryColor = Color(0XFF50565A);
  static const secondaryColor = Color(0XFFE5E5E5);
  static const lightGreyColor = Color(0XFF84888B);
  static const darkScaffoldbColor = Color(0XFF32383D);
  static const splashColor = Color(0XFF343c3c);
  static const greenColor = Color(0xFF2E7D32);
  static const redColor = Color(0XFFa80712);
  static const amberColor = Color(0Xfffccc00);
*/
}
