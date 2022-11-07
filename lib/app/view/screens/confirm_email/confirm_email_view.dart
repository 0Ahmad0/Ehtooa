import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/forget_password/forget_password_view.dart';
import 'package:flutter/material.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../controller/login_provider.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_textfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
class ConfirmEmailView extends StatelessWidget {
  final email = TextEditingController();
  ConfirmEmailView({Key? key}) : super(key: key);

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
            CustomTextFiled(controller: email, validator: (String? val){}, onChange: null, prefixIcon: Icons.email, hintText: tr(LocaleKeys.email),maxLength: null,),
            const SizedBox(height: AppSize.s10,),
            ButtonApp(text: tr(LocaleKeys.email_verification),
                onTap: () async {
              Const.LOADIG(context);
              final result =await loginProvider.sendPasswordResetEmail(context, resetEmail: email.text);
              Navigator.of(context).pop();
              if(result['status']){
                Navigator.of(context).pop();
             /* Navigator.push(context, MaterialPageRoute(builder:
                   (ctx)=>ForgetPasswordView(email: email.text,)));*/
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

/**
Column(
mainAxisAlignment: MainAxisAlignment.center,

children: [
Text("HEloooask "),
const SizedBox(height: AppSize.s10,),
TextButton(onPressed: (){
Const.LOADIG(context);
}, child: Text("Verfi email"))
],
),*/