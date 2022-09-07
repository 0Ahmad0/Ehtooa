import 'dart:async';

import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class QuestionsView extends StatefulWidget {
  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 0), () {
      Get.defaultDialog(
          radius: AppSize.s14,
          contentPadding: EdgeInsets.zero,
          title: tr(LocaleKeys.mental_health),
          titleStyle:
              getBoldStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: Sizer.getW(context) / 22
              ),
          content: Column(
            children: [
              Text(tr(LocaleKeys.content_intro),
              textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: Sizer.getW(context) / 26
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppPadding.p12),
                color: Theme.of(context).primaryColor,
                child: Text(tr(LocaleKeys.footer_intro)),
              )
            ],
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.questions)),
      ),
    );
  }
}
