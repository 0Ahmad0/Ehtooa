import 'package:animate_icons/animate_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/model/utils/local/change_theme.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/const.dart';
import '../../resources/color_manager.dart';


class SettingView extends StatelessWidget {
  bool language = false;
  bool theme = false;
  AnimateIconController c1 =  AnimateIconController();
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.setting)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: AppSize.s8
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    color: ColorManager.lightGray.withOpacity(.2)
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.only(
                    right: Advance.language?AppSize.s16:0,
                    left: Advance.language?0:AppSize.s16,
                  ),
                  title: ListTile(
                    title: Text(
                      tr(LocaleKeys.language),
                      style: getRegularStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizer.getW(context) * 0.035
                      ),
                    ),
                    leading: Icon(Icons.language),
                    subtitle: Text(
                      Advance.language
                          ? tr(LocaleKeys.english)
                          :tr(LocaleKeys.arabic)
                      ,style: getLightStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                    ),),

                  ),
                  children: [
                    ListTile(
                      onTap: ()async{
                        final _newLocale = Locale('en');
                        await context.setLocale(_newLocale);
                        Get.updateLocale(_newLocale);
                        // setState((){});
                        // print(context.locale);
                        // Advance.language = true;

                      },
                      title: Text(tr(LocaleKeys.english),style: getRegularStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizer.getW(context) * 0.035,
                      ),),
                      leading: SizedBox(),
                      trailing: Switch(
                        value: Advance.language,
                        onChanged: (val)async{

                          //
                          final _newLocale = Locale('en');
                          await context.setLocale(_newLocale);
                          Get.updateLocale(_newLocale);
                          Advance.language = true;

                        },
                      ),

                    ),
                    ListTile(
                      onTap: ()async{
                        final _newLocale = Locale('ar');
                        await context.setLocale(_newLocale);
                        Get.updateLocale(_newLocale);
                        // print(context.locale);
                        Advance.language = false;

                      },
                      title: Text(tr(LocaleKeys.arabic),style: getRegularStyle(
                        color:Theme.of(context).primaryColor,
                        fontSize: Sizer.getW(context) * 0.035,
                      ),),
                      leading: SizedBox(),
                      trailing: Switch(
                        value: !Advance.language,
                        onChanged: (val)async{
                          final _newLocale = Locale('ar');
                          await context.setLocale(_newLocale);
                          Get.updateLocale(_newLocale);
                          // //
                          Advance.language = false;
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSize.s8
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  color: ColorManager.lightGray.withOpacity(.2)
              ),
              child: ListTile(
                  title: Text(
                    tr(LocaleKeys.theme),
                    style: getRegularStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizer.getW(context) * 0.035
                    ),
                  ),
                  subtitle: Text(
                    appModel.darkTheme
                        ? tr(LocaleKeys.dark_mode)
                        :tr(LocaleKeys.light_mode)
                    ,style: getLightStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),),
                  leading: Icon(Icons.color_lens_outlined),
                  trailing: AnimateIcons(
                    startIcon:
                    appModel.darkTheme ? Icons.dark_mode : Icons.light_mode,
                    endIcon:
                    appModel.darkTheme ? Icons.dark_mode : Icons.light_mode,
                    controller: c1,
                    onStartIconPress: () {
                      appModel.darkTheme = !appModel.darkTheme;

                      return appModel.darkTheme;
                    },
                    onEndIconPress: () {
                      appModel.darkTheme = !appModel.darkTheme;

                      return appModel.darkTheme;
                    },
                  )
              ),

            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSize.s8
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  color: ColorManager.lightGray.withOpacity(.2)
              ),
              child: ListTile(
                  title: Text(
                    tr(LocaleKeys.contact),
                    style: getRegularStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizer.getW(context) * 0.035
                    ),
                  ),
                  subtitle: Text(
                    "",style: getLightStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),),
                  leading: Icon(Icons.contact_support),
                onTap: ()async{
                   await HomeProvider().goToUrl(context, 'mailto:${AppConstants.emailContact}');
                },
              ),

            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSize.s8
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  color: ColorManager.lightGray.withOpacity(.2)
              ),
              child: ListTile(
                  title: Text(
                    tr(LocaleKeys.logout),
                    style: getRegularStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizer.getW(context) * 0.035
                    ),
                  ),
                  subtitle: Text(
                    "",style: getLightStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),),
                  leading: Icon(Icons.logout),
                onTap: () async {
                  Const.LOADIG(context);
                  await profileProvider.logout(context);
                  Navigator.of(context).pop();
                },
              ),

            ),
            // Text(tr(LocaleKeys.language),style: getBoldStyle(color: ColorManager.redOTP),)
          ],
        ),
      ),
    );
  }
}
/*
                    Get.defaultDialog(
                      radius: AppSize.s8,
                      title: tr(LocaleKeys.contact),
                      titleStyle: getRegularStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: Sizer.getW(context) / 24
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(tr(LocaleKeys.type_message_here)),
                          const SizedBox(height: AppSize.s10),
                          TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: ColorManager.lightGray.withOpacity(.3),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            maxLength: 200,
                          ),
                          ButtonApp(text: tr(LocaleKeys.send), onTap: (){

                          })
                        ],
                      )
                    );

 */