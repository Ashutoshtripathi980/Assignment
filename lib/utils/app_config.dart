import 'package:flutter/cupertino.dart';

class AppConfig {
  static final AppConfig _appConfig = AppConfig._internal();

  factory AppConfig() {
    return _appConfig;
  }

  AppConfig._internal();

  ///:::PAT BASE URLS:::
  static const basePatUrl = "https://newsapi.org/v2/";

  get baseUrl => basePatUrl;
}
