// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'strings_manager.dart';
//
// class Routes{
//   static const String splashRoot = '/';
//   static const String loginRoot = '/login';
//   static const String registerRoot = '/register';
//   static const String onBoardingRoot = '/onBoarding';
//   static const String mainRoot = '/main';
//   static const String storeDetailsRoot = '/storeDetails';
// }
//
//
// class RoutesGenerator{
//   static Route<dynamic> getRoute(RouteSettings settings){
//     switch(settings.name){
//       case Routes.splashRoot:
//       return MaterialPageRoute(builder: (_)=> SplashView());
//        case Routes.loginRoot:
//       return MaterialPageRoute(builder: (_)=>const LoginView());
//        case Routes.registerRoot:
//       return MaterialPageRoute(builder: (_)=>const RegisterView());
//         default:
//       return undefinedRoute();
//     }
//   }
//   static Route<dynamic> undefinedRoute(){
//     return MaterialPageRoute(builder: (_)=>Scaffold(
//       appBar: AppBar(
//         title:  Text(AppStrings.noRouteFound),
//       ),
//       body:  Center(child: Text(AppStrings.noRouteFound)),
//     ));
//   }
// }