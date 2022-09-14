import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../controller/profile_provider.dart';

class ProfileView extends StatelessWidget {
  final name = TextEditingController(text: "أحمد الحريري");
  final email = TextEditingController(text: "Ahmad2001@gmail.com");
  bool nameIgnor = true;
  bool emailIgnor = true;
  //ProfileProvider profileProvider = ProfileProvider();
  @override

  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return  ChangeNotifierProvider<ProfileProvider>(
        create: (_)=> ProfileProvider(),
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) =>
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppPadding.p10,
                      horizontal: AppPadding.p20
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              children: [
                                StatefulBuilder(builder: (_, setState1) {
                                  return CustomTextFiled(
                                      onSubmit: (val) {
                                        nameIgnor = true;
                                        setState1(() {});
                                      },
                                      readOnly: nameIgnor,
                                      controller: name,
                                      validator: (String? val) {
                                        if (val!.isEmpty) {
                                          return tr(LocaleKeys.field_required);
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChange: (val) {},
                                      prefixIcon: Icons.person,
                                      maxLength: null,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          nameIgnor = false;
                                          profileProvider.user.name="f";
                                          setState1(() {});
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      hintText: tr(LocaleKeys.name));
                                }),
                                const SizedBox(height: AppSize.s20,),
                                StatefulBuilder(builder: (_, setState2) {
                                  return CustomTextFiled(
                                      onSubmit: (val) {
                                        emailIgnor = true;
                                        setState2(() {});
                                      },
                                      readOnly: emailIgnor,
                                      controller: email,
                                      validator: (String? val) {
                                        if (val!.isEmpty) {
                                          return tr(LocaleKeys.field_required);
                                        } else if (!val.isEmail) {
                                          return tr(LocaleKeys.enter_valid_email);
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChange: (val) {},
                                      prefixIcon: Icons.email,
                                      maxLength: null,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          emailIgnor = false;
                                          setState2(() {});
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      hintText: tr(LocaleKeys.email));
                                }),
                                const SizedBox(height: AppSize.s20,),
                                CustomTextFiled(
                                    readOnly: true,
                                    controller: TextEditingController(text: value.user.phoneNumber/*"055 895 658"*/),
                                    validator: (String? val) {},
                                    onChange: (val) {},
                                    prefixIcon: Icons.phone_android,
                                    maxLength: null,
                                    hintText: tr(LocaleKeys.phone_number)),
                                const SizedBox(height: AppSize.s20,),
                                StatefulBuilder(
                                  builder: (_, setState2) {
                                    return ButtonApp(
                                        text: tr(LocaleKeys.edit), onTap: () {
                                      emailIgnor = true;
                                      nameIgnor = true;
                                      setState2((){
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          )),
                    ],
                  )),
        ));
  }
}
