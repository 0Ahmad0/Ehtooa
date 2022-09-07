import 'dart:async';

import 'package:ehtooa/app/model/utils/local/change_theme.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/screens/on_boarding/on_boarding_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/models.dart';
import '../../../model/utils/local/storage.dart';
import '../../resources/consts_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  startDelay() async {
    //print("Advance==> ${Advance.isLogined}" );
    _timer =
        Timer(const Duration(seconds: AppConstants.splashDelay), await _goNext);
  }

  _goNext() async {
     Navigator.pushReplacement(
         context,
         CupertinoPageRoute(builder: (context) => OnBoardingView()
             //HomeView()
             // LoginView()

             ));
    //print("Advance==> ${Advance.isLogined}" );
    // Navigator.pushReplacementNamed(context, Routes.registerRoot);
    // bool isLoginedKEY =
    //     await AppStorage.storageRead(key: AppConstants.isLoginedKEY);
    // print("isLoginedKEY > ${isLoginedKEY}");
    // print("isLoginedKEY > ${await AppStorage.storageRead(key: AppStorage.languageKEY)}" );
    // if (await AppStorage.storageRead(key: AppConstants.isLoginedKEY) ||
    //     Advance.isLogined) {
    //   // Navigator.pushReplacement(
    //   //     context,
    //   //     CupertinoPageRoute(builder: (context) => Home()
    //   //         //HomeView()
    //   //         // LoginView()
    //   //
    //   //         ));
    // } else {
    //   // Navigator.pushReplacement(
    //   //     context, CupertinoPageRoute(builder: (context) => LoginView()));
    // }
    // // Get.changeTheme(getApplicationTheme(isDark:Advance.theme ));
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ZoomIn(
          duration: Duration(milliseconds: AppConstants.logoDelay),
          child: SvgPicture.asset(ImagesAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
