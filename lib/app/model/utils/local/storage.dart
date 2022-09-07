import 'dart:math';

import 'package:get_storage/get_storage.dart';

import '../../../view/resources/consts_manager.dart';
import '../../models.dart';

class AppStorage {
  static GetStorage _storage = GetStorage();


  static init() async {
    if (!_storage.hasData(AppConstants.isLoginedKEY)) {
      storageWrite(key: AppConstants.isLoginedKEY, value: false);
    } else {
      Advance.isLogined = await storageRead(key: AppConstants.isLoginedKEY);
    }
    if (!_storage.hasData(AppConstants.languageKEY)) {
      storageWrite(key: AppConstants.languageKEY, value: true);
    } else {
      Advance.language = await storageRead(key: AppConstants.languageKEY);
    }

    if (!_storage.hasData(AppConstants.themeKEY)) {
      storageWrite(key: AppConstants.themeKEY, value: false);
    } else {
      Advance.theme = await storageRead(key: AppConstants.themeKEY);
      //print("a${Advance.theme}");
    }

  }

  static Future<void> storageWrite({key, value}) async =>
      await _storage.write(key, value);

  static Future<dynamic> storageRead({key}) async => await _storage.read(key);

  static Future<void> storageDelete({key}) async => await _storage.remove(key).then((value) => print("delete key successful"));
static depose() async {
  await _storage.remove(AppConstants.idKEY);
  await _storage.remove(AppConstants.phoneNumberKEY);
  await _storage.write(AppConstants.isLoginedKEY, false);
}

}