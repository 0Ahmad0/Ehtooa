import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../model/utils/sizer.dart';


class CreateSessionsView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.create_session)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesAssets.backgroundSessionInteractive,
                  height: Sizer.getW(context) * 0.5,
                ),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: link,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }else if(!val.isURL){
                        return tr(LocaleKeys.valid_session);

                      }
                        else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.online_prediction,
                    maxLength: null,
                    hintText: tr(LocaleKeys.session_link)),
                SizedBox(height: AppSize.s20,),
                ButtonApp(text: tr(LocaleKeys.create_session), onTap: (){
                  if(formKey.currentState!.validate()){

                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
