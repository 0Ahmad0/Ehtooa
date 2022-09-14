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
class AddDoctorView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailDoctor = TextEditingController();
  final passWord = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_doctor)),
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
                  ImagesAssets.backgroundAddDoctor,
                  height: Sizer.getW(context) * 0.4,
                ),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: name,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.person,
                    maxLength: null,
                    hintText: tr(LocaleKeys.doctor_name)),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: emailDoctor,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }
                      else if(!val.isEmail){
                        return tr(LocaleKeys.enter_valid_email);
                      }
                      else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.email,
                    maxLength: null,
                    hintText: tr(LocaleKeys.doctor_email)),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: description,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.description,
                    maxLength: null,
                    hintText: tr(LocaleKeys.description)),
                SizedBox(height: AppSize.s20,),
                ButtonApp(text: tr(LocaleKeys.add_doctor), onTap: (){
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
