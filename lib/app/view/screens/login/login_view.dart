import 'package:ehtooa/app/controller/text_filed_provider.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/font_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
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
import '../../../controller/login_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../resources/values_manager.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  /*
  final email = TextEditingController();
  final password = TextEditingController();
  final keyForm = GlobalKey<FormState>();
*/
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    return  ChangeNotifierProvider<LoginProvider>(
        create: (_)=> LoginProvider(),
    child: Consumer<LoginProvider>(
    builder: (context, value, child) =>
     Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FadeInUpBig(child: SvgPicture.asset(fit: BoxFit.fill, ImagesAssets.loginBack)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s20, vertical: AppSize.s10),
                child: Form(
                  key: loginProvider.keyForm,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Sizer.getW(context) * 0.15,
                      ),
                      ZoomIn(
                        child: SvgPicture.asset(
                          ImagesAssets.splashLogo,
                          width: Sizer.getW(context) * 0.25,
                          height: Sizer.getW(context) * 0.25,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      ZoomIn(
                        child: Text(
                          tr(LocaleKeys.welcome_back),
                          style: getRegularStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: Sizer.getW(context) / 20),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      FadeInLeftBig(
                        child: Column(
                          children: [
                            CustomTextFiled(
                              controller: loginProvider.email,
                              maxLength: null,
                              validator: (String? val) {
                                if (val!.trim().isEmpty) {
                                  return tr(LocaleKeys.field_required);
                                } else if (!val.isEmail) {
                                  return tr(LocaleKeys.enter_valid_email);
                                } else {
                                  return null;
                                }
                              },
                              onChange: (val) {},
                              prefixIcon: Icons.email,
                              hintText: tr(LocaleKeys.email),
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
                                    controller: loginProvider.password,
                                    textInputAction: TextInputAction.done,
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
                            ),
                            ButtonApp(
                                text: tr(LocaleKeys.login),
                                onTap: () async {
                                  if (loginProvider.keyForm.currentState!.validate()) {
                                    Const.LOADIG(context);
                                    final result =await loginProvider.login(context);
                                    Navigator.of(context).pop();
                                    if(result['status']){
                                      profileProvider.user=User.fromJson(result['body']);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (ctx) => QuestionsView(indexTaken: [],)));
                                    }
                                  }
                                }),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tr(LocaleKeys.do_not_have_account)
                                  ,style: getMediumStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context) / 24
                                  ),),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                    ),
                                    onPressed: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SignupView()));
                                    }, child: Text(
                                    tr(LocaleKeys.signup),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    ),
    ));
  }
}
