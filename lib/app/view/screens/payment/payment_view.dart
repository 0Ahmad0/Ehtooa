import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/groups_provider.dart';
import 'package:ehtooa/app/controller/payment_provider.dart';
import 'package:ehtooa/app/controller/profile_provider.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custome_button.dart';
class PaymentView extends StatelessWidget {
  late PaymentProvider paymentProvider;
  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);
    final  profileProvider= Provider.of<ProfileProvider>(context);
    final  groupsProvider= Provider.of<GroupsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.payment)),
      ),
      body: Form(
        key: paymentProvider.formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Sizer.getW(context)/2,
                  padding: const EdgeInsets.only(
                      right: AppSize.s40
                  ),
                  child: SvgPicture.asset(
                      "assets/images/payment_back1.svg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                      vertical: AppPadding.p10
                  ),
                  child: Column(
                    children: [
                      CustomTextFiled(
                        maxLength: null,
                          controller: paymentProvider.cardNumber,
                          validator: (String? val){
                            if(val!.trim().isEmpty){
                              return tr(LocaleKeys.field_required);
                            }else if(val.length != 16){
                              return tr(LocaleKeys.valid_card_number);
                            }else{
                              return null;
                            }
                          },
                          onChange: (val){},
                          prefixIcon: Icons.chrome_reader_mode,
                          hintText: tr(LocaleKeys.card_number)
                      ),
                      const SizedBox(height: AppSize.s10,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFiled(
                                maxLength: null,
                                controller: paymentProvider.cvv,
                                textInputType: TextInputType.number,
                                validator: (String? val){
                                  if(val!.trim().isEmpty){
                                    return tr(LocaleKeys.field_required);
                                  }else if(val.length != 3){
                                    return tr(LocaleKeys.valid_cvv);
                                  }else{
                                    return null;
                                  }
                                },
                                onChange: (val){},
                                prefixIcon: Icons.numbers,
                                hintText: tr(LocaleKeys.cvv)
                            ),
                          ),
                          const SizedBox(width: AppSize.s8,),
                          Expanded(
                            child: CustomTextFiled(
                              onTap: ()async{
                                await _selectDate(context);
                              },
                              readOnly: true,
                                maxLength: null,
                                controller: paymentProvider.dateCard,
                                validator: (String? val){
                                  if(val!.trim().isEmpty){
                                    return tr(LocaleKeys.field_required);
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                onChange: (val){},
                                prefixIcon: Icons.date_range,
                                hintText: tr(LocaleKeys.expiry)
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: AppSize.s10,),
                      CustomTextFiled(
                          maxLength: null,
                          textInputAction: TextInputAction.done,
                          controller: paymentProvider.name,
                          validator: (String? val){
                            if(val!.trim().isEmpty){
                              return tr(LocaleKeys.field_required);
                            }else {
                              return null;
                            }
                          },
                          onChange: (val){},
                          prefixIcon: Icons.person,
                          hintText: tr(LocaleKeys.name)
                      ),
                      const SizedBox(height: AppSize.s10,),
                      ButtonApp(
                        text: tr(LocaleKeys.payment),
                        onTap: () async {
                          Const.LOADIG(context);
                          late Group group;
                          bool isPayOld=false;
                          Timestamp datePayOld=Timestamp.now();
                          groupsProvider.groups.groups.forEach((element) {
                            if(element.id.contains(paymentProvider.idGroup)){
                              group=element;
                              if(group.listUserPay.containsKey(profileProvider.user.id)){
                                 isPayOld=true;
                                 datePayOld=group.listUserPay[profileProvider.user.id];
                              }
                              group.listUserPay[profileProvider.user.id]=Timestamp.now();
                            }
                          });
                          ///print("id group  ${group.toJson()} ${paymentProvider.idGroup}");
                          var result =await paymentProvider.payUser(context, group);
                          Navigator.pop(context);
                         if(result['status']){
                            Timer(
                                Duration(seconds: AppConstants.splashDelay - AppConstants.splashDelay),
                                    (){
                                  paymentProvider.setStat3((){});
                                  /// Navigator.pop(context);
                                  Get.defaultDialog(
                                      radius: AppSize.s14,
                                      title: tr(LocaleKeys.done_payment),
                                      titleStyle: getBoldStyle(
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                          fontSize: Sizer.getW(context) /20
                                      ),
                                      content: SvgPicture.asset(
                                        ImagesAssets.paymentDone,
                                        width: Sizer.getW(context)*0.35,
                                        height: Sizer.getW(context)*0.35,
                                      ),
                                      confirm:  TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColor,
                                            minimumSize: Size(double.infinity, 60),

                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }, child: Text(
                                        tr(LocaleKeys.ok),
                                        style: getLightStyle(
                                            color: ColorManager.white,
                                            fontSize: Sizer.getW(context) / 26
                                        ),
                                      ))
                                  );

                                }
                            );
                          }
                         else{
                           if(isPayOld){
                             group.listUserPay[profileProvider.user.id]=datePayOld;
                           }else{
                             group.listUserPay.remove(profileProvider.user.id);
                           }

                         }

                        //  Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: paymentProvider.selectedDate != null ? paymentProvider.selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );

    if (newSelectedDate != null) {
      paymentProvider.selectedDate = newSelectedDate;
      paymentProvider.dateCard
        ..text = DateFormat.yM().format(paymentProvider.selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: paymentProvider.dateCard.text.length,
            affinity: TextAffinity.upstream)
        );
    }
  }
}
