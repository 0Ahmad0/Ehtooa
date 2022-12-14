import 'dart:async';

import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:ehtooa/app/view/screens/questions/questions_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/groups_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../model/models.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import '../../../model/utils/const.dart';
class QuestionsPageView extends StatefulWidget {
  late List<Question> questions;
  String descriptionDisease;
  String diseaseName;
  int index;

  QuestionsPageView({required this.questions,required this.descriptionDisease,required this.diseaseName,required this.index});

  @override
  State<QuestionsPageView> createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<QuestionsPageView> {
  late double testResult;
  @override
  void initState() {
    testResult = 0.0;
    Timer(Duration(milliseconds: 1), () {
      Get.defaultDialog(
          barrierDismissible: false,
          onWillPop: () async => false,
          title: tr(LocaleKeys.started_after10seconds)+"\n"+tr(widget.descriptionDisease),
          titleStyle: getRegularStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: Sizer.getW(context) / 30),
          content: CircularCountDownTimer(
            duration: AppConstants.splashDelay +6,
            initialDuration: 0,
            controller: CountDownController(),
            width: Sizer.getW(context) / 3.5,
            height: Sizer.getW(context) / 3.5,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Theme.of(context).primaryColor,
            fillGradient: null,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
            backgroundGradient: null,
            strokeWidth: AppSize.s18,
            strokeCap: StrokeCap.square,
            textStyle: getBoldStyle(
                color: ColorManager.white, fontSize: Sizer.getW(context) / 14),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: true,
            onStart: () {
              debugPrint('Countdown Started');
            },
            onComplete: () {
              Navigator.pop(context);
            },
          ));
    });
    super.initState();
  }

  bool isSelected = false;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);
    print(widget.index);
    return Scaffold(
        body: FutureBuilder(
            future: Future.delayed(Duration(seconds: AppConstants.splashDelay+7)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return FadeInLeft(
                  child: PageView.builder(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.questions.length,
                    itemBuilder: (_, index) {
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s20, vertical: AppSize.s10),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  Text(
                                   tr(widget.questions[index].questionText),
                                    textAlign: TextAlign.center,
                                    style: getMediumStyle(
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                        fontSize: Sizer.getW(context) / 18),
                                  ),
                                  SizedBox(
                                    height: AppSize.s40,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(AppSize.s14),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(AppSize.s14),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: widget.questions[index].answer.map((e) {
                                        return StatefulBuilder(
                                          builder: (_, setState1) {
                                            return InkWell(
                                              onTap: () {
                                                setState1(() {
                                                  isSelected = true;
                                                  testResult+=e.proportion;
                                                  print(testResult);
                                                });
                                                Timer(Duration(milliseconds: 500), () {
                                                  if (pageController.page ==
                                                      widget.questions.length - 1) {
                                                    Get.dialog(
                                                      Material(
                                                        color: Colors.transparent,
                                                        child: Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    AppSize.s14)),
                                                            width: Sizer.getW(context) -
                                                                AppSize.s20,
                                                            height: Sizer.getH(context) / 1.4,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                    child: Container(
                                                                      alignment: Alignment.center,
                                                                      width: double.infinity,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius.only(
                                                                              topLeft: Radius
                                                                                  .circular(

                                                                                  AppSize
                                                                                      .s14),
                                                                              topRight: Radius
                                                                                  .circular(
                                                                                  AppSize
                                                                                      .s14)),
                                                                          color: Theme.of(context)
                                                                              .primaryColor),
                                                                      child: Text(
                                                                        tr(LocaleKeys
                                                                            .complete_answer),
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                        style: getRegularStyle(
                                                                            color: ColorManager
                                                                                .white,
                                                                            fontSize: Sizer.getW(
                                                                                context) /
                                                                                22),
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                  padding: EdgeInsets.all(
                                                                      AppSize.s10),
                                                                  child: Text(
                                                                    (testResult*10 >50)
                                                                        ?tr(widget.diseaseName)
                                                                        :tr(LocaleKeys.good_mental_health),
                                                                    style: getBoldStyle(
                                                                        color:
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        fontSize: Sizer.getW(
                                                                            context) /
                                                                            20),
                                                                  ),
                                                                ),
                                                                if(testResult*10 >50)
                                                                    Expanded(
                                                                    child: Text(
                                                                      tr(LocaleKeys.add_to_group),
                                                                      textAlign: TextAlign.center,
                                                                      style: getRegularStyle(
                                                                          color: ColorManager
                                                                              .blackGray,
                                                                          fontSize: Sizer.getW(
                                                                              context) /
                                                                              22),
                                                                    )),
                                                                SvgPicture.asset(
                                                                  ImagesAssets.splashLogo,
                                                                  width: Sizer.getW(context) *
                                                                      0.2,
                                                                  height:
                                                                  Sizer.getW(context) *
                                                                      0.2,
                                                                ),
                                                                SizedBox(
                                                                  height: AppSize.s10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal: AppSize.s10),
                                                                  child: ButtonApp(
                                                                      text:  (testResult*10 >50)
                                                                          ?tr(LocaleKeys.ok)
                                                                          :tr(LocaleKeys.another_test),
                                                                      onTap: () async {
                                                                        profileProvider.user.listUsedQuizzes[widget.index]=true;

                                                                        Const.LOADIG(context);
                                                                        await profileProvider.editUser(context);
                                                                        Navigator.of(context).pop();
                                                                        Navigator.pop(context);
                                                                        if(testResult*10>50){
                                                                          Const.LOADIG(context);
                                                                          int indexGroup=homeProvider.fetchIndexGroupFromIndexList(index: widget.index);
                                                                          await homeProvider.addUserToGroup(context, idUser: profileProvider.user.id,
                                                                              idGroup: homeProvider.groups.groups[indexGroup].id);
                                                                          groupsProvider.groups.groups.add(homeProvider.groups.groups[indexGroup]);
                                                                          Navigator.of(context).pop();
                                                                          Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (ctx)=>BottomNavBarView()
                                                                            ),);
                                                                        }else{
                                                                          Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (ctx)=>QuestionsView(
                                                                                indexTaken: [index]
                                                                            )
                                                                            ),);
                                                                        }
                                                                      }),
                                                                ),
                                                                SizedBox(
                                                                  height: AppSize.s10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    print(pageController.page);
                                                    pageController.nextPage(
                                                        duration: Duration(milliseconds: 200),
                                                        curve: Curves.easeInCirc);
                                                    isSelected = false;
                                                  }
                                                });
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(milliseconds: 500),
                                                padding: EdgeInsets.all(AppSize.s20),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: AppSize.s10),
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Theme.of(context).primaryColor
                                                        : Colors.grey[300],
                                                    borderRadius:
                                                    BorderRadius.circular(AppSize.s14),
                                                    border: Border.all(
                                                        color: isSelected
                                                            ? Colors.transparent
                                                            : ColorManager.blackGray)),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.center,
                                                      width: Sizer.getW(context) * 0.075,
                                                      height: Sizer.getW(context) * 0.075,
                                                      decoration: BoxDecoration(
                                                          color: isSelected
                                                              ? Theme.of(context).primaryColor
                                                              : Colors.transparent,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              width: 2,
                                                              color: isSelected
                                                                  ? Colors.transparent
                                                                  : Theme.of(context)
                                                                  .primaryColor)),
                                                      child: Icon(
                                                        isSelected
                                                            ? Icons.check
                                                            : Icons.remove,
                                                        color: isSelected
                                                            ? ColorManager.white
                                                            : ColorManager.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: AppSize.s14,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        tr(e.answerText),
                                                        style: getRegularStyle(
                                                            color: isSelected
                                                                ? ColorManager.white
                                                                : Theme.of(context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .color,
                                                            fontSize: Sizer.getW(context) / 28),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              else
                return SizedBox(); // Return empty container to avoid build errors
            }
        )
        );
  }
}
