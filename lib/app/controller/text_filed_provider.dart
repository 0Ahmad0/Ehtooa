import 'package:flutter/material.dart';

class TextFiledProvider with ChangeNotifier{
  bool isPassword = true;

  void changeState(){
    isPassword = !isPassword;
    notifyListeners();
  }
}