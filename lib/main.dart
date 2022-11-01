import 'package:camera/camera.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import 'package:ehtooa/app/controller/on_boarding_provider.dart';
import 'package:ehtooa/app/controller/text_filed_provider.dart';
import 'package:ehtooa/app/model/utils/local/change_theme.dart';
import 'package:ehtooa/app/view/resources/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/controller/add_doctor_provider.dart';
import 'app/controller/bottom_nav_bar_provider.dart';
import 'app/controller/create_sessions_provider.dart';
import 'app/controller/downloder_provider.dart';
import 'app/controller/global_member_provider.dart';
import 'app/controller/groups_provider.dart';
import 'app/controller/home_provider.dart';
import 'app/controller/list_sessions_provider.dart';
import 'app/controller/notification_provider.dart';
import 'app/controller/chat_provider.dart';
import 'app/controller/payment_provider.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
o(error){
  print(error);
}


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}
Future<void> main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await CustomGalleryPermissions.requestPermissionExtend();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
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
      fallbackLocale: Locale("en"),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
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
        Provider<GroupsProvider>(create: (_)=>GroupsProvider()),
        Provider<AddDoctorProvider>(create: (_)=>AddDoctorProvider()),
        Provider<HomeProvider>(create: (_)=>HomeProvider()),
        Provider<CreateSessionsProvider>(create: (_)=>CreateSessionsProvider()),
        Provider<ListSessionsProvider>(create: (_)=>ListSessionsProvider()),
        Provider<ChatProvider>(create: (_)=>ChatProvider()),
        Provider<NotificationProvider>(create: (_)=>NotificationProvider()),
        Provider<PaymentProvider>(create: (_)=>PaymentProvider()),
        Provider<GlobalMemberProvider>(create: (_)=>GlobalMemberProvider()),
        Provider<DownloaderProvider>(create: (_)=>DownloaderProvider()),
   //     Provider<CreateEnvironmentProvider>(create: (_)=>CreateEnvironmentProvider()),
      ],
      child: ChangeNotifierProvider<AppProvider>.value(
        value: appProvider,
        child:Consumer<AppProvider>(
          builder: (c, value, child) {
            print(appProvider.darkTheme);
            return GetMaterialApp(
              title: "Ehtooa",
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


