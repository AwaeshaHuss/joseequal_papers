import 'package:flutter/material.dart';

class AppConsts{

  AppConsts._();

  // * Strings
  static const String appTitle = 'JosequalWallpapers';

  // * secretes
  static const String APIKey = 'k47avt8jCOdwRunWRwLhkQiWJCGVR8FTgIGi4ed285jdpinTbcT9fu8c';

  // * Network
  static const _baseUrl = 'https://api.pexels.com/v1/';

  static const searchUrl = '${_baseUrl}search?query=';

  // * MediaQueries
  static Size get size => MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
}