import 'dart:async';

import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/questions_page/questions_page_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';

class QuestionsView extends StatefulWidget {
  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  @override
  void initState() {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.mental_health)),
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
                  fontSize: Sizer.getW(context) / 20
                ),),
              SizedBox(height: AppSize.s20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonApp(
                      text: tr(LocaleKeys.depression_criterion),
                      onTap: (){
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                            builder: (ctx)=>
                                QuestionsPageView(
                                  questions: [
                                    Question(
                                        questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                        answer: [
                                          Answer(
                                              answerText: "نعم بشدة",
                                              proportion: 10),
                                          Answer(
                                              answerText: "نعم ليس دائما",
                                              proportion: 8),
                                          Answer(
                                              answerText: "لا ادري",
                                              proportion: 5),
                                          Answer(
                                              answerText: "لا ابدا",
                                              proportion: 0),
                                        ]

                                    ),
                                    Question(
                                        questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                        answer: [
                                          Answer(
                                              answerText: "نعم بشدة",
                                              proportion: 10),
                                          Answer(
                                              answerText: "نعم ليس دائما",
                                              proportion: 8),
                                          Answer(
                                              answerText: "لا ادري",
                                              proportion: 5),
                                          Answer(
                                              answerText: "لا ابدا",
                                              proportion: 0),
                                        ]

                                    ),
                                  ],
                                ),),);
                      },
                    ),
                    SizedBox(height: AppSize.s20,),
                    ButtonApp(
                      text: tr(LocaleKeys.anxiety_criterion),
                      onTap: (){
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (ctx)=>
                              QuestionsPageView(
                                questions: [
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                ],
                              ),),);
                      },
                    ),
                    SizedBox(height: AppSize.s20,),
                    ButtonApp(
                      text: tr(LocaleKeys.Obsessive_compulsive_disorder_criterion),
                      onTap: (){
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (ctx)=>
                              QuestionsPageView(
                                questions: [
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                ],
                              ),),);
                      },
                    ),
                    SizedBox(height: AppSize.s20,),
                    ButtonApp(
                      text: tr(LocaleKeys.sleep_disturbance_criterion),
                      onTap: (){
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (ctx)=>
                              QuestionsPageView(
                                questions: [
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                  Question(
                                      questionText: "هل تعاني من الخوف عندما تكون لوحدك؟",
                                      answer: [
                                        Answer(
                                            answerText: "نعم بشدة",
                                            proportion: 10),
                                        Answer(
                                            answerText: "نعم ليس دائما",
                                            proportion: 8),
                                        Answer(
                                            answerText: "لا ادري",
                                            proportion: 5),
                                        Answer(
                                            answerText: "لا ابدا",
                                            proportion: 0),
                                      ]

                                  ),
                                ],
                              ),),);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
