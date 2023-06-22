import 'package:flutter/material.dart';

extension WidgetsMargin on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}


extension ValidateString on String {

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = RegExp(r"^[a-zA-Z0-9._-]{3,16}$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
final passwordRegExp = 
    RegExp(r"^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#\$%^&+=])(?=\S+$).{4,}$");
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^(?:\+|0)[0-9]{9,}$");
    return phoneRegExp.hasMatch(this);
  }

}