import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../model/models.dart';
class ListSessionsView extends StatelessWidget {
  final List<InteractiveSessions>? sessions;

  const ListSessionsView({super.key, this.sessions});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.all_sessions)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppPadding.p10),
        itemCount: sessions!.length,
        itemBuilder: (_,index){
          return Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGray.withOpacity(.2),
              borderRadius: BorderRadius.circular(AppSize.s8)
            ),
            child: ListTile(
              leading: Text(sessions![index].name),
              subtitle: Text("${DateFormat().add_yMd().add_jm().format(DateTime.now())}"),
              trailing: InkWell(
                onTap: (){
                  Get.defaultDialog(
                    confirm: Row(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                Theme.of(context).primaryColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              tr(LocaleKeys.yes),
                              style: getLightStyle(
                                  color: ColorManager.white,
                                  fontSize: Sizer.getW(context) / 26),
                            )),
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                primary: ColorManager.error,
                                backgroundColor: ColorManager.error),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              tr(LocaleKeys.no),
                              style: getLightStyle(
                                  color: ColorManager.white,
                                  fontSize: Sizer.getW(context) / 26),
                            )),
                      ],
                    ),
                    titleStyle: getBoldStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color,
                        fontSize: Sizer.getW(context) / 22),
                    title: tr(LocaleKeys.are_you_sure),
                    content: Text(
                      tr(LocaleKeys.confirm_delete),
                      style: getRegularStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: Sizer.getW(context) / 24),
                    ),
                    radius: AppSize.s14,
                  );

                },
                child: Container(
          padding: EdgeInsets.all(AppPadding.p14),
          decoration: BoxDecoration(
          color: ColorManager.error,
          borderRadius: BorderRadius.circular(AppSize.s8)
          ),
                  child: Text(tr(LocaleKeys.delete),style: getRegularStyle(
                    color: ColorManager.white
                  ),),
                )
              ),
            ),
          );
        },
      ),
    );
  }
}
