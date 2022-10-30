import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:ehtooa/app/controller/groups_provider.dart';
import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/controller/utils/create_environment_provider.dart';
import 'package:ehtooa/app/controller/text_filed_provider.dart';
import 'package:ehtooa/app/model/models.dart' as model;
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/font_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/screens/groups/group_view.dart';
import 'package:ehtooa/app/view/screens/questions/questions_view.dart';
import 'package:ehtooa/app/view/screens/signup/signup_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../controller/profile_provider.dart';
import 'package:provider/provider.dart';

import '../resources/values_manager.dart';
import '../screens/login/login_view.dart';


class EmailUserVerifiedView extends StatefulWidget {
  @override
  State<EmailUserVerifiedView> createState() => _EmailUserVerifiedViewState();
}

class _EmailUserVerifiedViewState extends State<EmailUserVerifiedView> {

  var getIsEmailUserVerified;
  ProfileProvider profileProvider = ProfileProvider();
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
      url: 'https://www.example.com/finishSignUp?cartId=1234',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ehtooa',
      androidPackageName: 'com.example.ehtooa',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

  @override
  void initState() {
    getIsEmailUserVerifiedFuc();
    super.initState();
  }
  temp() async {
    return await FirebaseAuth.instance.currentUser;
  }
  getIsEmailUserVerifiedFuc() {

    getIsEmailUserVerified = FirebaseAuth.instance.userChanges();
  //  FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) => print("sendEmailVerification "));
    return getIsEmailUserVerified;
  }
  @override
  Widget build(BuildContext context) {
     profileProvider = Provider.of<ProfileProvider>(context);
    // FirebaseAuth.instance.sendPasswordResetEmail(email: profileProvider.user.email).then((value) => print("sendPasswordResetEmail"));
     //profileProvider
    return
      Scaffold(
          body: Column(
            children: [
              FadeInDownBig(child: SvgPicture.asset(fit: BoxFit.fill, ImagesAssets.signupBack)),
              Expanded(child:Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s20, vertical: AppSize.s10),
                      child:  StreamBuilder<User?>(
                        //prints the messages to the screen0
                          stream: getIsEmailUserVerified,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                                //Const.LOADIG(context);
                              /// Const.SHOWLOADINGINDECATOR();
                            }
                            else if (snapshot.connectionState ==
                                ConnectionState.active) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                /// Const.SHOWLOADINGINDECATOR();
                               // Const.LOADIG(context);
                              //  print("d");
                                var dataUser=snapshot.data;
                                print(dataUser!.displayName);
                                return Column(
                                  children: [
                                    ZoomIn(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            tr(LocaleKeys.welcome_signup),
                                            style: getRegularStyle(
                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                fontSize: Sizer.getW(context) / 22),
                                          ),
                                          Text(
                                            '${snapshot.data!.displayName} ${snapshot.data!.emailVerified}',
                                            //   tr(LocaleKeys.app_name),
                                            style: getRegularStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: Sizer.getW(context) / 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppSize.s20,
                                    ),
                                    ButtonApp(
                                        text: tr(LocaleKeys.signup),
                                        onTap: () async {
                                          FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) => print('sendEmailVerification'));
                                          //FirebaseAuth.instance.currentUser?.updateDisplayName("displayName");
                                        }),
                                    SizedBox(
                                      height: AppSize.s10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(tr(LocaleKeys.already_have_account)
                                          ,style: getMediumStyle(
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                              fontSize: Sizer.getW(context) / 24
                                          ),),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero
                                            ),
                                            onPressed: (){
                                              setState(() {

                                              });
                                              // Navigator.pushReplacement(context,
                                              //       MaterialPageRoute(builder: (ctx)=>LoginView()));
                                            }, child: Text(
                                            tr(LocaleKeys.login),
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Theme.of(context).primaryColor,
                                                fontSize: Sizer.getW(context) / 22,
                                                fontFamily:context.locale == "en"
                                                    ?FontConstance.fontFamilyEN
                                                    :FontConstance.fontFamilyAR
                                            )))
                                      ],
                                    )
                                  ],
                                );

                                /// }));
                              } else {
                                return const Text('Empty data');
                              }
                            }
                            else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          }),

                ),
              ),
            ],
          ));
  }
  buildEmailUserVerifiedView(context){

  }
}
