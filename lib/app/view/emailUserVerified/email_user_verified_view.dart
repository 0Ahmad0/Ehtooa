import 'dart:async';
import 'dart:convert';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:path/path.dart';
import '../../controller/profile_provider.dart';
import 'package:provider/provider.dart';

import '../resources/values_manager.dart';
import '../screens/get_data/get_data_view.dart';
import '../screens/login/login_view.dart';


class EmailUserVerifiedView extends StatefulWidget {
  @override
  State<EmailUserVerifiedView> createState() => _EmailUserVerifiedViewState();
}

class _EmailUserVerifiedViewState extends State<EmailUserVerifiedView> {
  var auth = FirebaseAuth.instance;
  var user=FirebaseAuth.instance.currentUser;
  var getIsEmailUserVerified;
  ProfileProvider profileProvider = ProfileProvider();

  @override
  void initState() {
    sendEmailVerification();
    getIsEmailUserVerifiedFuc();
    super.initState();
  }
  Future<bool> sendEmailVerification() async {
        if(user!= null){
          await user?.reload();
          print('email : ${user?.email}');
          print('emailVerified : ${user?.emailVerified}');
           final resulte =await user?.sendEmailVerification().then((value) => 'sendEmailVerification').catchError(FirebaseFun.onError);
          //  final resulte =await FirebaseAuth.instance.sendPasswordResetEmail(email: profileProvider.user.email).then((value) => 'sendPasswordResetEmail').catchError(FirebaseFun.onError);
          print(resulte);
          return true;
        }else
        return false;
  }
   getIsEmailUserVerifiedFuc() {
    getIsEmailUserVerified = FirebaseAuth.instance.userChanges();
  //  FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) => print("sendEmailVerification "));
    return getIsEmailUserVerified;
  }
  @override
  Widget build(BuildContext context) {
     profileProvider = Provider.of<ProfileProvider>(context);
     auth.currentUser!.reload();
    return
      Scaffold(
          body: Column(
            children: [
              FadeInDownBig(child: SvgPicture.asset(fit: BoxFit.fill, ImagesAssets.signupBack)),
              Expanded(child:Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s20, vertical: AppSize.s40),
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ZoomIn(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  //'Email Verification',
                                  tr(LocaleKeys.email_verification),
                                  style: getRegularStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context) / 22),
                                ),
                                SizedBox(
                                  width: AppSize.s6,
                                ),
                                Icon(Icons.email,color: Theme.of(context).backgroundColor,),
                                Text(
                                  '',
                                  //   tr(LocaleKeys.app_name),
                                  style: getRegularStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Sizer.getW(context) / 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSize.s4,),
                          InkWell(
                            onTap: (){
                              profileProvider.logout(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginView()));
                            },
                            child: Text(
                                 tr(LocaleKeys.logout),
                              style: getRegularStyle(
                                  color: Theme.of(context).primaryColor,
                                 fontSize: Sizer.getW(context) / 24
                                ),
                            ),
                          ),
                          SizedBox(height: AppSize.s20,),
                          StreamBuilder<User?>(
                            //prints the messages to the screen0
                              stream:  getIsEmailUserVerifiedFuc(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return
                                    widgetWaitIsVerifiedFromEmail(context);
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
                                    final dataUser=snapshot.data;
                                    bool isEmailVerified=false;
                                    print('displayName:${user!.displayName}');
                                    print('emailVerified:${user!.emailVerified}');
                                    print('isEmailVerified:${dataUser?.emailVerified}');
                                    if(dataUser!=null){
                                      isEmailVerified=dataUser!.emailVerified;
                                    }
                                    if(!isEmailVerified)
                                    return widgetDoneSendVerifiedEmail(context);

                                    else
                                     return widgetDoneVerifiedEmail(context);

                                    /// }));
                                  } else {
                                    return const Text('Empty data');
                                  }
                                }
                                else {
                                  return Text('State: ${snapshot.connectionState}');
                                }
                              }),

                        ],
                      )

                ),
              ),
            ],
          ));
  }
  buildEmailUserVerifiedView(context){

  }
  widgetWaitIsVerifiedFromEmail(context){
    return Column(
      children: [
        Text(
          tr(LocaleKeys.authentication_checked),
        //    'Authentication is being checked ..'
        ),
        SizedBox(height: AppSize.s10,),
       // Const.LOADIG(context),

      ],
    );
  }
  widgetVerifiedFromEmail(){

  }
  widgetDoneSendVerifiedEmail(context){
    return ( Column(
      children: [
        Text(
          tr(LocaleKeys.verification_link_sent_email),
           // 'A verification link has been sent to your email'
        ),
        Text('${profileProvider.user.email}',style: TextStyle(color: Theme.of(context).primaryColor),),
        SizedBox(height: AppSize.s10,),
        ButtonApp(
          fontSize: Sizer.getW(context)/24,

            text:
            tr(LocaleKeys.verification),
       // 'verification',
            //tr(LocaleKeys.confirm_unban),
            onTap: () async {
            await user!.reload();
           // print("ffff ${auth.currentUser!.emailVerified}");
            }),

      ],
    ));
  }
  widgetDoneVerifiedEmail(context){
    Timer(Duration(seconds: 2),(){
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
        builder: (ctx) =>
        GetDataView()
        ));
        });
    return Column(
      children: [

        Text(
          tr(LocaleKeys.email_verified),
           // 'Email Verified'
        ),
        SizedBox(height: AppSize.s10,),
      ],
    );
  }
}