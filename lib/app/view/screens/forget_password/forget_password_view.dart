
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/confirm_email/confirm_email_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            ButtonApp(text: "email verfiy", onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ConfirmEmailView()))),
          ],
        ),
      ),
    );
  }
}
