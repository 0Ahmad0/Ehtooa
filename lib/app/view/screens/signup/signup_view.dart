
import 'package:ehtooa/app/controller/text_filed_provider.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/font_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/screens/login/login_view.dart';
import 'package:ehtooa/app/view/screens/questions/questions_view.dart';
import 'package:ehtooa/app/view/screens/signup/signup_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../controller/profile_provider.dart';
import '../../../controller/signup_provider.dart';
import '../../resources/values_manager.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
 /*
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final keyForm = GlobalKey<FormState>();
*/
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    return  ChangeNotifierProvider<SignupProvider>(
        create: (_)=> SignupProvider(),
    child: Consumer<SignupProvider>(
    builder: (context, value, child) =>
        Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            FadeInDownBig(child: SvgPicture.asset(fit: BoxFit.fill, ImagesAssets.signupBack)),
            Expanded(child:Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s20, vertical: AppSize.s10),
              child: SingleChildScrollView(
                child: Form(
                  key: signupProvider.keyForm,
                  child: FadeInRightBig(
                    delay: Duration(milliseconds: AppConstants.onBoardingDelay),
                    child: Column(
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
                                tr(LocaleKeys.app_name),
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
                        CustomTextFiled(
                          controller: signupProvider.name,
                          maxLength: null,
                          validator: (String? val) {
                            if (val!.trim().isEmpty) {
                              return tr(LocaleKeys.field_required);
                            } else {
                              return null;
                            }
                          },
                          onChange: (val) {},
                          prefixIcon: Icons.person,
                          hintText: tr(LocaleKeys.name),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                        CustomTextFiled(
                          controller: signupProvider.email,
                          maxLength: null,
                          validator: (String? val) {
                            if (val!.trim().isEmpty) {
                              return tr(LocaleKeys.field_required);
                            } else if(!val.isEmail){
                              return tr(LocaleKeys.enter_valid_email);
                            }
                            else {
                              return null;
                            }
                          },
                          onChange: (val) {},
                          prefixIcon: Icons.email,
                          hintText: tr(LocaleKeys.email),
                          textInputAction: TextInputAction.next,
                        ),  SizedBox(
                          height: AppSize.s20,
                        ),
                        CustomTextFiled(
                          controller: signupProvider.phoneNumber,
                          maxLength: null,
                          validator: (String? val) {
                            if (val!.trim().isEmpty) {
                              return tr(LocaleKeys.field_required);
                            } else if(!val.isPhoneNumber){
                              return tr(LocaleKeys.enter_phoneNumber);
                            }
                            else {
                              return null;
                            }
                          },
                          onChange: (val) {},
                          prefixIcon: Icons.phone_android,
                          hintText: tr(LocaleKeys.phone_number),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: AppSize.s10,
                        ),
                        ChangeNotifierProvider<TextFiledProvider>(
                          create: (_)=>TextFiledProvider(),
                          child: Consumer<TextFiledProvider>(builder: (_, textFiled, c__) {
                            return TextFormField(
                                obscureText: textFiled.isPassword,
                                controller: signupProvider.password,
                                textInputAction: TextInputAction.next,
                                validator: (String? val) {
                                  if (val!.trim().isEmpty) {
                                    return tr(LocaleKeys.field_required);
                                  } else if (val.length < 6) {
                                    return tr(LocaleKeys.enter_password);
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(textFiled.isPassword?
                                  Icons.lock:Icons.lock_open),
                                  suffixIcon: IconButton(
                                    icon: Icon(textFiled.isPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      textFiled.changeState();
                                      print(textFiled.isPassword);
                                    },
                                  ),
                                  hintText: tr(
                                    LocaleKeys.password,
                                  ),
                                ));
                          }),
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),ChangeNotifierProvider<TextFiledProvider>(
                          create: (_)=>TextFiledProvider(),
                          child: Consumer<TextFiledProvider>(builder: (_, textFiled, c__) {
                            return TextFormField(
                                obscureText: textFiled.isPassword,
                                controller: signupProvider.confirmPassword,
                                textInputAction: TextInputAction.done,
                                validator: (String? val) {
                                  if (val!.trim().isEmpty) {
                                    return tr(LocaleKeys.field_required);
                                  } else if (signupProvider.password.text != signupProvider.confirmPassword.text) {
                                    return tr(LocaleKeys.confirm_password_match);
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(textFiled.isPassword?
                                  Icons.lock:Icons.lock_open),
                                  suffixIcon: IconButton(
                                    icon: Icon(textFiled.isPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      textFiled.changeState();
                                      print(textFiled.isPassword);
                                    },
                                  ),
                                  hintText: tr(
                                    LocaleKeys.confirm_password,
                                  ),
                                ));
                          }),
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                        ButtonApp(
                            text: tr(LocaleKeys.signup),
                            onTap: () async {
                              if (signupProvider.keyForm.currentState!.validate()) {
                                Const.LOADIG(context);
                              final result =await signupProvider.signup(context);
                              Navigator.of(context).pop();
                              if(result['status']){
                                profileProvider.user=User.fromJson(result['body']);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => QuestionsView(
                                          indexTaken: [],
                                        )));
                              }

                              }
                            }),
                  /*
                  SizedBox(
                          height: AppSize.s10,
                        ),
                        ButtonApp(
                            text: tr(LocaleKeys.yes),
                            onTap: () async {
                                Const.LOADIG(context);
                                final result =await signupProvider.signupAD(context);
                                Navigator.of(context).pop();
                                print(result);
                            }),*/
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
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (ctx)=>LoginView()));
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
                    ),
                  ),
                ),
              ),
            ),
            )
          ],
        )),
    ));
  }
}
