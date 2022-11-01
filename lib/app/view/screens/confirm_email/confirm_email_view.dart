import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ConfirmEmailView extends StatelessWidget {
  const ConfirmEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p10

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("HEloooask "),
          const SizedBox(height: AppSize.s10,),
            TextButton(onPressed: (){
              Const.LOADIG(context);
            }, child: Text("Verfi email"))
          ],
        ),
      ),
    );
  }
}
