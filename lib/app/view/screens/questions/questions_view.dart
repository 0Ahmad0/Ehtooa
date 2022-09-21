import 'dart:async';

import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/questions_page/questions_page_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../../controller/profile_provider.dart';
import '../../resources/color_manager.dart';
import 'package:provider/provider.dart';

import '../login/login_view.dart';
class QuestionsView extends StatefulWidget {
   List<int> indexTaken;

  QuestionsView({
    super.key, required this.indexTaken
  });
  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  late List<String> textButtons;
  late List<String>  descriptionDisease;
  late List<String> diseaseName;
  late List<List<Question>> questionsList;
  @override
  void initState() {
    widget.indexTaken = [0,2,3];
    descriptionDisease = [
      LocaleKeys.ocd_description,
      LocaleKeys.ocd_description,
      LocaleKeys.sleep_description,
      LocaleKeys.anixiet_description
    ];
    diseaseName = [
      LocaleKeys.depression_text,
      LocaleKeys.ocd_text,
      LocaleKeys.sleep_disturbance_text,
      LocaleKeys.anxiety_text
    ];
    textButtons = [
      LocaleKeys.depression_criterion,
      LocaleKeys.Obsessive_compulsive_disorder_criterion,
      LocaleKeys.sleep_disturbance_criterion,
      LocaleKeys.anxiety_criterion,
    ];
   
    questionsList = [
      AppConstants.questionsDepression,
      AppConstants.questionsOcd,
      AppConstants.questionsSleepDisorders,
      AppConstants.questionsAnxiety,
    ];
    Timer(Duration(milliseconds: 0), () {
      Get.defaultDialog(
          onWillPop: () async => false,
          barrierDismissible: false,
          radius: AppSize.s14,
          contentPadding: EdgeInsets.zero,
          title: tr(LocaleKeys.mental_health),
          titleStyle: getBoldStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: Sizer.getW(context) / 22),
          content: Column(
            children: [
              Divider(
                thickness: AppSize.s1_5,
              ),
              Text(
                tr(LocaleKeys.content_intro),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: Sizer.getW(context) / 26),
              ),
              SizedBox(height: AppSize.s14,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppPadding.p12),
                color: Theme.of(context).primaryColor,
                child: Text(
                  tr(LocaleKeys.footer_intro),
                  style: getMediumStyle(
                      color: ColorManager.white,
                      fontSize: Sizer.getW(context) / 20),
                ),
              )
            ],
          ),
          confirm: Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    tr(LocaleKeys.start),
                    style: getRegularStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizer.getW(context) /26
                    ),
                  ))
            ],
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.mental_health)),
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginView()));
            },
            icon: Icon(Icons.logout),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s20,
            vertical: AppSize.s10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(tr(LocaleKeys.title_intro_questions),
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: Sizer.getW(context) / 24
                ),),
              SizedBox(height: AppSize.s20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  List.generate(4, (index) {
                    profileProvider.user.listUsedQuizzes.forEach((element) {
                      print(element == index);
                    });
                    return ButtonApp(
                      bottomMargin: AppSize.s20,
                      backColor: profileProvider.user.listUsedQuizzes[index]?
                      Colors.transparent : Theme.of(context).primaryColor,
                      text: tr(textButtons[index]),
                      onTap:  profileProvider.user.listUsedQuizzes[index]?()=>null:(){
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (ctx)=>
                              QuestionsPageView(
                                questions: questionsList[index],
                                diseaseName: diseaseName[index],
                                descriptionDisease: descriptionDisease[index],
                                index: questionsList.indexOf(questionsList[index]),
                              ),),);
                      },
                    );
                  })
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
