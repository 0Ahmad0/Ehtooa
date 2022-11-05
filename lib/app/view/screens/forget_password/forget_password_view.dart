
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/confirm_email/confirm_email_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../controller/login_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../model/utils/const.dart';
class ForgetPasswordView extends StatelessWidget {
  final email,code;
  ForgetPasswordView({super.key, this.email,this.code});
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool validatePassword(String value) {
    return regex.hasMatch(value);
  }
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20
              ,
          vertical: AppPadding.p10
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFiled(controller: newPassword, validator: (String? val){
              if(val!.trim().isEmpty){
                return tr(LocaleKeys.field_required);
              }
              if((val.length < 8 || !validatePassword(val))){
                return tr(LocaleKeys.enter_password);
              }else{
                return null;
              }
            }, onChange: null, prefixIcon: Icons.lock, hintText: "new password",maxLength: null,),
            const SizedBox(height: AppSize.s10,),
            CustomTextFiled(controller: confirmPassword, validator: (String? val){
              if(val!.trim().isEmpty){
                return tr(LocaleKeys.field_required);
              }
              if((val.length < 8 || !validatePassword(val))){
                return tr(LocaleKeys.enter_password);
              }else{
                return null;
              }
            }, onChange: null, prefixIcon: Icons.lock, hintText: "new password",maxLength: null,),
            const SizedBox(height: AppSize.s10,),
            ButtonApp(text:tr(LocaleKeys.email_verification),
                onTap: () async {
                    Const.LOADIG(context);
                    final result =await loginProvider.confirmPasswordReset(context, newPassword: newPassword.text,code: code);
                    Navigator.of(context).pop();
                    if(result['status']){
                       Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (ctx)=>ConfirmEmailView()));
                    }
                    FocusManager.instance.primaryFocus!.unfocus();

                }
            ),
          ],
        ),
      ),
    );
  }
}
