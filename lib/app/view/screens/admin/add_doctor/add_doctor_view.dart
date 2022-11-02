import 'dart:async';

import 'package:ehtooa/app/controller/add_doctor_provider.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../../resources/consts_manager.dart';
class AddDoctorView extends StatelessWidget {
 /* final formKey = GlobalKey<FormState>();
  final emailDoctor = TextEditingController();
  final passWord = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();*/


  @override
  Widget build(BuildContext context) {
    final addDoctorProvider = Provider.of<AddDoctorProvider>(context);
    return  ChangeNotifierProvider<AddDoctorProvider>(
        create: (_)=> AddDoctorProvider(),
        child: Consumer<AddDoctorProvider>(
            builder: (context, value, child) =>
      Scaffold(
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
            key: value.formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesAssets.backgroundAddDoctor,
                  height: Sizer.getW(context) * 0.4,
                ),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: value.name,
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
                    controller: value.emailDoctor,
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
                    controller: value.serialNumber,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }
                      if(val.length != 10){
                        return tr(LocaleKeys.valid_serial_doctor);
                      }
                      else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.chrome_reader_mode,
                    maxLength: null,
                    hintText: tr(LocaleKeys.serial_number)),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: value.phoneNumber,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }
                      else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.phone_android,
                    maxLength: null,
                    hintText: tr(LocaleKeys.phone_number)),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: value.passWord,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.lock_open,
                    maxLength: null,
                    hintText: tr(LocaleKeys.password)),
                SizedBox(height: AppSize.s20,),
                CustomTextFiled(
                    controller: value.description,
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
                ButtonApp(text: tr(LocaleKeys.add_doctor), onTap: () async {
                  if(value.formKey.currentState!.validate()){
                    Const.LOADIG(context);
                    final result =await value.addDoctor(context);
                    Navigator.of(context).pop();
                    if(result['status']){

                      addDoctorProvider.setState2((){});
                      Navigator.of(context).pop();

                    }
                  }
                })
              ],
            ),
          ),
        ),
      ),
    ),
    ));
  }
}
