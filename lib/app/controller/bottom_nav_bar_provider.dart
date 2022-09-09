import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier{
  int currentIndex = 1;
  void changeIndex(index){
    currentIndex = index;
    notifyListeners();
  }
}