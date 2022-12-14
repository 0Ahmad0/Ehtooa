import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../controller/home_provider.dart';
import '../../../../controller/list_sessions_provider.dart';
import '../../../../model/models.dart';
import 'package:provider/provider.dart';

import '../../../../model/utils/const.dart';

class ListSessionsView extends StatelessWidget {
  final List<InteractiveSessions>? sessions;

  const ListSessionsView({super.key, this.sessions});

  @override
  Widget build(BuildContext context) {
    final listSessionsProvider = Provider.of<ListSessionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.all_sessions)),
      ),
      body: FutureBuilder(
        future: listSessionsProvider.fetchSessions(context),
        builder: (context, snapshot,) {
          //  print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Const.SHOWLOADINGINDECATOR();
            //Const.CIRCLE(context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              listSessionsProvider.sessions = Sessions.fromJson(data['body']);
              return ChangeNotifierProvider<ListSessionsProvider>.value(
                  value: listSessionsProvider,
                  child: Consumer<ListSessionsProvider>(
                      builder: (context, value, child) =>
                          ListView.builder(
                            padding: EdgeInsets.all(AppPadding.p10),
                            itemCount: value.sessions.sessions.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: AppMargin.m4),
                                padding: EdgeInsets.symmetric(
                                    vertical: AppPadding.p8
                                ),
                                decoration: BoxDecoration(
                                    color: ColorManager.lightGray.withOpacity(
                                        .2),
                                    borderRadius: BorderRadius.circular(
                                        AppSize.s8)
                                ),
                                child: ListTile(
                                  title: Text(
                                      value.sessions.sessions[index]
                                          .name /*sessions![index].name*/,
                                      style: getRegularStyle(color: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: Sizer.getW(context) / 26),
                                  ),
                                  subtitle: Text(
                                      "${DateFormat().add_yMd().add_jm().format(
                                          value.sessions.sessions[index]
                                              .date)}",
                                    style: getRegularStyle(color: ColorManager.lightGray,
                                      fontSize: Sizer.getW(context) / 30
                                    ),
                                  ),
                                  trailing: InkWell(
                                      onTap: () {
                                        Get.defaultDialog(
                                          confirm: Row(
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .primaryColor),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    Const.LOADIG(context);
                                                    final result = await value
                                                        .deleteSession(context,
                                                        idSession: value
                                                            .sessions
                                                            .sessions[index]
                                                            .id);
                                                    Navigator.of(context).pop();
                                                    if (result['status']) {
                                                      value.sessions.sessions
                                                          .removeAt(index);
                                                      value.notifyListeners();
                                                    }
                                                  },
                                                  child: Text(
                                                    tr(LocaleKeys.yes),
                                                    style: getLightStyle(
                                                        color: ColorManager
                                                            .white,
                                                        fontSize: Sizer.getW(
                                                            context) / 26),
                                                  )),
                                              const SizedBox(
                                                width: AppSize.s8,
                                              ),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      primary: ColorManager
                                                          .error,
                                                      backgroundColor: ColorManager
                                                          .error),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    tr(LocaleKeys.no),
                                                    style: getLightStyle(
                                                        color: ColorManager
                                                            .white,
                                                        fontSize: Sizer.getW(
                                                            context) / 26),
                                                  )),
                                            ],
                                          ),
                                          titleStyle: getBoldStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: Sizer.getW(context) /
                                                  22),
                                          title: tr(LocaleKeys.are_you_sure),
                                          content: Text(
                                            tr(LocaleKeys.confirm_delete),
                                            style: getRegularStyle(
                                                color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontSize: Sizer.getW(context) /
                                                    24),
                                          ),
                                          radius: AppSize.s14,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(AppPadding.p14),
                                        decoration: BoxDecoration(
                                            color: ColorManager.error,
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s8)
                                        ),
                                        child: Text(tr(LocaleKeys.delete),
                                          style: getRegularStyle(
                                              color: ColorManager.white
                                          ),),
                                      )
                                  ),
                                ),
                              );
                            },
                          )
                  ));
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
