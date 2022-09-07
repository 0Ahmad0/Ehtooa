import 'package:flutter/material.dart';

class TextFiledProvider with ChangeNotifier{
  bool isPassword = false;

  void changeState(){
    isPassword = !isPassword;
    notifyListeners();
  }
}