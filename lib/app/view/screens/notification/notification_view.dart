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
class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: Future.delayed(Duration(seconds: 3), () {}),
      builder: (_, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          // return Const.SHOWLOADINGINDECATOR();
          return ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20, vertical: AppPadding.p10),
            itemCount: 15,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: (){},
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
                        Text("الجلسة العلاجية رقم ${index}",style: getRegularStyle(
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
    ));
  }
}
