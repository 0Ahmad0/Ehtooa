
import 'package:flutter/material.dart';

import '../../../view/resources/consts_manager.dart';
import 'storage.dart';
class AppProvider extends ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    AppStorage.storageWrite(key: AppConstants.themeKEY,value: value);
    notifyListeners();
  }

}