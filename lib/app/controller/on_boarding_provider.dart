import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier{
  bool isLastPage = false;
   isLastIndex(int index){
    if(index == 2){
      isLastPage = true;
      notifyListeners();
    }
   else{
     isLastPage =false;
     notifyListeners();
    }
  }

  List<OnBoarding> onBoardingList = [
    OnBoarding(image: ImagesAssets.onBoardingIMG1, text: LocaleKeys.on_boarding1),
    OnBoarding(image: ImagesAssets.onBoardingIMG2, text: LocaleKeys.on_boarding2),
    OnBoarding(image: ImagesAssets.onBoardingIMG3, text: LocaleKeys.on_boarding3),
  ];
}