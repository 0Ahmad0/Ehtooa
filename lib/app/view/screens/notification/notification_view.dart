import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import '../../../controller/groups_provider.dart';
import '../../../controller/home_provider.dart';
import '../../../controller/notification_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../controller/utils/firebase.dart';
class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
    return Container(
        child: FutureBuilder(
          future: notificationProvider.fetchSessionsIdUser(
              context, groups: groupsProvider.groups.groups,
              paySession: profileProvider.paySession,
          idUser: profileProvider.user.id, typeUser: profileProvider.user.typeUser
          ),
          builder: (context, snapshot,) {
            //  print(snapshot.error);
            if (snapshot.connectionState == ConnectionState.waiting) {

              return SizedBox(height: Sizer.getH(context) / 2.35,
                  child: Const.SHOWLOADINGINDECATOR());
              //Const.CIRCLE(context);
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return StatefulBuilder(
                  builder: (_, setState1) {
                    if (notificationProvider.sessionsToUser.length>0) {
                      // return Const.SHOWLOADINGINDECATOR();
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p20, vertical: AppPadding.p10),
                        itemCount: notificationProvider.sessionsToUser.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () async {
                              if(notificationProvider.sessionsToUser[index].isSold){
                                await homeProvider.goToUrl(context,notificationProvider.sessionsToUser[index].id_link);
                              }else{
                                Const.TOAST(context,textToast: FirebaseFun.findTextToast("This session not pay"));
                              }
                            },
                            child: FadeInRightBig(
                              child: Container(
                                height: Sizer.getW(context) * 0.25,
                                padding: EdgeInsets.all(AppPadding.p10),
                                margin: EdgeInsets.symmetric(vertical: AppMargin.m8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppSize.s14),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: FlutterLogo(),
                                    ),
                                    const SizedBox(width: AppSize.s10,),
                                    Text(
                                      //"الجلسة العلاجية رقم ${index}"
                                     "${notificationProvider.sessionsToUser[index].name}"
                                      ,style: getRegularStyle(
                                        color: ColorManager.white,
                                        fontSize: Sizer.getW(context) / 24
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset(
                            ImagesAssets.noNotifications,
                            width: Sizer.getW(context) - AppSize.s40,
                          ),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          Text(
                            tr(LocaleKeys.no_notification_yet),
                            textAlign: TextAlign.center,
                            style: getMediumStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: Sizer.getW(context) / 20),
                          )
                        ],
                      );
                    }
                  },
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),

    );
  }
}
