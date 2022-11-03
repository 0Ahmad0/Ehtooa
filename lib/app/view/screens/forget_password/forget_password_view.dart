
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/confirm_email/confirm_email_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
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
            CustomTextFiled(controller: newPassword, validator: (String? val){}, onChange: null, prefixIcon: Icons.lock, hintText: "new password",maxLength: null,),
            const SizedBox(height: AppSize.s10,),
            CustomTextFiled(controller: confirmPassword, validator: (String? val){}, onChange: null, prefixIcon: Icons.lock, hintText: "new password",maxLength: null,),
            const SizedBox(height: AppSize.s10,),
            ButtonApp(text: "email verfiy",
                onTap: () async {
                    Const.LOADIG(context);
                    final result =await loginProvider.confirmPasswordReset(context, newPassword: newPassword.text,code: code);
                    Navigator.of(context).pop();
                    if(result['status']){
                       Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (ctx)=>ConfirmEmailView()));
                    }
                  }
            ),
          ],
        ),
      ),
    );
  }
}
