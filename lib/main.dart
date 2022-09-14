import 'package:ehtooa/app/controller/on_boarding_provider.dart';
import 'package:ehtooa/app/controller/text_filed_provider.dart';
import 'package:ehtooa/app/model/utils/local/change_theme.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/globals.dart';
import 'package:ehtooa/app/view/screens/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app/controller/bottom_nav_bar_provider.dart';
import 'app/controller/login_provider.dart';
import 'app/controller/profile_provider.dart';
import 'app/controller/signup_provider.dart';
import 'app/view/resources/theme_manager.dart';
import 'app/view/screens/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'translations/codegen_loader.g.dart';
import 'package:get/get.dart';
o(error){
  print(error);
}
void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  await Globals.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      startLocale: Locale('ar'),
      fallbackLocale: Locale("ar"),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  AppProvider appProvider = new AppProvider();

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => AppProvider()),
        Provider<OnBoardingProvider>(create: (_)=>OnBoardingProvider()),
        Provider<TextFiledProvider>(create: (_)=>TextFiledProvider()),
        Provider<BottomNavBarProvider>(create: (_)=>BottomNavBarProvider()),
        Provider<ProfileProvider>(create: (_)=>ProfileProvider()),
        Provider<SignupProvider>(create: (_)=>SignupProvider()),
        Provider<LoginProvider>(create: (_)=>LoginProvider()),
      ],
      child: ChangeNotifierProvider<AppProvider>.value(
        value: appProvider,
        child:Consumer<AppProvider>(
          builder: (c, value, child) {
            print(appProvider.darkTheme);
            return GetMaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              home: SplashView(),
              theme: getApplicationTheme(isDark: appProvider.darkTheme),
            );
          })
      ),);
  }
}

