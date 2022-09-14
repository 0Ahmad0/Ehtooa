import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/home/home_view.dart';
import 'package:ehtooa/app/view/screens/login/login_view.dart';
import 'package:ehtooa/app/view/screens/notification/notification_view.dart';
import 'package:ehtooa/app/view/screens/profile/profile_view.dart';
import 'package:ehtooa/app/view/screens/setting/setting_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/bottom_nav_bar_provider.dart';
import '../groups/group_view.dart';

class BottomNavBarView extends StatefulWidget {
  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  late List<Map<String, dynamic>> screens;

  @override
  void initState() {
    screens = [
      {"title": tr(LocaleKeys.profile), "content": ProfileView()},
      {"title": tr(LocaleKeys.home), "content": HomeView()},
      {"title": tr(LocaleKeys.notification), "content": NotificationView()},
      {"title": tr(LocaleKeys.groups), "content": GroupsView()},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavBarProvider>(
      create: (_) => BottomNavBarProvider(),
      child: Consumer<BottomNavBarProvider>(
        builder: (_, bottombar, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName: Text(
                      tr(LocaleKeys.name),
                      style: getRegularStyle(
                          color: ColorManager.white,
                          fontSize: Sizer.getW(context) / 24),
                    ),
                    accountEmail: Text(
                      tr(LocaleKeys.email),
                      style: getLightStyle(
                          color: ColorManager.white,
                          fontSize: Sizer.getW(context) / 28),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: FlutterLogo(),
                    ),
                  ),
                  _buildListTile(
                    text: tr(LocaleKeys.setting),
                    icon: Icons.settings,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SettingView()));
                    },
                  ),
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ),
                  _buildListTile(
                    text: tr(LocaleKeys.rate),
                    icon: Icons.star_rate,
                    onTap: (){
                      Const.SHOWRATEDIALOOG(context);
                    },
                  ),
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ),
                  _buildListTile(
                    text: tr(LocaleKeys.logout),
                    icon: Icons.logout,
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginView()));
                    },
                  ),
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ),
                ],
              ),
            ),
            appBar: AppBar(
                elevation: bottombar.currentIndex == 1 ? 0.0 : 4,
                title: Text(screens[bottombar.currentIndex]["title"])),
            body: screens[bottombar.currentIndex]["content"],
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.blackGray.withOpacity(.2),
                          blurRadius: 10)
                    ]),
                child: GNav(
                  onTabChange: (index) => bottombar.changeIndex(index),
                  textStyle: getLightStyle(
                      color: ColorManager.white,
                      fontSize: Sizer.getW(context) / 26),
                  selectedIndex: 1,
                  activeColor: ColorManager.white,
                  padding: EdgeInsets.all(AppSize.s12),
                  tabBackgroundColor: Theme.of(context).primaryColor,
                  tabMargin: EdgeInsets.symmetric(
                      vertical: AppMargin.m10, horizontal: AppMargin.m4),
                  tabs: [
                    GButton(
                      icon: Icons.person,
                      text: tr(LocaleKeys.profile),
                    ),
                    GButton(
                      icon: Icons.home_filled,
                      text: tr(LocaleKeys.home),
                    ),
                    GButton(
                      icon: Icons.notifications_active,
                      text: tr(LocaleKeys.notification),
                    ),
                    GButton(
                      icon: Icons.group,
                      text: tr(LocaleKeys.groups),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _buildListTile({text, icon, onTap}) {
    return ListTile(
      minVerticalPadding: AppPadding.p18,
      title: Text(
        text,
        style: getRegularStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: Sizer.getW(context) / 26),
      ),
      onTap: onTap,
      leading: Icon(icon),
    );
  }
}