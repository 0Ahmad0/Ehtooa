import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/admin/add_doctor/add_doctor_view.dart';
import 'package:ehtooa/app/view/screens/admin/create_sessions/create_sessions_view.dart';
import 'package:ehtooa/app/view/screens/home/home_view.dart';
import 'package:ehtooa/app/view/screens/login/login_view.dart';
import 'package:ehtooa/app/view/screens/notification/notification_view.dart';
import 'package:ehtooa/app/view/screens/profile/profile_view.dart';
import 'package:ehtooa/app/view/screens/setting/setting_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/bottom_nav_bar_provider.dart';
import '../../../controller/profile_provider.dart';
import '../groups/group_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomNavBarView extends StatefulWidget {
  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  late List<Map<String, dynamic>> screens;

  @override
  void initState() {
    super.initState();
  }
  filterSecreens(profileProvider){
    if(profileProvider.user.typeUser.contains(AppConstants.collectionDoctor)&& screens.length == 4){
      screens.removeAt(3);
    }else if(profileProvider.user.typeUser.contains(AppConstants.collectionAdmin)&& screens.length == 4){
      screens.removeAt(2);
    }
  }
  @override
  Widget build(BuildContext context) {
    screens = [
      {"title": tr(LocaleKeys.profile), "content": ProfileView()},
      {"title": tr(LocaleKeys.home), "content": HomeView()},
      {"title": tr(LocaleKeys.notification), "content": NotificationView()},
      {"title": tr(LocaleKeys.groups), "content": GroupsView()},
    ];
    final profileProvider = Provider.of<ProfileProvider>(context);
    filterSecreens(profileProvider);
    return ChangeNotifierProvider<BottomNavBarProvider>(
      create: (_) => BottomNavBarProvider(),
      child: Consumer<BottomNavBarProvider>(
        builder: (_, bottombar, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Drawer(
              child: Column(
                children: [
                  ChangeNotifierProvider<ProfileProvider>.value(
                      value: profileProvider,
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) =>
                            UserAccountsDrawerHeader(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor
                              ),
                              margin: EdgeInsets.zero,
                              accountName: Text(
                               // tr(LocaleKeys.name),
                                value.user.name,
                                style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 24),
                              ),
                              accountEmail: Text(
                               // tr(LocaleKeys.email),
                                value.user.email,
                                style: getLightStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 28),
                              ),
                              currentAccountPicture: value.user.photoUrl == null?
                              ProfilePicture(
                                name: value.user.name,
                                radius: AppSize.s30,
                                fontsize: Sizer.getW(context) / 22,

                              ):Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                ),
                                child:ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: Sizer.getW(context) * 0.12,
                                    height: Sizer.getW(context) * 0.12,
                                    imageUrl:
                                    // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                                    "${value.user.photoUrl}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              ),
                            ),
                      )),

                  _buildListTile(
                    text: tr(LocaleKeys.setting),
                    icon: Icons.settings,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SettingView()));
                    },
                  ),
                  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ):SizedBox(),
                  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
                  _buildListTile(
                    text: tr(LocaleKeys.add_doctor),
                    icon: Icons.add_box_outlined,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx)=>AddDoctorView()));
                    },
                  ):SizedBox(),
                  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ):SizedBox(),
                  (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
                  _buildListTile(
                    text: tr(LocaleKeys.create_session),
                    icon: Icons.cast_connected_sharp,
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (ctx)=>CreateSessionsView()));
                    },
                  ):SizedBox(),
                  Divider(
                    thickness: AppSize.s1_5,
                    height: 0.0,
                  ),
                  if(!(profileProvider.user.typeUser.contains(AppConstants.collectionAdmin)))
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
                    onTap: () async {
                      Const.LOADIG(context);
                      await profileProvider.logout(context);
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginView()));
                    },

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

                  tabs: (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
                  [GButton(
                      icon: Icons.person,
                      text: tr(LocaleKeys.profile),
                    ),
                    GButton(
                      icon: Icons.home_filled,
                      text: tr(LocaleKeys.home),
                    ),
                    GButton(
                      icon: Icons.group,
                      text: tr(LocaleKeys.groups),
                    ),
                  ]:(profileProvider.user.typeUser.contains(AppConstants.collectionDoctor))?
                    [GButton(
                    icon: Icons.person,
                    text: tr(LocaleKeys.profile),),
                    GButton(
                      icon: Icons.home_filled,
                      text: tr(LocaleKeys.home),
                    ),
                    GButton(
                      icon: Icons.notifications_active,
                      text: tr(LocaleKeys.notification),
                    ),
                    ]:
                    [GButton(
                    icon: Icons.person,
                        text: tr(LocaleKeys.profile),),
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
